package com.fairytown.ft.notice.store;

import java.util.List;


import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.notice.domain.vo.NoticeReplyVO;





public interface NoticeReplyStore {
	
	int insertReply(SqlSession session, NoticeReplyVO replyVO);
	
	int deleteReply(SqlSession session, Integer replyNo);

	List<NoticeReplyVO> selectReplyList(SqlSession session, Integer refNoticeNo);
	
	int updateReply(SqlSession session, NoticeReplyVO reply);

	

}
