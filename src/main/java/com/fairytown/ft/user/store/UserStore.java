package com.fairytown.ft.user.store;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.user.domain.vo.UserVO;

@Mapper
public interface UserStore {

	//로그인
	UserVO checkUserLogin(String userId);

	//회원가입
	int insertUser(UserVO user);

	//중복확인
	List<UserVO> insertDuplication(UserVO user);

	//이메일로 유저검색
	UserVO userFindByEmail(String userEmail);

	//이메일 + 아이디로 유저검색
	UserVO userFindByEmailAndId(UserVO uOne);

	//비밀번호 변경
	int pwModify(UserVO user);

	//회원 정보 수정
	int userUpdate(UserVO user);

	//회원 정보 삭제
	int deleteUser(UserVO user);

	//참조테이블 데이터 삭제
	void deleteUserReview(UserVO user);//리뷰
	void deleteUserNotice(UserVO user);//공지
	void deleteUserBlack(UserVO user);//블랙리스트
	void deleteUserBooking(UserVO user);//예약목록
	void deleteUserTicket(UserVO user);//티켓목록

	//유저 목록 조회
	List<UserVO> selectUserList(PageInfo pi);

	//유저 목록 수
	int getUserTotalCount();

	//검색 유저 목록 수
	int getSearchUserTotalCount(UserVO user);

	//검색 유저 목록 조회
	List<UserVO> searchUserList(PageInfo pi);

	// 관리자 대쉬보드
	List<Map<String, Object>> adminUserBoard(Date today);
	


}
