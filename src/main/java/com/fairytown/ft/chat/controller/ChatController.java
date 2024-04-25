package com.fairytown.ft.chat.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.chat.domain.vo.ChatVO;
import com.fairytown.ft.chat.service.ChatService;
import com.fairytown.ft.goods.domain.vo.CartVO;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.domain.vo.OrderVO;
import com.fairytown.ft.user.domain.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {

		@Autowired
		private ChatService cService;
	
		// 채팅창 이동
		@GetMapping("/chat.ft")
		public String showChatForm() {
			return "goods/chat";
		}
		
		// 메시지 담기
		@ResponseBody
		@PostMapping(value = "/chat/addMsg.ft")
		public int addMsg(@ModelAttribute ChatVO chat, HttpSession session) throws Exception {
			int result = 0;
			UserVO uOne = (UserVO) session.getAttribute("user");
			
			if(uOne != null) {
				chat.setMsgSendId(uOne.getUserId());
				result = cService.insertaddMsg(chat);
				if ("ADMIN".equals(uOne.getUserAdmin())) {
					cService.updateMsg(chat);
				}
			}
			return result;
		}
		
		// 메시지 삭제
		@ResponseBody
		@PostMapping(value = "/chat/deleteMsg.ft")
		public int deleteMsg(@ModelAttribute ChatVO chat, HttpSession session) throws Exception {
			int result = 0;
			result = cService.deleteMsg(chat);
			return result;
		}
		
		//채팅 내용 조회
		@ResponseBody
		@PostMapping(value = "/chat/msgList.ft")
		public List<ChatVO> msgList(@RequestParam("chatUserId") String chatUserId){
			List<ChatVO> msgList = cService.selectMsgByChatId(chatUserId);
			return msgList;
		}
		
		// 어드민 채팅 목록
 		@GetMapping("/admin/chatList.ft")
 	    public ModelAndView ShowAdminChatList(ModelAndView mv, @ModelAttribute ChatVO chat, HttpSession session,
 	            @RequestParam(value="page", 
 	            required=false, defaultValue="1") Integer currentPage) {
 			try {
 				List<ChatVO> cList = cService.selectChatList();
 				mv.addObject("cList", cList);
 				mv.setViewName("goods/adminChatList");
 			} catch (Exception e) {
 				// TODO: handle exception
 				mv.addObject("msg", e.getMessage());
 				mv.setViewName("common/errorPage");
 			}
 			return mv;
 	    };
 	    // 어드민 답장 안 한 채팅 목록
 	    @GetMapping("/admin/noAnswerChat.ft")
 	    public ModelAndView ShowAdminNoChatList(ModelAndView mv, @ModelAttribute ChatVO chat, HttpSession session,
 	    		@RequestParam(value="page", 
 	    		required=false, defaultValue="1") Integer currentPage) {
 	    	try {
 	    		List<ChatVO> cList = cService.selectNoChatList();
 	    		mv.addObject("cList", cList);
 	    		mv.setViewName("goods/adminNoChatList");
 	    	} catch (Exception e) {
 	    		// TODO: handle exception
 	    		mv.addObject("msg", e.getMessage());
 	    		mv.setViewName("common/errorPage");
 	    	}
 	    	return mv;
 	    };
 	    
 	    
 	  @ResponseBody
 	  @RequestMapping(value="/weather/info.ft")
 	  public String weather() throws Exception {
 	      LocalDateTime now = LocalDateTime.now();

 	      // 쿼리스트링 셋팅을 위한 초기 시간 설정
 	      LocalDateTime targetTime = now;
 	      String responseData = null;

 	      while (true) {
 	    	  System.out.println("targetTime : " + targetTime);
 	          // 날짜 포맷을 지정
 	          DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
 	          DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH00");

 	          String dateFormatterStr = targetTime.format(dateFormatter);
 	          String timeFormatterStr = targetTime.format(timeFormatter);

 	          // 쿼리스트링 셋팅
 	          String reqURL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
 	          reqURL += "?serviceKey=AzT5taFN%2BwtHgXa3vYxvhgOxoeZrkWGJrXpWRlPZUpznN8FtuMJscPRchXzIJyoei4l64%2BcmYegdF4NOOYLY1g%3D%3D";
 	          reqURL += "&numOfRows=10";
 	          reqURL += "&pageNo=1";
 	          reqURL += "&base_date=" + dateFormatterStr;
 	          reqURL += "&base_time=" + timeFormatterStr;
 	          reqURL += "&nx=64";
 	          reqURL += "&ny=120";
 	          reqURL += "&dataType=json";

 	          URL request = new URL(reqURL);
 	          HttpURLConnection conn = (HttpURLConnection) request.openConnection();
 	          conn.setRequestMethod("GET");

 	          BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
 	          responseData = "";
 	          String line;
 	          while ((line = br.readLine()) != null) {
 	              responseData += line;
 	          }
 	          br.close();
 	          conn.disconnect();
 	          System.out.println("reqURL: " + reqURL);
 	          System.out.println("responseData: " + responseData);

 	          // JSON 파싱
 	          JSONParser parser = new JSONParser();
 	          JSONObject jsonObject = (JSONObject) parser.parse(responseData);
 	          JSONObject response = (JSONObject) jsonObject.get("response");
 	          JSONObject header = (JSONObject) response.get("header");
 	          String resultCode = (String) header.get("resultCode");

 	          if (resultCode.equals("00")) {
 	              // 결과 코드가 00이면 반복문 종료
 	              break;
 	          } else {
 	              // 결과 코드가 00이 아니면 이전 시간으로 설정하여 다시 시도
 	              targetTime = targetTime.minusHours(1);
 	          }
 	      }

 	      return responseData;
 	  }

}
