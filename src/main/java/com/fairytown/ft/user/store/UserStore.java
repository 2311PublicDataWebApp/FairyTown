package com.fairytown.ft.user.store;

import org.apache.ibatis.session.SqlSession;
import com.fairytown.ft.user.domain.vo.UserVO;


public interface UserStore {

	UserVO checkuserLogin(SqlSession session, UserVO uOne);

}
