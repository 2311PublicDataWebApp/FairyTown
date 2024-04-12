package com.fairytown.ft.user.domain.vo;

import lombok.Data;

@Data
public class UserResponse {
	private boolean success;
    private String message;
    private String url;
}
