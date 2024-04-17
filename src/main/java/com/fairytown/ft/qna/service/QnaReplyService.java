package com.fairytown.ft.qna.service;

import java.util.List;

import com.fairytown.ft.qna.domain.vo.QnaReplyVO;

public interface QnaReplyService {
	/**
	 * 댓글 등록 Service
	 * @param replyVO
	 * @return result
	 */
	int insertQnaReply(QnaReplyVO QnaReplyVO);
	
	/**
	 * 댓글 수정 Service
	 * @param reply
	 * @return result
	 */
	int updateQnaReply(QnaReplyVO qnaReply);
	
	/**
	 * 댓글 삭제 Service
	 * @param replyNo
	 * @return result
	 */
	int removeQnaReply(Integer qnaReplyNo);

	/**
	 * 댓글 조회 Service
	 * @return rList
	 */
	List<QnaReplyVO> selectQnaReplyList(Integer refQnaNo);
}
