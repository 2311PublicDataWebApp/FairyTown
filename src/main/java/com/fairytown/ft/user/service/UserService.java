package com.fairytown.ft.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.fairytown.ft.common.PageInfo;
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

	//로그인 메서드
	@Override
    public UserVO loadUserByUsername(String userId) throws UsernameNotFoundException {
        //여기서 받은 유저 패스워드와 비교하여 로그인 인증
		UserVO userVo = uStore.checkUserLogin(userId);
        if (userVo == null){
            throw new UsernameNotFoundException("사용자가 승인되지 않았습니다.");
        }
        return userVo;
    }

	//회원가입 메서드
	public int insertUser(UserVO user) {
		int result = uStore.insertUser(user);
		return result;
	}

	//중복확인
	public UserVO insertDuplication(UserVO user) {
		UserVO uOne = uStore.insertDuplication(user);
		return uOne;
	}

	//이메일로 회원 검색
	public UserVO userFindByEmail(String userEmail) {
		UserVO user = uStore.userFindByEmail(userEmail);
		return user;
	}

	//이메일 + 아이디로 회원 검색
	public UserVO userFindByEmailAndId(UserVO uOne) {
		UserVO user = uStore.userFindByEmailAndId(uOne);
		return user;
	}

	//비밀번호 변경
	public int pwModify(UserVO user) {
		int result = uStore.pwModify(user);
		return result;
	}

	//회원 정보수정
	public int userUpdate(UserVO user) {
		int result = uStore.userUpdate(user);
		return result;
	}

	//회원 정보 조회
	public UserVO selectUser(String userId) {
		UserVO user = uStore.checkUserLogin(userId);
		return user;
	}

	//회원 정보 삭제
	public int deleteUser(UserVO user) {
		//참조 테이블 데이터 삭제
		uStore.deleteUserReview(user);
		uStore.deleteUserNotice(user);
		uStore.deleteUserBlack(user);
		uStore.deleteUserBlack(user);
		uStore.deleteUserBooking(user);
		uStore.deleteUserTicket(user);
		
		int result = uStore.deleteUser(user);
		return result;
	}

	//유저 목록 조회
	public List<UserVO> selectUserList(PageInfo pi) {
		List<UserVO> uList = uStore.selectUserList(pi);
		return uList;
	}

	//유저 목록 수 얻기
	public int getUserTotalCount() {
		int totalCount = uStore.getUserTotalCount();
		return totalCount;
	}

	public int getSearchUserTotalCount(UserVO user) {
		int totalCount = uStore.getSearchUserTotalCount(user);
		return totalCount;
	}

	public List<UserVO> searchUserList(PageInfo pi) {
		List<UserVO> uList = uStore.searchUserList(pi);
		return uList;
	}
}
