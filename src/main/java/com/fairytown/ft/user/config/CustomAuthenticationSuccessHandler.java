package com.fairytown.ft.user.config;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.fairytown.ft.user.domain.vo.UserVO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler{

	@Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        // Authentication 객체에서 사용자 정보 가져오기
        Object principal = authentication.getPrincipal();

        // 추가적인 세션 정보 설정
        HttpSession session = request.getSession();
        if (principal instanceof UserVO) {
        	UserVO user = (UserVO) principal;
            session.setAttribute("user", user);
        }

        // 로그인 후 리다이렉션
        response.sendRedirect("/");
    }

}
