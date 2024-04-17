package com.fairytown.ft.qna.store;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.qna.domain.vo.QnaReplyVO;

public interface QnaReplyStore {

	int insertQnaReply(SqlSession session, QnaReplyVO qnaReplyVO);

	int updateQnaReply(SqlSession session, QnaReplyVO qnaReply);

	int removeQnaReply(SqlSession session, Integer qnaReplyNo);

	List<QnaReplyVO> selectQnaReplyList(SqlSession session, Integer refQnaNo);

}
