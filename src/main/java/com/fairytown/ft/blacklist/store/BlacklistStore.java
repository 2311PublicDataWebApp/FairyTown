package com.fairytown.ft.blacklist.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.blacklist.domain.vo.BlacklistVO;
import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;

public interface BlacklistStore {

	List<BlacklistVO> selectBlacklist(SqlSession session, NoticePageInfo pi);


	int selectTotalCount(SqlSession session, Map<String, String> paramMap);

	int selectTotalCount(SqlSession session);


	List<BlacklistVO> selectBlacklistsByKeyword(SqlSession session, RowBounds rowBounds, Map<String, String> paramMap);

}
