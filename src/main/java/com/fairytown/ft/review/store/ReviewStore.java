package com.fairytown.ft.review.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.review.domain.vo.ReviewImageVO;
import com.fairytown.ft.review.domain.vo.ReviewVO;

public interface ReviewStore {

	/**
	 * 리뷰 등록 Store
	 * @param session
	 * @param review
	 * @return result
	 */
	int insertReview(SqlSession session, ReviewVO review);

	/**
	 * 리뷰 상세보기 Store
	 * @param session
	 * @param reviewNo
	 * @return review
	 */
	ReviewVO selectByReviewNo(SqlSession session, int reviewNo);

	/**
	 * 리뷰 삭제 Store
	 * @param session
	 * @param reviewNo
	 * @return result
	 */
	int deleteReview(SqlSession session, int reviewNo);

	int selectTotalCount(SqlSession session);

	List<ReviewVO> selectReviewList(SqlSession session, PageInfo pi);

	List<ReviewVO> selectReviewList(SqlSession session, PageInfo pi, String sortType);
	
	/**
	 * 조회수 카운트 Store
	 * @param reviewNo
	 */
	void updateViewCount(SqlSession session, int reviewNo);

	void increaseLikeCount(SqlSession session, int reviewNo);

	void decreaseLikeCount(SqlSession session, int reviewNo);

	int selectTotalCount(SqlSession session, Map<String, String> paramMap);


	List<ReviewVO> selectReviewsByKeyword(SqlSession session, RowBounds rowBounds, Map<String, String> paramMap);

	void insertImage(SqlSession session, ReviewImageVO image);

	ReviewVO selectBestReview(SqlSession session);

	List<ReviewVO> getTopLikedReviews(SqlSession session);

	List<ReviewVO> getReviews(SqlSession session, int startIdx, int endIdx);

	int deleteUserLikedReview(SqlSession session, int reviewNo);

	int deleteReviewImage(SqlSession session, int reviewNo);

	int updateReview(SqlSession session, ReviewVO review);
	
	/**
	 * 유용해요 카운트 Store
	 * @param reviewNo
	 */
//	void updateLikeCount(SqlSession session, int reviewNo);
//
//	void updateLikeCount(SqlSession session, int reviewNo, String action);




}
