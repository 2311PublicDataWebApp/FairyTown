package com.fairytown.ft.notice.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.notice.domain.vo.NoticeReplyVO;
import com.fairytown.ft.notice.service.NoticeReplyService;
import com.fairytown.ft.notice.store.NoticeReplyStore;




@Service
public class NoticeReplyServiceImpl implements NoticeReplyService{
	
	@Autowired
	private NoticeReplyStore rStore;
	@Autowired
	private SqlSession session;
	
	@Override
	public int insertReply(NoticeReplyVO replyVO) {
		int result = rStore.insertReply(session, replyVO);
		return result;
	}

	@Override
	public int deleteReply(Integer replyNo) {
		int result = rStore.deleteReply(session, replyNo);
		return result;
	}

	@Override
	public List<NoticeReplyVO> selectReplyList(Integer refNoticeNo) {
		List<NoticeReplyVO> rList = rStore.selectReplyList(session, refNoticeNo);
		return rList;
	}

	@Override
	public int updateReply(NoticeReplyVO reply) {
		int result = rStore.updateReply(session, reply);
		return result;
	}

	

	

}
