package com.fairytown.ft.goods.controller;



import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.apache.commons.lang3.RandomStringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.CartVO;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.domain.vo.OrderVO;
import com.fairytown.ft.goods.service.CartService;
import com.fairytown.ft.goods.service.OrderService;
import com.fairytown.ft.user.domain.vo.UserVO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {
		
	
		@Autowired
		private OrderService oService;
		
		// 굿즈 주문
		@PostMapping(value="/goods/order.ft")
		public String orderInsert(@ModelAttribute OrderVO order
				, @ModelAttribute GoodsVO goods
				, @RequestParam("roadAddress") String roadAddress
				, @RequestParam("detailAddress") String detailAddress
				, @RequestParam("sum") int sum
				, @RequestParam("goodsArray") String goodsString
				, @RequestParam("merchant_uid") String merchant_uid
				)throws Exception{
			 
			Calendar cal = Calendar.getInstance();
			 int year = cal.get(Calendar.YEAR);
			 String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
			 String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));
			 String subNum = "";
			 
			 for(int i = 1; i <= 6; i ++) {
			  subNum += (int)(Math.random() * 10);
			 }
			 
			 String goodsOrderCode = ymd + "_" + subNum;
			 String address = roadAddress + " " +detailAddress;
			 order.setGoodsOrderCode(goodsOrderCode);
			 order.setGoodsOrderAddress(address);
			 order.setGoodsSum(sum);
			 order.setMerchantUid(merchant_uid);
			 oService.insertOrder(order);
			// 주문 상세 정보 저장
			 JSONArray goodsArray = new JSONArray();
			 String [] tempGoods = goodsString.split("/");
			 // String -> JSONObject parsing 
			//2. Parser
	        JSONParser jsonParser = new JSONParser();
	        //3. To Object
	        //4. To JsonObject
			 for(String temp : tempGoods) {
				 JSONObject jsonObj = new JSONObject(temp);
				 goodsArray.put(jsonObj);
			 }
		    for(int i = 0; i < goodsArray.length(); i++) {
		    	Object obj = goodsArray.get(i);
		        if(obj instanceof JSONObject) {
			        JSONObject jsonCartItem = (JSONObject) obj;
			        // 여기서부터 jsonObject에서 상품 정보 추출 및 저장
			        Integer cartGoodsCode = jsonCartItem.getInt("cartGoodsCode");
			        String cartUserId = jsonCartItem.getString("cartUserId");
			        int cartStock = jsonCartItem.getInt("cartStock");

			        // 상세 주문 정보 설정 및 저장
			        OrderVO orderDetail = new OrderVO();
			        orderDetail.setGoodsOrderCode(goodsOrderCode);
			        orderDetail.setGoodsCode(cartGoodsCode);
			        orderDetail.setGoodsOrderUserId(cartUserId);
			        orderDetail.setGoodsOrderCnt(cartStock);
			        oService.insertOrderDetail(orderDetail);
			        oService.orderReset(orderDetail);
			        oService.minusStock(orderDetail);
		        }
			 }
			 //oService.cartDelete(userId);
		  
		  return "redirect:/goods/orderDetail.ft?goodsOrderCode="+goodsOrderCode;
		}
		
		// 주문 상세조회
	    @GetMapping("/goods/orderDetail.ft")
	    public ModelAndView showOrderDetail(ModelAndView mv
	    		, @RequestParam("goodsOrderCode") String goodsOrderCode) {
			try {
				List<OrderVO> oList = oService.selectByOrderCode(goodsOrderCode);
				mv.addObject("oList", oList);
				mv.setViewName("goods/orderDetail");
				
			} catch (Exception e) {
				// TODO: handle exception
				mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
			}
			return mv;
		}
	    
	    // 주문 목록
 		@GetMapping("/goods/orderList.ft")
 	    public ModelAndView ShowOrderList(ModelAndView mv, @ModelAttribute OrderVO order, HttpSession session,
 	            @RequestParam(value="page", 
 	            required=false, defaultValue="1") Integer currentPage) {
 			try {
 				UserVO uOne = (UserVO) session.getAttribute("user");
				String userId = uOne.getUserId();
				order.setGoodsOrderUserId(userId);
 				int totalCount = oService.getTotalCount(userId);
 				PageInfo pi = this.getPageInfo(currentPage, totalCount);
 				List<OrderVO> oList = oService.selectOrderList(pi, userId);
 				mv.addObject("oList", oList);
 				mv.addObject("totalCount", totalCount);
 				mv.addObject("pi", pi);
 				mv.setViewName("goods/orderlist");
 			} catch (Exception e) {
 				// TODO: handle exception
 				mv.addObject("msg", e.getMessage());
 				mv.setViewName("common/errorPage");
 			}
 			return mv;
 	    };
 	 
	   // 주문 취소
	   @PostMapping("/goods/cancelPay.ft")
	   public String refundRequest(@RequestParam("merchantUid") String merchant_uid
			   , @RequestParam("goodsOrderCode") String goodsOrderCode
			   , @ModelAttribute OrderVO order
			   , @RequestParam("cancelArray") String cancelString
			   ) throws IOException {
	        URL url = new URL("https://api.iamport.kr/payments/cancel");
	        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
	        try {
	        	String access_token = this.getToken();
				// 요청 방식을 POST로 설정
				conn.setRequestMethod("POST");
				
				// 요청의 Content-Type, Accept, Authorization 헤더 설정
				conn.setRequestProperty("Content-type", "application/json");
				conn.setRequestProperty("Accept", "application/json");
				conn.setRequestProperty("Authorization", access_token);
				
				// 해당 연결을 출력 스트림(요청)으로 사용
				conn.setDoOutput(true);
				
				// JSON 객체에 해당 API가 필요로하는 데이터 추가.
				JsonObject json = new JsonObject();
				json.addProperty("merchant_uid", merchant_uid);
				
				// 출력 스트림으로 해당 conn에 요청
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				bw.write(json.toString());
				bw.flush();
				bw.close();
				
				// 입력 스트림으로 conn 요청에 대한 응답 반환
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				br.close();
				conn.disconnect();
				
				order.setMerchantUid(merchant_uid);
				order.setGoodsOrderCode(goodsOrderCode);
//				order.setGoodsOrderCnt(cartStock);
				
				 JSONArray cancelArray = new JSONArray();
				 String [] tempGoods = cancelString.split("/");
				 // String -> JSONObject parsing 
				//2. Parser
		        JSONParser jsonParser = new JSONParser();
		        //3. To Object
		        //4. To JsonObject
				 for(String temp : tempGoods) {
					 JSONObject jsonObj = new JSONObject(temp);
					 cancelArray.put(jsonObj);
				 }
			    for(int i = 0; i < cancelArray.length(); i++) {
			    	Object obj = cancelArray.get(i);
			        if(obj instanceof JSONObject) {
			        	JSONObject jsonCartItem = (JSONObject) obj;
				        // 여기서부터 jsonObject에서 상품 정보 추출 및 저장
				        Integer goodsCode = jsonCartItem.getInt("goodsCode");
				        Integer goodsOrderCnt = jsonCartItem.getInt("goodsOrderCnt");
			        	order.setGoodsCode(goodsCode);
				        order.setGoodsOrderCnt(goodsOrderCnt);
				        oService.plusStock(order);
			        }
			    }
				
				oService.deleteOrder(order);
				oService.deleteOrderDetail(order);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        return "redirect:/";
	    }

		
	    public String getToken() throws Exception {

			HttpsURLConnection conn = null;
			URL url = new URL("https://api.iamport.kr/users/getToken");

			conn = (HttpsURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-type", "application/json");
			conn.setRequestProperty("Accept", "application/json");
			conn.setDoOutput(true);
			JsonObject json = new JsonObject();

			json.addProperty("imp_key", "1427278628450732");
			json.addProperty("imp_secret", "Qc5DxZ23ske23u0xhPOYZ9n596pjNb3l6O4GJfsb2Sa4v4Prk4rMg84VEcFuf9Ow94wqyZH1dKNMe69Y");
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			
			bw.write(json.toString());
			bw.flush();
			bw.close();

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

			Gson gson = new Gson();

			String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();


			String token = gson.fromJson(response, Map.class).get("access_token").toString();

			br.close();
			conn.disconnect();

			return token;
		}
	    
	    // 페이징
	    private PageInfo getPageInfo(Integer currentPage, int totalCount) {
			PageInfo pi = null;
			int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
			
			pi = new PageInfo(currentPage, totalCount, boardLimit);
			return pi;
		}
}
