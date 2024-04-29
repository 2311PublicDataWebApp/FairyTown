package com.fairytown.ft.notice.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;





public interface NoticeStore {


	List<NoticeVO> selectNoticeList(SqlSession session, NoticePageInfo pi);
	
	int selectTotalCount(SqlSession session);
	
	int selectTotalCount(SqlSession session, Map<String, String> paramMap);
	
	List<NoticeVO> selectNoticesByKeyword(SqlSession session, RowBounds rowBounds, Map<String, String> paramMap);
	
	NoticeVO selectByNoticeNo(SqlSession session, int noticeNo);
	
	int updateNotice(SqlSession session, NoticeVO notice);
	
	
	int deleteNotice(SqlSession session, int noticeNo);
	
	int insertNotice(SqlSession session, NoticeVO notice);

	List<NoticeVO> selectNoticeList(SqlSession session);	
}
