package com.fairytown.ft.notice.store.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;
import com.fairytown.ft.notice.store.NoticeStore;



@Repository
public class NoticeStoreImpl implements NoticeStore {

	

	@Override
	public int selectTotalCount(SqlSession session) {
		int totalCount = session.selectOne("NoticeMapper.selectTotalCount");
		return totalCount;
	}

	@Override
	public int selectTotalCount(SqlSession session, Map<String, String> paramMap) {
		
		int totalCount = session.selectOne("NoticeMapper.searchTotalCount", paramMap);
		return totalCount;
	}

	@Override
	public List<NoticeVO> selectNoticesByKeyword(SqlSession session, RowBounds rowBounds,
			Map<String, String> paramMap) {
		
		List<NoticeVO> searchList = session.selectList("NoticeMapper.selectNoticesByKeyword", paramMap, rowBounds);
		return searchList;
	}

	@Override
	public NoticeVO selectByNoticeNo(SqlSession session, int noticeNo) {
		NoticeVO notice = session.selectOne("NoticeMapper.selectByNoticeNo", noticeNo);
		return notice;
	}

	@Override
	public int updateNotice(SqlSession session, NoticeVO notice) {
		int result = session.update("NoticeMapper.updateNotice", notice);
		return result;
	}

	@Override
	public int deleteNotice(SqlSession session, int noticeNo) {
		int result = session.delete("NoticeMapper.deleteNotice", noticeNo);
		return result;
	}

	@Override
	public int insertNotice(SqlSession session, NoticeVO notice) {
		int result = session.insert("NoticeMapper.insertNotice", notice);
		return result;
	}

	@Override
	public List<NoticeVO> selectNoticeList(SqlSession session, NoticePageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<NoticeVO> nList = session.selectList("NoticeMapper.selectNoticeList", null, rowBounds);
		return nList;
	}

}
