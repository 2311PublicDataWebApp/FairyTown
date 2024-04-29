package com.fairytown.ft.review.service;

import java.util.List;
import java.util.Map;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.review.domain.vo.ReviewImageVO;
import com.fairytown.ft.review.domain.vo.ReviewVO;

public interface ReviewService {

	/**
	 * 리뷰 등록 Service
	 * @param review
	 * @return result
	 */
	int insertReview(ReviewVO review);

	/**
	 * 리뷰 상세보기 Service
	 * @param reviewNo
	 * @return review
	 */
	ReviewVO selectByReviewNo(int reviewNo);

	/**
	 * 리뷰 삭제 Service
	 * @param reviewNo
	 * @return result
	 */
	int deleteReview(int reviewNo);

	int getTotalCount();

	List<ReviewVO> selectReviewList(PageInfo pi);

	List<ReviewVO> selectReviewList(PageInfo pi, String sortType);
	
	/**
	 * 조회수 카운트 Service
	 * @param reviewNo
	 */
	void updateViewCount(int reviewNo);

	/**
	 * 유용해요 카운트 Service
	 * @param reviewNo
	 */
//	void updateLikeCount(int reviewNo);
//
//	void updateLikeCount(int reviewNo, String action);

	/**
	 * 유용해요 +1 Service
	 * @param reviewNo
	 */
	void increaseLikeCount(int reviewNo);

	/**
	 * 유용해요 -1 Service
	 * @param reviewNo
	 */
	void decreaseLikeCount(int reviewNo);

	int getTotalCount(Map<String, String> paramMap);

	List<ReviewVO> searchReviewsByKeyword(PageInfo pi, Map<String, String> paramMap);

	/**
	 * 이미지 등록 Service
	 * @param image
	 */
	void insertImage(ReviewImageVO image);

	ReviewVO getBestReview();

	List<ReviewVO> getTopLikedReviews();

	List<ReviewVO> getReviewsForPage(int i);

	/**
	 * 리뷰 수정 Service
	 * @param review
	 * @return int
	 */
	int updateReview(ReviewVO review);

	/**
	 * 내가 등록한 리뷰 Service
	 * @param pi
	 * @return List
	 */
	List<ReviewVO> selectMyReviewList(String realName, PageInfo pi);

	List<ReviewVO> selectReviewList();

	List<ReviewImageVO> selectTop4Reviews();


}
