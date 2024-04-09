package com.fairytown.ft.user.config;

import java.security.SecureRandom;

//이메일 인증번호 생성 로직
public class VerificationCodeUtil {
    public static String generateVerificationCode() {
        SecureRandom random = new SecureRandom();
        int num = random.nextInt(900000) + 100000; // 100000 ~ 999999 사이의 랜덤한 숫자 생성
        return String.format("%06d", num); // 최소 5자리 숫자로 포맷
    }
}