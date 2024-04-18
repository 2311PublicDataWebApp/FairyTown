package com.fairytown.ft.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fairytown.ft.user.domain.vo.UserResponse;
import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserRestController {
	
	private final UserService uService;
	
	//아이디 찾기 기능
	@PostMapping("/idfind.ft")
	public ResponseEntity<UserResponse> idFind(@RequestBody Map<String, String> requestBody) {
		String userEmail = requestBody.get("userEmail");
		UserVO user = uService.userFindByEmail(userEmail);
		
		if (user != null) {
			UserResponse uResponse = new UserResponse();
			uResponse.setMessage(user.getUserId());
			uResponse.setSuccess(true);
            return ResponseEntity.ok(uResponse);
        } else {
        	UserResponse uResponse = new UserResponse();
			uResponse.setMessage("아이디를 찾을 수 없습니다.");
			uResponse.setSuccess(false);
            return ResponseEntity.badRequest().body(uResponse);
        }
	}	
}
