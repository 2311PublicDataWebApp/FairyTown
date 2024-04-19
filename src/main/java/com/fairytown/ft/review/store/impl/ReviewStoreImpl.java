package com.fairytown.ft.review.store.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;
import com.fairytown.ft.review.domain.vo.ReviewImageVO;
import com.fairytown.ft.review.domain.vo.ReviewVO;
import com.fairytown.ft.review.store.ReviewStore;

@Repository
public class ReviewStoreImpl implements ReviewStore{

	@Override
	public int insertReview(SqlSession session, ReviewVO review) {
		int result = session.insert("ReviewMapper.insertReview", review);
		return result;
	}

	@Override
	public ReviewVO selectByReviewNo(SqlSession session, int reviewNo) {
	    ReviewVO review = session.selectOne("ReviewMapper.selectByReviewNo", reviewNo);
	    List<ReviewImageVO> imageList = session.selectList("ReviewMapper.selectReviewImageList", reviewNo);
	    review.setImages(imageList); // 리뷰에 이미지 정보 추가
	    return review;
	}


	@Override
	public int deleteReview(SqlSession session, int reviewNo) {
		int result = session.delete("ReviewMapper.deleteReview", reviewNo);
		return result;
	}

	@Override
	public int selectTotalCount(SqlSession session) {
		int totalCount = session.selectOne("ReviewMapper.selectTotalCount");
		return totalCount;
	}

	@Override
	public List<ReviewVO> selectReviewList(SqlSession session, NoticePageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<ReviewVO> rList = session.selectList("ReviewMapper.selectReviewList", null, rowBounds);
		return rList;
	}

	@Override
	public void updateViewCount(SqlSession session, int reviewNo) {
		session.update("ReviewMapper.updateViewCount", reviewNo);		
	}

	@Override
	public void increaseLikeCount(SqlSession session, int reviewNo) {
	    session.update("increaseLikeCount", reviewNo);
	}

	@Override
	public void decreaseLikeCount(SqlSession session, int reviewNo) {
	    session.update("decreaseLikeCount", reviewNo);
	}

	@Override
	public int selectTotalCount(SqlSession session, Map<String, String> paramMap) {
		int totalCount = session.selectOne("ReviewMapper.searchTotalCount", paramMap);
		return totalCount;
	}

	@Override
	public List<ReviewVO> selectReviewsByKeyword(SqlSession session, RowBounds rowBounds,
			Map<String, String> paramMap) {
		List<ReviewVO> searchList = session.selectList("ReviewMapper.selectReviewsByKeyword", paramMap, rowBounds);
		return searchList;	
	}

	@Override
	public void insertImage(SqlSession session, ReviewImageVO image) {
		session.insert("ReviewMapper.insertImage", image);
	}	
	
//	@Override
//	public void increaseLikeCount(SqlSession session, int reviewNo) {
//		session.update("updateLikeCountByAction", Map.of("reviewNo", reviewNo, "action", "increase"));
//		
//	}
//
//	@Override
//	public void decreaseLikeCount(SqlSession session, int reviewNo) {
//        session.update("updateLikeCountByAction", Map.of("reviewNo", reviewNo, "action", "decrease"));		
//	}

//	@Override
//	public void updateLikeCount(SqlSession session, int reviewNo) {
//		session.update("ReviewMapper.updateLikeCountByAction", reviewNo);
//	}
//
//	@Override
//	public void updateLikeCount(SqlSession session, int reviewNo, String action) {
//	    Map<String, Object> parameters = new HashMap<>();
//	    parameters.put("reviewNo", reviewNo);
//	    parameters.put("action", action);
//	    session.update("ReviewMapper.updateLikeCountByMap", parameters);
//	}




	
}
