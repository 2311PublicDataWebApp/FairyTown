package com.fairytown.ft.user.domain.vo;

import lombok.Data;

@Data
public class KakaoProfile {
    private String providerId;
    private String kakaoNickname;
    private String kakaoEmail;
    private String provider;
}
