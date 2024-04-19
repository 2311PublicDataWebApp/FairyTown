package com.fairytown.ft.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fairytown.ft.user.domain.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {

	
		// 채팅창 이동
		@GetMapping("/chat.ft")
		public String showChatForm() {
			return "goods/chat";
		}
		
}
