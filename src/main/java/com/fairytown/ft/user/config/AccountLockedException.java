package com.fairytown.ft.user.config;

import org.springframework.security.core.AuthenticationException;

@SuppressWarnings("serial")
public class AccountLockedException extends AuthenticationException{
	public AccountLockedException(String msg) {
        super(msg);
    }
}
