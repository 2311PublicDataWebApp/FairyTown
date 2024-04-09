package com.fairytown.ft.notice.service;

import java.util.List;
import java.util.Map;

import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;



public interface NoticeService {

	int insertNotice(NoticeVO notice);

	List<NoticeVO> selectNoticeList(NoticePageInfo pi);

	int getTotalCount();

	int getTotalCount(Map<String, String> paramMap);

	List<NoticeVO> searchNoticesByKeyword(NoticePageInfo pi, Map<String, String> paramMap);

	NoticeVO selectByNoticeNo(int noticeNo);

	int updateNotice(NoticeVO notice);

	int deleteNotice(int noticeNo);

}
