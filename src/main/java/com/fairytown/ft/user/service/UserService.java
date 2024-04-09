package com.fairytown.ft.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.store.UserStore;

@Service
public class UserService implements UserDetailsService {

	@Autowired
	private UserStore uStore;
	
//	@Override
//	public UserVO checkuserLogin(UserVO uOne) {
//		UserVO user = uStore.checkuserLogin(session, uOne);
//		return user;
//	}

	@Override
    public UserVO loadUserByUsername(String userId) throws UsernameNotFoundException {
        //여기서 받은 유저 패스워드와 비교하여 로그인 인증
		UserVO userVo = uStore.checkUserLogin(userId);
        if (userVo == null){
            throw new UsernameNotFoundException("사용자가 승인되지 않았습니다.");
        }
        return userVo;
    }

}
