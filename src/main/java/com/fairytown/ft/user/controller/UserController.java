package com.fairytown.ft.user.controller;


import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.user.domain.vo.BlackListVO;
import com.fairytown.ft.user.domain.vo.KakaoProfile;
import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.domain.vo.UserWithBlackListVO;
import com.fairytown.ft.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class UserController {

		@Autowired
    	private final PasswordEncoder passwordEncoder;
		@Autowired
		private final UserService uService;
		
		//오류 페이지 조회
		@GetMapping("/common/errorPage.ft")
		public ModelAndView showerrorPage(ModelAndView mv) {
			mv.setViewName("common/errorPage");
			return mv;
		}
		
		//관리자페이지 - 블랙리스트 상세 조회
		@GetMapping("/admin/blackdetail.ft")
		public ModelAndView showBlackDetail(ModelAndView mv,
				@RequestParam("userId") String userId) {
			try {
				BlackListVO user = uService.selectBlack(userId);
				if(user == null) {
					mv.addObject("msg", "유저 정보가 존재하지 않습니다.");
					mv.setViewName("common/errorPage");
				} else {
					mv.addObject("blackList", user);
					mv.setViewName("admin/blackdetail");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			
			return mv;
		}
		
		@PostMapping("/admin/white.ft")
		//관리자페이지 - 블랙리스트 일괄 해제 처리
		public ModelAndView whiteUser(ModelAndView mv,
				@RequestParam("check-white-users") String selectUsers) {
			try {
				String[] users = selectUsers.split(",");
				int result = 0;
				for(String userId : users) {
					uService.whiteUser(userId);
					result = uService.deleteBlack(userId);
					if(result > 0) {
						continue;
					}
					else {
						mv.addObject("msg", userId + "계정의 정지를 풀 수 없습니다.");
						mv.setViewName("common/errorPage");
						return mv;
					}
				}
				mv.setViewName("redirect:/admin/blacklist.ft");
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			
			return mv;
		}
		
		//관리자페이지 - 블랙리스트 관리
		@GetMapping("/admin/blacklist.ft")
		public ModelAndView showBlackList(ModelAndView mv, @RequestParam(value = "page", required = false, defaultValue = "1") Integer currentPage
				, @RequestParam(value="keyword", required=false) String keyword
				, @RequestParam(value="type", required=false) String type) {
			try {
				if((keyword == null && type == null)||(keyword.equals("") && type.equals(""))) {
					int totalCount = uService.getBlackTotalCount();
					PageInfo pi = this.getPageInfo(currentPage, totalCount);
					List<UserVO> uList = uService.selectUserListBlack(pi);
					List<BlackListVO> bList = uService.selectBlackList(pi);
					
					List<UserWithBlackListVO> userWithBlackList = new ArrayList<>();

					for (int i = 0; i < uList.size(); i++) {
					    UserWithBlackListVO userWithBlack = new UserWithBlackListVO();
					    userWithBlack.setUser(uList.get(i));
					    userWithBlack.setBlackList(bList.get(i));
					    userWithBlackList.add(userWithBlack);
					}
					mv.addObject("userWithBlackList", userWithBlackList);
					mv.addObject("pInfo", pi);
					mv.setViewName("admin/blacklist");
				} else {
					UserVO user = new UserVO();
					user.setKeyword(keyword);
					user.setType(type);
					
					int totalCount = uService.getSearchBlackTotalCount(user);
					PageInfo pi = this.getPageInfo(currentPage, totalCount);
					pi.setKeyword(keyword);
					pi.setType(type);
					
					List<UserVO> uList = uService.searchUserListBlack(pi);
					List<BlackListVO> bList = uService.searchBlackList(pi);
					
					List<UserWithBlackListVO> userWithBlackList = new ArrayList<>();

					for (int i = 0; i < uList.size(); i++) {
					    UserWithBlackListVO userWithBlack = new UserWithBlackListVO();
					    userWithBlack.setUser(uList.get(i));
					    userWithBlack.setBlackList(bList.get(i));
					    userWithBlackList.add(userWithBlack);
					}
					mv.addObject("userWithBlackList", userWithBlackList);
					mv.addObject("pInfo", pi);
					mv.setViewName("admin/blacklist");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
		
		//관리자페이지 - 블랙리스트 등록창 조회
		@GetMapping("/admin/blackreason.ft")
		public ModelAndView blackReason(ModelAndView mv) {
			mv.setViewName("admin/blackreason");
			return mv;
		}
		
		//관리자페이지 - 블랙리스트 등록
		@PostMapping("/admin/blackRegister.ft")
		public ModelAndView blackRegister(ModelAndView mv, @RequestParam("blackUser") String blackUser,
				@RequestParam("stopDate")	int 	stopDate,
				@RequestParam("reason")		String	reason) {
			try {
				int result = 0;
				BlackListVO blackList = new BlackListVO();
				LocalDateTime regiDate = LocalDateTime.now(); // 현재 날짜 및 시간
				Timestamp regiDateTimestamp = Timestamp.valueOf(regiDate);
				if(stopDate != 0) {
					// 정지일자 계산: 현재 날짜와 선택된 정지 기간(stopDate)을 기준으로 계산
					// stopDate(월 단위)를 더하여 정지기한(stopDateTime)를 계산
					LocalDateTime stopDateTime = regiDate.plus(stopDate, ChronoUnit.MONTHS);
					// LocalDateTime을 Timestamp로 변환하여 정지기한(stopDateTimestamp)과 정지일자(regiDate) 설정
					Timestamp stopDateTimestamp = Timestamp.valueOf(stopDateTime);
					blackList.setStopDate(stopDateTimestamp); // 정지기간 설정
				}
	                
	            //BlackListVO 객체 생성 및 값 설정
				blackList.setRegiDate(regiDateTimestamp); // 정지일자 설정
	               blackList.setUserId(blackUser); // 사용자 ID 설정
	               blackList.setReason(reason);
	               //stopDate가 0이면 영구정지 이므로 정지 종료날짜를 등록일 + 1000년을 해준다.
	               if(stopDate == 0) {
	               	LocalDateTime stopDateTime = regiDate.plus(1000, ChronoUnit.YEARS);
	               	Timestamp stopDateTimestamp = Timestamp.valueOf(stopDateTime);
	               	blackList.setStopDate(stopDateTimestamp);
	               }
					
				uService.changeBlack(blackUser);
				result = uService.blackInsertUser(blackList);
				if(result <= 0) {
					mv.addObject("msg", blackUser + "계정을 정지할 수 없습니다.");
					mv.setViewName("common/errorPage");
				}
				mv.addObject("closeWindow", true);
				mv.setViewName("admin/blackreason");
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			
			return mv;
		}
		
		//관리자페이지 - 유저 정보 상세조회 창
		@GetMapping("/admin/userdetail.ft")
		public ModelAndView showUserDetail(ModelAndView mv,
				@RequestParam("userId") String userId) {
			try {
				UserVO user = uService.selectUser(userId);
				if(user == null) {
					mv.addObject("msg", "유저 정보가 존재하지 않습니다.");
					mv.setViewName("common/errorPage");
				} else {
					mv.addObject("user", user);
					mv.setViewName("admin/userdetail");
				}
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

		        if (passwordEncoder.matches(userPw, user.getUserPw())) {
		            // 사용자 정보 삭제
		            int result = uService.deleteUser(user);
		            if (result > 0) {
		                // 카카오 회원일 때만 카카오 계정과의 연동 해제
		                if (user.getLoginSt().equals("K")) {
		                    final String reqUrl = "https://kapi.kakao.com/v1/user/unlink";
		                    RestTemplate restTemplate = new RestTemplate();
		                    
		                    HttpHeaders headers = new HttpHeaders();
		                    headers.add("Authorization", "Bearer " + user.getAccessToken());
		                    HttpEntity<String> requestEntity = new HttpEntity<>("", headers);
		                    
		                    ResponseEntity<String> response = restTemplate.exchange(reqUrl, HttpMethod.POST, requestEntity, String.class);
		                    
		                    if (response.getStatusCode() == HttpStatus.OK) {
		                        session.removeAttribute("KAKAO_ACCESS_TOKEN");
		                        System.out.println("카카오톡 세션 연결 종료 성공");
		                    } else {
		                        // 카카오 회원 탈퇴 실패 처리 로직
		                        mv.addObject("msg", "카카오 계정과의 연동 해제에 실패했습니다.");
		                        mv.setViewName("common/errorPage");
		                        return mv;
		                    }
		                }
		                session.invalidate();
		                // 탈퇴 성공 시 메인 페이지로 이동
		                mv.setViewName("main");
		            } else {
		                // 탈퇴 실패 시 에러 페이지로 이동
		                mv.addObject("msg", "탈퇴에 실패하였습니다. 관리자에게 문의해주세요.");
		                mv.setViewName("common/errorPage");
		            }
		        } else {
		            // 비밀번호가 일치하지 않을 때 에러 페이지로 이동
		            mv.addObject("msg", "잘못된 비밀번호입니다.");
		            mv.setViewName("common/errorPage");
		        }
		    } catch (Exception e) {
		        // 예외 발생 시 에러 페이지로 이동
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
			UserVO user = new UserVO();
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
	        	model.addAttribute("kakaoId", profile.getProviderId());
	            
	        	return "user/addinfo";
	        }
	        // 기존 사용자라면, 세션에 사용자 정보 저장
	        user = uService.selectUser(profile.getProviderId());
	        if ("B".equals(user.getUserSt())) {
				model.addAttribute("msg", "운영사항 위반으로 활동이 정지된 회원입니다.");
				return "common/errorPage";
	        }
	        user.setAccessToken(accessToken);
	        session.setAttribute("user", user);
		    return "main";
		}

		// 로그아웃
		@RequestMapping(value="/user/logout.ft", method = {RequestMethod.GET, RequestMethod.POST})
		public String userLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			//세션 종료
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        if (auth != null){    
	            new SecurityContextLogoutHandler().logout(request, response, auth);
	        }
			return "redirect:/";
		}
	
		//간편로그인 추가 정보 입력
		@PostMapping("/user/addinfo.ft")
		public ModelAndView socialUserAddInfo(ModelAndView mv,@ModelAttribute UserVO user, HttpSession session) {
			try {
				user.setLoginSt("K");
				user.setUserSt("N");
				user.setUserAdmin("USER");
				// 비밀번호를 해싱하여 저장
	            String encodedPassword = passwordEncoder.encode(user.getUserPw());
	            user.setUserPw(encodedPassword);
	            //중복확인
				List<UserVO> uOne = uService.insertDuplication(user);
				if(uOne.size() != 0) {
					mv.addObject("msg", "중복된 아이디나 이메일을 쓰고 있습니다.");
					mv.setViewName("common/errorPage");
				}
				else {
					int result = uService.insertUser(user);
					if(result > 0) {
						session.setAttribute("user", user);
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
				if(uOne.size() != 0) {
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
		//아이디 찾기 기능
		@GetMapping("/user/idfind.ft")
		public ModelAndView findId(ModelAndView mv,
				@RequestParam("userEmail") String userEmail) {
			try {
				UserVO user = uService.userFindByEmail(userEmail);
				if(user == null) {
					mv.addObject("msg", "아이디를 찾을 수 없습니다.");
					mv.setViewName("common/errorPage");
				} else {
					mv.addObject("user", user);
					mv.setViewName("user/idfind");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
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
		public ModelAndView showPasswordModifyForm(ModelAndView mv) {
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