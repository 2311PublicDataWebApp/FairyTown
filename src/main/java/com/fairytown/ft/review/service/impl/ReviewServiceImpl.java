package com.fairytown.ft.review.service.impl;

import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;
import com.fairytown.ft.review.domain.vo.ReviewImageVO;
import com.fairytown.ft.review.domain.vo.ReviewVO;
import com.fairytown.ft.review.service.ReviewService;
import com.fairytown.ft.review.store.ReviewStore;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private SqlSession session;
	@Autowired
	private ReviewStore rStore;
	
	@Override
	public int insertReview(ReviewVO review) {
		int result = rStore.insertReview(session, review);
		return result;
	}

	@Override
	public ReviewVO selectByReviewNo(int reviewNo) {
		ReviewVO review = rStore.selectByReviewNo(session, reviewNo);
//		List<ReviewImageVO> imageList = rStore.selectImageList(session, reviewNo);
//		review.setImages(imageList);
		return review;
	}

	@Override
	public int deleteReview(int reviewNo) {
		int result = rStore.deleteReview(session, reviewNo);
		return result;
	}

	@Override
	public int getTotalCount() {
		int totalCount = rStore.selectTotalCount(session);
		return totalCount;
	}

	@Override
	public List<ReviewVO> selectReviewList(NoticePageInfo pi) {
		List<ReviewVO> rList = rStore.selectReviewList(session, pi);
		return rList;
	}

	@Override
	public void updateViewCount(int reviewNo) {
		rStore.updateViewCount(session, reviewNo);		
	}

//	@Override
//	public void updateLikeCount(int reviewNo) {
//		rStore.updateLikeCount(session, reviewNo);
//		
//	}
//
//	@Override
//	public void updateLikeCount(int reviewNo, String action) {
//		rStore.updateLikeCount(session, reviewNo, action);		
//	}

	@Override
	public void increaseLikeCount(int reviewNo) {
		rStore.increaseLikeCount(session, reviewNo);
		
	}
	@Override
	public void decreaseLikeCount(int reviewNo) {
		rStore.decreaseLikeCount(session, reviewNo);
		
	}

	@Override
	public int getTotalCount(Map<String, String> paramMap) {
		int totalCount = rStore.selectTotalCount(session, paramMap);
		return totalCount;
	}

	@Override
	public List<ReviewVO> searchReviewsByKeyword(NoticePageInfo pi, Map<String, String> paramMap) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<ReviewVO> searchList = rStore.selectReviewsByKeyword(session, rowBounds, paramMap);
		return searchList;
	}

	@Override
	public void insertImage(ReviewImageVO image) {
		rStore.insertImage(session, image);
		
	}

	@Override
	public ReviewVO getBestReview() {
		// 가장 조회수가 높은 리뷰의 정보를 조회하여 ReviewVO 객체에 담아 반환
		return rStore.selectBestReview(session);
	}



	
	
	
}
