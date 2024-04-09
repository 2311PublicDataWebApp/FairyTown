package com.fairytown.ft.user.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class UserController {

		@GetMapping("/user/login.ft")
	    public String login(){
	        return "user/login";
	    }
		//로그인 실패
		@GetMapping("/common/error.ft")
	    public String denied(){
	        return "common/errorPage";
	    }
		// 로그아웃
		@GetMapping("/user/logout.ft")
		public String userLogout(jakarta.servlet.http.HttpSession session, Model model) {
			session.invalidate();
			return "redirect:/";
		}
	
		//회원가입 폼 조회
		@GetMapping("/user/register.ft")
		public ModelAndView showRegisterForm(ModelAndView mv) {
			mv.setViewName("user/register");
			return mv;
		}
		//회원 등록(회원가입)
		@PostMapping("/user/register.ft")
		public ModelAndView userRegister(ModelAndView mv) {
			try {
				
				
				mv.setViewName("user/register");			
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
	
	
	
}
