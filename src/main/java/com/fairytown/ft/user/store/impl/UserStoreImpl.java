package com.fairytown.ft.user.store.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.store.UserStore;

import jakarta.servlet.http.HttpSession;


@Repository
public class UserStoreImpl implements UserStore{

	@Override
	public UserVO checkuserLogin(SqlSession session, UserVO uOne) {
		UserVO user = session.selectOne("UserMapper.checkUserLogin", uOne);
		return user;
	}


}
