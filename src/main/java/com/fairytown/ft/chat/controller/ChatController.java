package com.fairytown.ft.chat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.chat.domain.vo.ChatVO;
import com.fairytown.ft.chat.service.ChatService;
import com.fairytown.ft.goods.domain.vo.CartVO;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
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
				if (uOne.getUserAdmin() == "ADMIN") {
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

}
