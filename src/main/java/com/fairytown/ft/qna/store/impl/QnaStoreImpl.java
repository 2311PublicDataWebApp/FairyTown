package com.fairytown.ft.qna.store.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;
import com.fairytown.ft.qna.domain.vo.QnaVO;
import com.fairytown.ft.qna.store.QnaStore;

@Repository
public class QnaStoreImpl implements QnaStore{
	
	// 문의 리스트
	@Override
	public List<QnaVO> selectQnaList(SqlSession session, PageInfo pInfo) {
		int limit = pInfo.getNaviLimit();
		int offset = (pInfo.getCurrentPage() - 1) * pInfo.getNaviLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<QnaVO> qList = session.selectList("QnaMapper.selectQnaList", null, rowBounds);
		return qList;
	}
	
	// 문의 페이징
	@Override
	public int selectTotalCount(SqlSession session) {
		int totalCount = session.selectOne("QnaMapper.selectTotalCount");
		return totalCount;
	}
	
	// 문의 상세 페이지
	@Override
	public QnaVO selectByQnaNo(SqlSession session, int qnaNo) {
		QnaVO qna = session.selectOne("QnaMapper.selectByQnaNo", qnaNo);
		return qna;
	}
	
	// 문의 삭제
	@Override
	public int deleteQna(SqlSession session, int qnaNo) {
		int result = session.delete("QnaMapper.deleteQna", qnaNo);
		return result;
	}
	
	// 문의 수정
	@Override
	public int updateQna(SqlSession session, QnaVO qna) {
		int result = session.update("QnaMapper.updateQna", qna);
		return result;
	}
	
	// 문의 추가
	@Override
	public int insertQna(SqlSession session, QnaVO qna) {
		int result = session.insert("QnaMapper.insertQna", qna);
		return result;
	}




	
}
