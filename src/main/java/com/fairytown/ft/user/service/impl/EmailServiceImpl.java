package com.fairytown.ft.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.fairytown.ft.user.service.EmailService;

@Service
public class EmailServiceImpl  implements EmailService{

	@Autowired
    private JavaMailSender emailSender;
	
	@Override
	public void sendSimpleMessage(String to, String subject, String text) {
		SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("a01094782134@gmail.com"); // 여기에 발신자 이메일 주소를 설정하세요.
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);
        emailSender.send(message);
		
	}

}