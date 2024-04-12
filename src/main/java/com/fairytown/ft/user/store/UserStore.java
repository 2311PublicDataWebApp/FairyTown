package com.fairytown.ft.user.store;

import org.apache.ibatis.annotations.Mapper;

import com.fairytown.ft.user.domain.vo.UserVO;

@Mapper
public interface UserStore {

	//로그인
	UserVO checkUserLogin(String userId);

	//회원가입
	int insertUser(UserVO user);

	//중복확인
	UserVO insertDuplication(UserVO user);

	//이메일로 유저검색
	UserVO userFindByEmail(String userEmail);

	//이메일 + 아이디로 유저검색
	UserVO userFindByEmailAndId(UserVO uOne);

	//비밀번호 변경
	int pwModify(UserVO user);

	//회원 정보 수정
	int userUpdate(UserVO user);

}
