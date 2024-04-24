package com.fairytown.ft.user.config;

import java.io.IOException;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler{

	@Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        String errorMessage;
        if(exception.getMessage().equals("")) {
        	errorMessage = "알 수 없는 이유로 로그인에 실패하였습니다.";
        } else {
        	errorMessage = exception.getMessage();        	
        }

        request.getSession().setAttribute("msg", errorMessage);
        response.sendRedirect("/common/errorPage.ft");
    }
}
