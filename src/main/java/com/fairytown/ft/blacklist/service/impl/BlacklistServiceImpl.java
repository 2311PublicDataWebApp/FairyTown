//package com.fairytown.ft.blacklist.service.impl;
//
//import java.util.List;
//import java.util.Map;
//
//import org.apache.ibatis.session.RowBounds;
//import org.apache.ibatis.session.SqlSession;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.fairytown.ft.blacklist.domain.vo.BlacklistVO;
//import com.fairytown.ft.blacklist.service.BlacklistService;
//import com.fairytown.ft.blacklist.store.BlacklistStore;
//import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
//import com.fairytown.ft.notice.domain.vo.NoticeVO;
//
//@Service
//public class BlacklistServiceImpl implements BlacklistService{
//	
//	@Autowired
//	private BlacklistStore bStore;
//	@Autowired
//	private SqlSession session;
//	
//	@Override
//	public List<BlacklistVO> selectBlacklist(NoticePageInfo pi) {
//		List<BlacklistVO> bList = bStore.selectBlacklist(session, pi);
//		return bList;
//	}
//
////	@Override
////	public List<BlacklistVO> searchBlacklistsByKeyword(NoticePageInfo pi, Map<String, String> paramMap) {
////		int limit = pi.getBoardLimit();
////		int offset = (pi.getCurrentPage() - 1) * limit;
////		RowBounds rowBounds = new RowBounds(offset, limit);
////		List<NoticeVO> searchList = bStore.selectNoticesByKeyword(session, rowBounds, paramMap);
////		return searchList;
////	}
//
//	@Override
//	public int getTotalCount(Map<String, String> paramMap) {
//		int totalCount = bStore.selectTotalCount(session, paramMap);
//		return totalCount;
//	}
//
//	@Override
//	public int getTotalCount() {
//		int totalCount = bStore.selectTotalCount(session);
//		return totalCount;
//	}
//
//	@Override
//	public List<BlacklistVO> searchBlacklistsByKeyword(NoticePageInfo pi, Map<String, String> paramMap) {
//		int limit = pi.getBoardLimit();
//		int offset = (pi.getCurrentPage() - 1) * limit;
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		List<BlacklistVO> searchList = bStore.selectBlacklistsByKeyword(session, rowBounds, paramMap);
//		return searchList;
//	}
//
//}
