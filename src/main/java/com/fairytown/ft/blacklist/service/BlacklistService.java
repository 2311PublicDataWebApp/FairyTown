package com.fairytown.ft.blacklist.service;

import java.util.List;
import java.util.Map;

import com.fairytown.ft.blacklist.domain.vo.BlacklistVO;
import com.fairytown.ft.notice.domain.vo.NoticePageInfo;

public interface BlacklistService {

	/**
	 * 블리유저 리스트 Service
	 * @param pi
	 * @return List
	 */
	List<BlacklistVO> selectBlacklist(NoticePageInfo pi);

	List<BlacklistVO> searchBlacklistsByKeyword(NoticePageInfo pi, Map<String, String> paramMap);

	int getTotalCount(Map<String, String> paramMap);

	int getTotalCount();

}
