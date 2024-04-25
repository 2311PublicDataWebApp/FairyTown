package com.fairytown.ft.user.store;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.user.domain.vo.BlackListVO;
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
	List<UserVO> selectUserList(RowBounds rowBounds, PageInfo pi);

	//유저 목록 수
	int getUserTotalCount();

	//검색 유저 목록 수
	int getSearchUserTotalCount(UserVO user);

	//검색 유저 목록 조회
	List<UserVO> searchUserList(RowBounds rowBounds, PageInfo pi);

	//블랙리스트 등록
	int blackInsertUser(BlackListVO blackList);

	//회원 활동상태 변경(N -> B)
	void changeBlack(String userId);

	//블랙리스트 유저 수
	int getBlackTotalCount();

	//정지 회원의 정보 조회
	List<UserVO> selectUserListBlack(RowBounds rowBounds, PageInfo pi);

	//회원의 정지 정보 조회
	List<BlackListVO> selectBlackList(RowBounds rowBounds, PageInfo pi);

	//정지 회원 정보 검색 수 조회
	int getSearchBlackTotalCount(UserVO user);

	//검색된 정지 회원 목록
	List<UserVO> searchUserListBlack(RowBounds rowBounds, PageInfo pi);

	//검색된 회원의 정지 정보 조회
	List<BlackListVO> searchBlackList(RowBounds rowBounds, PageInfo pi);

	//정지 상태 유저 정지 해제
	void whiteUser(String userId);

	//블랙리스트 삭제
	int deleteBlack(String userId);

	//블랙리스트 상세 조회
	BlackListVO selectBlack(String userId);
	


}
