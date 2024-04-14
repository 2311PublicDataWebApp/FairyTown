package com.fairytown.ft.goods.controller;



import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONArray;
import org.json.JSONObject;
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

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderController {
		
	
		@Autowired
		private OrderService oService;
	
		@PostMapping(value="/goods/order.ft")
		public String orderInsert(@ModelAttribute OrderVO order
				, @RequestParam("roadAddress") String roadAddress
				, @RequestParam("detailAddress") String detailAddress
				, @RequestParam("sum") int sum
				, @RequestParam("goodsArray") JSONArray goodsArray
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
			 oService.insertOrder(order);
			// 주문 상세 정보 저장
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
				OrderVO order = oService.selectByOrderCode(goodsOrderCode);
				if (order != null) {
					mv.addObject("order", order).setViewName("goods/orderDetail");
				} else {
					mv.addObject("msg", "데이터 불러오기가 완료되지 못했습니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				// TODO: handle exception
				mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
			}
			return mv;
		}
		
//	    // 환불
//	    public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken"; 
//	    
//	    public static final String KEY = "1427278628450732";
//	    public static final String SECRET = "Qc5DxZ23ske23u0xhPOYZ9n596pjNb3l6O4GJfsb2Sa4v4Prk4rMg84VEcFuf9Ow94wqyZH1dKNMe69Y";     
//	    // 아임포트 인증(토큰)을 받아주는 함수 
//	    public String getImportToken() { 
//	        String result = ""; 
//	        HttpClient client = HttpClientBuilder.create().build();
//	        HttpPost post = new HttpPost(IMPORT_TOKEN_URL); 
//	        Map<String,String> m =new HashMap<String,String>(); 
//	        m.put("imp_key", KEY); 
//	        m.put("imp_secret", SECRET); 
//	        try { post.setEntity(new UrlEncodedFormEntity(convertParameter(m))); 
//	            HttpResponse res = client.execute(post); 
//	            ObjectMapper mapper = new ObjectMapper(); 
//	            String body = EntityUtils.toString(res.getEntity()); 
//	            JsonNode rootNode = mapper.readTree(body); 
//	            JsonNode resNode = rootNode.get("response"); 
//	            result = resNode.get("access_token").asText(); 
//	        } catch (Exception e) { 
//	            e.printStackTrace(); 
//	        } 
//	        
//	        return result;
//	    } 

		
	    // 페이징
	    private PageInfo getPageInfo(Integer currentPage, int totalCount) {
			PageInfo pi = null;
			int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
			
			pi = new PageInfo(currentPage, totalCount, boardLimit);
			return pi;
		}
}
