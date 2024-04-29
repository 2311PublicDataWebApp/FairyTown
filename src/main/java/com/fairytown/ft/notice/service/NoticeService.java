package com.fairytown.ft.notice.service;

import java.util.List;
import java.util.Map;

import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;



public interface NoticeService {

	/**
	 * 공지사항 등록 Service
	 * @param notice
	 * @return result
	 */
	int insertNotice(NoticeVO notice);
	
	/**
	 * 공지사항 수정 Service
	 * @param notice
	 * @return result
	 */
	int updateNotice(NoticeVO notice);
	
	/**
	 * 공지사항 삭제 Service
	 * @param noticeNo
	 * @return result
	 */
	int deleteNotice(int noticeNo);

	List<NoticeVO> selectNoticeList(NoticePageInfo pi);

	int getTotalCount();

	int getTotalCount(Map<String, String> paramMap);

	List<NoticeVO> searchNoticesByKeyword(NoticePageInfo pi, Map<String, String> paramMap);

	NoticeVO selectByNoticeNo(int noticeNo);

	List<NoticeVO> selectNoticeList();


}
