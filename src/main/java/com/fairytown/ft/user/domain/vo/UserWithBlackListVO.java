package com.fairytown.ft.user.domain.vo;

import lombok.Data;

@Data
public class UserWithBlackListVO {
    private UserVO 		user;
    private BlackListVO	blackList;
}
