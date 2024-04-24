package com.fairytown.ft;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.fairytown.ft.user.config.CustomAuthenticationFailureHandler;
import com.fairytown.ft.user.config.CustomAuthenticationSuccessHandler;

import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@EnableWebSecurity
@Configuration
public class SecurityConfig {
	
	@Bean
    public PasswordEncoder passwordEncoder() {
        // 비밀번호 인코더
        return new BCryptPasswordEncoder();
    }
	
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
	    http.csrf((auth) -> auth.disable());
	    http
	        .authorizeHttpRequests((auth) -> auth
	            .requestMatchers("/admin").hasRole("ADMIN")
	            .anyRequest().permitAll()
	        );
	    http.formLogin((auth) -> auth
	        .loginPage("/user/login.ft")
	        .usernameParameter("userId")
	        .passwordParameter("userPw")
	        .loginProcessingUrl("/user/login.ft")
	        .defaultSuccessUrl("/", true)
	        .failureHandler(new CustomAuthenticationFailureHandler()) //로그인 실패 커스텀 핸들러
	        .successHandler(new CustomAuthenticationSuccessHandler()) //로그인 성공 커스텀 핸들러
	        .permitAll()
	    );
	    return http.build();
	}
	 

	 
	 
	 
}