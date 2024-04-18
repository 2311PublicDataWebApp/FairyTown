package com.fairytown.ft.qna.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.qna.domain.vo.QnaReplyVO;
import com.fairytown.ft.qna.service.QnaReplyService;
import com.fairytown.ft.qna.store.QnaReplyStore;

@Service
public class QnaReplyServiceImpl implements QnaReplyService{
	
	@Autowired
	private QnaReplyStore qStore;
	@Autowired
	private SqlSession session;
	
	@Override
	public int insertQnaReply(QnaReplyVO QnaReplyVO) {
		int result = qStore.insertQnaReply(session, QnaReplyVO);
		return result;
	}

	@Override
	public int updateQnaReply(QnaReplyVO qnaReply) {
		int result = qStore.updateQnaReply(session, qnaReply);
		return result;
	}

	@Override
	public int removeQnaReply(Integer qnaReplyNo) {
		int result = qStore.removeQnaReply(session, qnaReplyNo);
		return result;
	}

	@Override
	public List<QnaReplyVO> selectQnaReplyList(Integer refQnaNo) {
		List<QnaReplyVO> rList = qStore.selectQnaReplyList(session, refQnaNo);
		return rList;
	}
	
	
}
