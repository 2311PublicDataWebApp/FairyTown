package com.fairytown.ft.user.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.service.UserService;

import jakarta.servlet.http.HttpSession;


@Controller
public class UserController {
	
	@Autowired
	private UserService uService;
	
	// 로그인
		@PostMapping("/user/login.ft")
		public String userLogin(UserVO uOne, HttpSession session, Model model) {
			try {
				UserVO user = uService.checkuserLogin(uOne);
				if (user != null) {
					session.setAttribute("userId", user.getUserId());
					session.setAttribute("userName", user.getUserName());
					return "redirect:/";
				} else {
					model.addAttribute("msg", "No Data Found");
					return "common/errorPage";
				}			
			} catch (Exception e) {
				model.addAttribute("msg", e.getMessage());
				return "common/errorPage";
			}
		}
		
		// 로그아웃
		@GetMapping("/user/logout.ft")
		public String userLogout(jakarta.servlet.http.HttpSession session, Model model) {
			session.invalidate();
			return "redirect:/";
		}
	
	
	
	
}
