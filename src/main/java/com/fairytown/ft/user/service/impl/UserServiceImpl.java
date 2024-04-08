package com.fairytown.ft.user.service.impl;

import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.service.UserService;
import com.fairytown.ft.user.store.UserStore;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private SqlSession session;
	
	@Autowired
	private UserStore uStore;
	
	@Override
	public UserVO checkuserLogin(UserVO uOne) {
		UserVO user = uStore.checkuserLogin(session, uOne);
		return user;
	}

}
