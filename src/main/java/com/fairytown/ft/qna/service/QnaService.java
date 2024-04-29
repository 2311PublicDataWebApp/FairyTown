package com.fairytown.ft.qna.service;

import java.util.List;
import java.util.Map;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.qna.domain.vo.QnaVO;

public interface QnaService {
	// 페이징
	int getTotalCount();

	// 문의 리스트
	List<QnaVO> selectQnaList(PageInfo pInfo, QnaVO qna);
	List<QnaVO> selectQnaList(PageInfo pInfo);
	
	// 문의 상세 페이지
	QnaVO selectByQnaNo(int qnaNo);
	
	// 문의 삭제
	int deleteQna(int qnaNo);
	
	// 문의 수정
	int updateQna(QnaVO qna);
	
	// 문의 추가
	int insertQna(QnaVO qna);

	int getTotalCount(String userId);
	
	
	
}
