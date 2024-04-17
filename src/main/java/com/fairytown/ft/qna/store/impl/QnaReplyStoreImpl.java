package com.fairytown.ft.qna.store.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.qna.domain.vo.QnaReplyVO;
import com.fairytown.ft.qna.store.QnaReplyStore;

@Repository
public class QnaReplyStoreImpl implements QnaReplyStore{

	@Override
	public int insertQnaReply(SqlSession session, QnaReplyVO qnaReplyVO) {
		int result = session.insert("QnaReplyMapper.insertQnaReply", qnaReplyVO);
		return result;
	}

	@Override
	public int updateQnaReply(SqlSession session, QnaReplyVO qnaReply) {
		int result = session.update("QnaReplyMapper.updateQnaReply", qnaReply);
		return result;
	}

	@Override
	public int removeQnaReply(SqlSession session, Integer qnaReplyNo) {
		int result = session.delete("QnaReplyMapper.removeQnaReply", qnaReplyNo);
		return result;
	}

	@Override
	public List<QnaReplyVO> selectQnaReplyList(SqlSession session, Integer refQnaNo) {
		List<QnaReplyVO> rList = session.selectList("QnaReplyMapper.selectQnaReplyList", refQnaNo);
		return rList;
	}

}
