package com.fairytown.ft;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@EnableWebSecurity
@Configuration
public class SecurityConfig {

	 @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
	 	http.csrf((auth) -> auth.disable());
        http
            .authorizeHttpRequests((auth) -> auth
            		.requestMatchers("/admin").hasRole("ADMIN") // /admin 들어왔을 때 admin인지 체크
					//.requestMatchers("/user/**").hasRole("USER") // /user/** 들어왔을 때 user인지 체크
//						.requestMatchers("/","/login").permitAll()
					.anyRequest().permitAll()
                  
        );
//			http.formLogin((auth)->auth
//					.loginPage("/login")
//					.loginProcessingUrl("/login")
//					.permitAll()
//			);

        return http.build();
    }
	 

	 
	 
	 
}