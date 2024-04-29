package com.fairytown.ft.review.service.impl;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
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
import org.springframework.transaction.annotation.Transactional;

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

//	@Override
//	public int deleteReview(int reviewNo) {
//		int result = rStore.deleteReview(session, reviewNo);
//		return result;
//	}
	
	@Override
	@Transactional
	public int deleteReview(int reviewNo) {
		int result1 = rStore.deleteReviewImage(session, reviewNo);
	    int result2 = rStore.deleteUserLikedReview(session, reviewNo);
	    int result3 = rStore.deleteReview(session, reviewNo);
	    return result1 + result2 + result3;
	}

	@Override
	public int getTotalCount() {
		int totalCount = rStore.selectTotalCount(session);
		return totalCount;
	}

	@Override
	public List<ReviewVO> selectReviewList(PageInfo pi) {
		List<ReviewVO> rList = rStore.selectReviewList(session, pi);
		return rList;
	}
	
	@Override
	public List<ReviewVO> selectReviewList(PageInfo pi, String sortType) {
		List<ReviewVO> sortList = rStore.selectReviewList(session, pi, sortType);
		return sortList;
	}
	
	@Override
	public List<ReviewVO> selectMyReviewList(String realName, PageInfo pi) {
		List<ReviewVO> myReviewList = rStore.selectMyReviewList(session, realName, pi);
		return myReviewList;
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
	public List<ReviewVO> searchReviewsByKeyword(PageInfo pi, Map<String, String> paramMap) {
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

	@Override
	public List<ReviewVO> getTopLikedReviews() {
		return rStore.getTopLikedReviews(session);
	}

	@Override
	public List<ReviewVO> getReviewsForPage(int page) {
	    // 페이지당 리뷰 개수
	    int pageSize = 12;
	    // 페이지의 시작 인덱스 계산
	    int startIdx = (page - 1) * pageSize;
	    // 페이지의 끝 인덱스 계산
	    int endIdx = startIdx + pageSize;
	    // 데이터베이스에서 페이지별 리뷰 목록을 조회하는 DAO 메서드 호출
	    List<ReviewVO> reviews = rStore.getReviews(session, startIdx, endIdx);

	    return reviews;
	}

	@Override
	public int updateReview(ReviewVO review) {
		int result = rStore.updateReview(session, review);
		return result;
	}

	@Override
	public List<ReviewVO> selectReviewList() {
		List<ReviewVO> rList = rStore.selectReviewList(session);
		return rList;
	}



	
	
	
}
