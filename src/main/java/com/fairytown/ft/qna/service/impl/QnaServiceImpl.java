package com.fairytown.ft.qna.service.impl;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;
import com.fairytown.ft.qna.domain.vo.QnaVO;
import com.fairytown.ft.qna.service.QnaService;
import com.fairytown.ft.qna.store.QnaStore;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	private QnaStore qStore;
	@Autowired
	private SqlSession session;
	
	// 페이징
	@Override
	public int getTotalCount() {
		int totalCount = qStore.selectTotalCount(session);
		return totalCount;
	}

	// 문의 리스트
	@Override
	public List<QnaVO> selectQnaList(PageInfo pInfo) {
		List<QnaVO> qList = qStore.selectQnaList(session, pInfo);
		return qList;
	}

	// 문의 상세페이지
	@Override
	public QnaVO selectByQnaNo(int qnaNo) {
		QnaVO qna = qStore.selectByQnaNo(session, qnaNo);
		return qna;
	}
	
	// 문의 삭제
	@Override
	public int deleteQna(int qnaNo) {
		int result = qStore.deleteQna(session, qnaNo);
		return result;
	}
	// 문의 수정
	@Override
	public int updateQna(QnaVO qna) {
		int result = qStore.updateQna(session, qna);
		return result;
	}
	// 문의 추가
	@Override
	public int insertQna(QnaVO qna) {
		int result = qStore.insertQna(session, qna);
		return result;
	}

	
	
	
		
}
