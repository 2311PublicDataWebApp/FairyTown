package com.fairytown.ft.qna.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.qna.domain.vo.QnaVO;

public interface QnaStore {
	// 문의 리스트
	List<QnaVO> selectQnaList(SqlSession session, PageInfo pInfo);
	
	// 페이징
	int selectTotalCount(SqlSession session);
	
	// 문의 상세페이지
	QnaVO selectByQnaNo(SqlSession session, int qnaNo);
	
	// 문의 삭제
	int deleteQna(SqlSession session, int qnaNo);
	
	// 문의 수정
	int updateQna(SqlSession session, QnaVO qna);
	
	// 문의 추가 
	int insertQna(SqlSession session, QnaVO qna);

	List<QnaVO> selectQnaList(SqlSession session, PageInfo pInfo, QnaVO qna);

	int selectTotalCount(SqlSession session, String userId);
	
}
