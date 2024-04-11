package com.fairytown.ft.notice.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;
import com.fairytown.ft.notice.service.NoticeService;
import com.fairytown.ft.notice.store.NoticeStore;




@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeStore nStore;
	@Autowired
	private SqlSession session;
		
	@Override
	public int insertNotice(NoticeVO notice) {
		int result = nStore.insertNotice(session, notice);
		return result;
	}

	@Override
	public List<NoticeVO> selectNoticeList(NoticePageInfo pi) {
		
		List<NoticeVO> nList = nStore.selectNoticeList(session, pi);
		return nList;
	}
	
	@Override
	public NoticeVO selectByNoticeNo(int noticeNo) {
		NoticeVO notice = nStore.selectByNoticeNo(session, noticeNo);
		return notice;
	}

	@Override
	public int getTotalCount() {
		int totalCount = nStore.selectTotalCount(session);
		return totalCount;
	}

	@Override
	public int getTotalCount(Map<String, String> paramMap) {
		int totalCount = nStore.selectTotalCount(session, paramMap);
		return totalCount;
	}

	@Override
	public List<NoticeVO> searchNoticesByKeyword(NoticePageInfo pi, Map<String, String> paramMap) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<NoticeVO> searchList = nStore.selectNoticesByKeyword(session, rowBounds, paramMap);
		return searchList;
	}

	
	@Override
	public int updateNotice(NoticeVO notice) {
		int result = nStore.updateNotice(session, notice);
		return result;
	}

	@Override
	public int deleteNotice(int noticeNo) {
		int result = nStore.deleteNotice(session, noticeNo);
		return result;
	}

}
