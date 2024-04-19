package com.fairytown.ft.user.controller;


import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.ModelAndView;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.user.domain.vo.KakaoProfile;
import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.service.UserService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

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
	
		//일반 회원 탈퇴처리
		@PostMapping(value = "/admin/userdelete.ft")
		public ModelAndView deleteMember(@RequestParam("check-delete-users") String selectMembers,
				ModelAndView mv) {
			try {
				String[] users = selectMembers.split(",");
				int result = 0;
				UserVO user = new UserVO();
				for(String userId : users) {
					user.setUserId(userId);
					result = uService.deleteUser(user);
					if(result > 0) {
						continue;
					}
					else {
						mv.addObject("msg", userId + "계정을 삭제 할 수 없습니다.");
						mv.setViewName("common/errorPage");
						return mv;
					}
				}
				mv.setViewName("redirect:/admin/userlist.ft");
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
		
		//관리자페이지 - 유저관리
		@GetMapping("/admin/userlist.ft")
		public ModelAndView showUserList(ModelAndView mv
				, @RequestParam(value = "page", required = false, defaultValue = "1") Integer currentPage
				, @RequestParam(value="keyword", required=false) String keyword
				, @RequestParam(value="type", required=false) String type) {
			try {
				if((keyword == null && type == null)||(keyword.equals("") && type.equals(""))) {
					int totalCount = uService.getUserTotalCount();
					PageInfo pi = this.getPageInfo(currentPage, totalCount);
					List<UserVO> uList = uService.selectUserList(pi);
					mv.addObject("uList", uList);
					mv.addObject("pInfo", pi);
					mv.setViewName("admin/userlist");
				} else {
					UserVO user = new UserVO();
					user.setKeyword(keyword);
					user.setType(type);
					
					int totalCount = uService.getSearchUserTotalCount(user);
					PageInfo pi = this.getPageInfo(currentPage, totalCount);
					pi.setKeyword(keyword);
					pi.setType(type);
					
					List<UserVO> uList = uService.searchUserList(pi);
					mv.addObject("uList", uList);
					mv.addObject("pInfo", pi);
					mv.setViewName("admin/userlist");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
		
		
		//회원탈퇴 페이지 조회
		@GetMapping("/user/quit.ft")
		public ModelAndView showQuitForm(ModelAndView mv) {
			mv.setViewName("user/quit");
			return mv;
		}
		
		//회원 탈퇴 기능
		@PostMapping("/user/quit.ft")
		public ModelAndView quitUser(ModelAndView mv,
				HttpServletRequest request,
				@RequestParam("userPw") String userPw) {
			try {
				HttpSession session = request.getSession();
				UserVO user = (UserVO) session.getAttribute("user");
				if(passwordEncoder.matches(userPw, user.getUserPw())) {
					int result = uService.deleteUser(user);
					if(result > 0) {
						mv.setViewName("main");
					} else {
						mv.addObject("msg", "탈퇴에 실패하였습니다. 관리자에게 문의해주세요.");
						mv.setViewName("common/errorPage");
					}
				} else {
					mv.addObject("msg", "잘못된 비밀번호입니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			
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
	
	
		//로그인 페이지
		@GetMapping("/user/login.ft")
		public String login(@RequestParam(value =  "code", required = false) String code, Model model, HttpSession session) throws Exception {
			if(code == null) {
				return "user/login";
			}
			String accessToken = uService.getAccessToken(code);
			// 카카오 로그인 처리 로직
	        // code를 사용하여 액세스 토큰을 얻고, 그 토큰으로 사용자 정보를 조회합니다.
	        KakaoProfile profile = uService.getKakaoInfo(accessToken);

	        // 사용자 정보가 데이터베이스에 존재하지 않으면 회원가입 처리
	        if (uService.isUserNew(profile)) {
	        	model.addAttribute("nickname", profile.getKakaoNickname());
	        	model.addAttribute("email", profile.getKakaoEmail());
//	            mv.addObject("kakaoId", profile.getId());
//	        	model.setViewName("redirect:/user/addinfo.ft"); // 추가 정보 입력 페이지로 리다이렉트
	            
	        	return "redirect:/user/addinfo.ft";
	        }
	     // 기존 사용자라면, 세션에 사용자 정보 저장
	        session.setAttribute("user", profile);
		    return "user/login";
		}
		
//		//카카오 로그인
//		@PostMapping("/user/kakaoLogin.ft")
//		public ModelAndView kakaoLogin(ModelAndView mv,
//				@RequestBody String code,
//				HttpSession session) throws ParseException {
//			try {
//				JsonObject jsonObject = JsonParser.parseString(code).getAsJsonObject();
//				code = jsonObject.get("code").getAsString();
//				String accessToken = uService.getAccessToken(code);
//				// 카카오 로그인 처리 로직
//		        // code를 사용하여 액세스 토큰을 얻고, 그 토큰으로 사용자 정보를 조회합니다.
//		        KakaoProfile profile = uService.getKakaoInfo(accessToken);
//
//		        // 사용자 정보가 데이터베이스에 존재하지 않으면 회원가입 처리
//		        if (uService.isUserNew(profile)) {
//		        	mv.addObject("nickname", profile.getKakaoNickname());
//		            mv.addObject("email", profile.getKakaoEmail());
////		            mv.addObject("kakaoId", profile.getId());
//		        	mv.setViewName("redirect:/user/addinfo.ft"); // 추가 정보 입력 페이지로 리다이렉트
//		            
//		        	return mv;
//		        }
//
//		        // 기존 사용자라면, 세션에 사용자 정보 저장
//		        session.setAttribute("user", profile);
//		        mv.setViewName("redirect:/"); // 메인 페이지로 리다이렉트
//			} catch (Exception e) {
//				mv.addObject("msg", e.getMessage());
//				e.printStackTrace();
//				mv.setViewName("common/errorPage");
//			}
//	        return mv;
//		}

		// 로그아웃
		@RequestMapping(value="/user/logout.ft", method = {RequestMethod.GET, RequestMethod.POST})
		public String userLogout(HttpServletRequest request, HttpServletResponse response) {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        if (auth != null){    
	            new SecurityContextLogoutHandler().logout(request, response, auth);
	        }
			return "redirect:/";
		}
		
	
		//간편로그인 추가 정보 입력
		
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
				List<UserVO> uOne = uService.insertDuplication(user);
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
		
		//페이징 처리
		private PageInfo getPageInfo(Integer currentPage, int totalCount) {
			int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
			PageInfo pi = new PageInfo(currentPage, totalCount, boardLimit);
			
			return pi;
		}
}