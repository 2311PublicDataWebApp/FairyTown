package com.fairytown.ft.blacklist.store.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.blacklist.domain.vo.BlacklistVO;
import com.fairytown.ft.blacklist.store.BlacklistStore;
import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;

@Repository
public class BlacklistStoreImpl implements BlacklistStore {

	@Override
	public List<BlacklistVO> selectBlacklist(SqlSession session, NoticePageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<BlacklistVO> bList = session.selectList("BlacklistMapper.selectBlacklist", null, rowBounds);
		return bList;
	}


	@Override
	public int selectTotalCount(SqlSession session, Map<String, String> paramMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int selectTotalCount(SqlSession session) {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public List<BlacklistVO> selectBlacklistsByKeyword(SqlSession session, RowBounds rowBounds,
			Map<String, String> paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

}
