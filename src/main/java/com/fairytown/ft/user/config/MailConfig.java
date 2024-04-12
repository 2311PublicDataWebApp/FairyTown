package com.fairytown.ft.user.config;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

//JavaMailSender 빈 구성
@Configuration
public class MailConfig {
	//properties 파일에 설정해 둔 이메일 비밀번호 가져오기
	@Value("${spring.mail.username}")
	private String username;
	@Value("${spring.mail.password}")
	private String password;
	
	@Bean
	public JavaMailSender javaMailSender() {
	  
	  
      JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
      mailSender.setHost("smtp.gmail.com");
      mailSender.setPort(587);

      mailSender.setUsername(this.username);
      mailSender.setPassword(this.password);

      Properties props = mailSender.getJavaMailProperties();
      props.put("mail.transport.protocol", "smtp");
      props.put("mail.smtp.auth", "true");
      props.put("mail.smtp.starttls.enable", "true");
      
      props.put("mail.smtp.connectiontimeout", 9000);
      props.put("mail.smtp.timeout", 9000);
      props.put("mail.smtp.writetimeout", 9000);

      return mailSender;
  }
}