package com.fairytown.ft.notice.service;

import java.util.List;

import com.fairytown.ft.notice.domain.vo.NoticeReplyVO;



public interface NoticeReplyService {
	
	/**
	 * 댓글 등록 Service
	 * @param replyVO
	 * @return int
	 */
	int insertReply(NoticeReplyVO replyVO);
	
	/**
	 * 댓글 삭제 Service
	 * @param replyNo
	 * @return int
	 */
	int deleteReply(Integer replyNo);

	/**
	 * 댓글 목록 조회 Service
	 * @return List
	 */
	List<NoticeReplyVO> selectReplyList(Integer refNoticeNo);
	
	/**
	 * 댓글 수정 Service
	 * @param reply
	 * @return int
	 */
	int updateReply(NoticeReplyVO reply);

	


	
}
