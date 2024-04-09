//package com.fairytown.ft.user.controller;
//
//import java.util.HashMap;
//import java.util.Map;
//import java.util.concurrent.ConcurrentHashMap;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.fairytown.ft.user.config.VerificationCodeUtil;
//import com.fairytown.ft.user.service.EmailService;
//
//@RestController
//public class EmailVerificationController {
//	
//	 	@Autowired
//	    private EmailService emailService;
//
//	 	// 이메일과 인증번호 매핑 저장소
//	    private static final Map<String, String> verificationCodes = new ConcurrentHashMap<>();
//	 	
//	    @PostMapping("/verify/email.ft")
//	    public ResponseEntity<?> sendEmailVerification(@RequestBody Map<String, String> request) {
//	        String email = request.get("email");
//	        // 인증번호 생성 로직
//	        String verificationCode = VerificationCodeUtil.generateVerificationCode();
//	        
//	        // 인증번호 메모리에 저장
//	        verificationCodes.put(email, verificationCode);
//	        
//	        // 인증번호 이메일로 전송
//	        emailService.sendSimpleMessage(email, "이메일 인증", "인증번호: " + verificationCode);
//	        
//	        // 성공적으로 이메일을 전송했다는 응답 반환
//	        return ResponseEntity.ok().body(Map.of("message", "인증번호가 이메일로 전송되었습니다."));
//	    }
//	    
//	    @PostMapping("/verify/code.ft")
//	    public ResponseEntity<?> verifyCode(@RequestBody Map<String, String> request) {
//	        String email = request.get("email");
//	        String verificationCode = request.get("verificationCode");
//	        
//	        String storedCode = verificationCodes.get(email);
//	        
//	        // 저장된 인증번호와 사용자 입력 인증번호 비교
//	        Map<String, Object> result = new HashMap<String, Object>();
//	        if(storedCode != null && storedCode.equals(verificationCode)) {
//	            // 인증 성공 후, 인증번호 삭제
//	            verificationCodes.remove(email);
//	            result.put("message", "이메일 인증에 성공했습니다.");
//	            result.put("ok", true);
//	            return ResponseEntity.ok().body(result);
//	        } else {
//	        	result.put("message", "인증번호가 일치하지 않습니다.");
//	            result.put("ok", false);
//	            return ResponseEntity.badRequest().body(result);
//	        }
//	    }
//}
