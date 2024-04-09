package com.fairytown.ft.user.store;

import org.apache.ibatis.annotations.Mapper;

import com.fairytown.ft.user.domain.vo.UserVO;

@Mapper
public interface UserStore {

	//로그인
	UserVO checkUserLogin(String userId);

}
