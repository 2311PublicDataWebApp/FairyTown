package com.fairytown.ft.user.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class UserController {

		@Autowired
    	private PasswordEncoder passwordEncoder;
	
		private final UserService uService;
	
		//회원탈퇴 페이지 조회
		@GetMapping("/user/quit.ft")
		public ModelAndView showQuitForm(ModelAndView mv) {
			mv.setViewName("user/quit");
			return mv;
		}
		
		//회원 정보수정 페이지 조회
		@GetMapping("/user/modify.ft")
		public ModelAndView showModifyForm(ModelAndView mv,
				HttpServletRequest request) {
			try {
				HttpSession session = request.getSession();
				UserVO uOne = (UserVO) session.getAttribute("user");
				UserVO user = uService.selectUser(uOne.getUserId());
				mv.addObject("user", user);
				mv.setViewName("user/modify");
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			
			return mv;
		}
		//회원 정보수정 기능
		@PostMapping("/user/modify.ft")
		public ModelAndView userModify(ModelAndView mv,
				UserVO user,
				HttpServletRequest request) {
			try {
				HttpSession session = request.getSession();
				UserVO uOne = (UserVO) session.getAttribute("user");
				String encodedPassword = passwordEncoder.encode(user.getUserPw());
	            user.setUserPw(encodedPassword);
	            user.setUserId(uOne.getUserId());
	            int result = uService.userUpdate(user);
	            if(result > 0) {
	            	mv.setViewName("redirect:/user/mypage.ft");
	            } else {
	            	mv.addObject("msg", "정보수정에 실패했습니다.");
					mv.setViewName("common/errorPage");
	            }
	            
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			
			return mv;
		}
		
		//마이페이지
		@GetMapping("/user/mypage.ft")
		public ModelAndView showMypage(ModelAndView mv,
				HttpServletRequest request) {
			try {
				HttpSession session = request.getSession();
				UserVO uOne = (UserVO) session.getAttribute("user");
				UserVO user = uService.selectUser(uOne.getUserId());
				mv.addObject("user", user);
				mv.setViewName("user/mypage");
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			
			return mv;
		}
	
	
		@GetMapping("/user/login.ft")
		public String login() {
		    return "redirect:/";
		}
		// 로그아웃
		@PostMapping("/user/logout.ft")
		public String userLogout(HttpServletRequest request, HttpServletResponse response) {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        if (auth != null){    
	            new SecurityContextLogoutHandler().logout(request, response, auth);
	        }
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
		public ModelAndView userRegister(ModelAndView mv, UserVO user) {
			try {
				user.setLoginSt("B");
				user.setUserSt("N");
				user.setUserAdmin("USER");
				// 비밀번호를 해싱하여 저장
	            String encodedPassword = passwordEncoder.encode(user.getUserPw());
	            user.setUserPw(encodedPassword);
				
				//중복확인
				UserVO uOne = uService.insertDuplication(user);
				if(uOne != null) {
					mv.addObject("msg", "중복된 아이디나 이메일을 쓰고 있습니다.");
					mv.setViewName("common/errorPage");
				}
				else {
					int result = uService.insertUser(user);
					if(result > 0) {
						mv.setViewName("main");
					} else {
						mv.addObject("msg", "회원가입에 실패하였습니다.");
						mv.setViewName("common/errorPage");
					}					
				}		
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
	
		//아이디/비밀번호 찾기 페이지 조회
		@GetMapping("/user/idpwfind.ft")
		public ModelAndView showIdPwFindForm(ModelAndView mv) {
			mv.setViewName("user/idpwfind");
			return mv;
		}
		//비밀번호 찾기 기능
		@PostMapping("/user/pwfind.ft")
	    public ModelAndView findPassword(
	    		ModelAndView mv,
	    		@RequestParam("userId") String userId, 
	            @RequestParam("userEmail") String userEmail, 
	            HttpSession session) {
			try {
				// 사용자 검증 로직
				UserVO uOne = new UserVO();
				uOne.setUserId(userId);
				uOne.setUserEmail(userEmail);
				UserVO user = uService.userFindByEmailAndId(uOne);
				
				if (user != null) {
					session.setAttribute("userId", userId);
					mv.setViewName("redirect:/user/changepw.ft");
				} else {
					mv.addObject("msg", "없는 계정입니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
	    }
		//비밀번호 변경 페이지 조회
		@GetMapping("/user/changepw.ft")
		public ModelAndView 쇼비밀번호변경(ModelAndView mv) {
			mv.setViewName("user/changepw");
			return mv;
		}
		//비밀번호 변경
		@PostMapping("/user/changepw.ft")
		public ModelAndView pwModify(ModelAndView mv,
				HttpSession session,
				@RequestParam("userPw") String userPw) {
			try {
				String userId = (String) session.getAttribute("userId");
				String encodedPassword = passwordEncoder.encode(userPw);
				UserVO user = new UserVO();
				user.setUserId(userId);
	            user.setUserPw(encodedPassword);
				int result = uService.pwModify(user);
				if(result > 0) {
					mv.setViewName("redirect:/user/logout.ft");
				} else {
					mv.addObject("msg", "비밀번호 변경에 실패했습니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
}
