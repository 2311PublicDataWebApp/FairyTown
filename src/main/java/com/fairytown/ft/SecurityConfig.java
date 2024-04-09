package com.fairytown.ft;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@EnableWebSecurity
@Configuration
public class SecurityConfig {

	@Bean
    public PasswordEncoder passwordEncoder() {
        // 비밀번호 인코더를 제공하지 않고 비밀번호를 평문으로 저장
        return NoOpPasswordEncoder.getInstance();
    }
	
	
	 @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
	 	http.csrf((auth) -> auth.disable());
        http
            .authorizeHttpRequests((auth) -> auth
            		.requestMatchers("/admin").hasRole("ADMIN") // /admin 들어왔을 때 admin인지 체크
					//.requestMatchers("/user/**").hasRole("USER") // /user/** 들어왔을 때 user인지 체크
					.requestMatchers("/","/login").permitAll()
					.anyRequest().permitAll()
                  
        );
			http.formLogin((auth)->auth
					.loginPage("/user/login.ft")
					.usernameParameter("userId")
					.passwordParameter("userPw")
					.loginProcessingUrl("/user/login.ft")
					.defaultSuccessUrl("/")
					.failureUrl("/common/error.ft")
					.permitAll()
			);
        return http.build();
    }
	 

	 
	 
	 
}