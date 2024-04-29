package com.fairytown.ft.review.store.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
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

//	@Override
//	public ReviewVO selectByReviewNo(SqlSession session, int reviewNo) {
//	    ReviewVO review = session.selectOne("ReviewMapper.selectByReviewNo", reviewNo);
//	    List<ReviewImageVO> imageList = session.selectList("ReviewMapper.selectReviewImageList", reviewNo);
//	    review.setImages(imageList); // 리뷰에 이미지 정보 추가
//	    return review;
//	}
	
	@Override
	public ReviewVO selectByReviewNo(SqlSession session, int reviewNo) {
	    ReviewVO review = session.selectOne("ReviewMapper.selectImagesByReviewNo", reviewNo);
	    return review;
	}
	
//	@Override
//	public int deleteReview(SqlSession session, int reviewNo) {
//		int result = session.delete("ReviewMapper.deleteReviewTransaction", reviewNo);
//		return result;
//	}

	@Override
	public int selectTotalCount(SqlSession session) {
		int totalCount = session.selectOne("ReviewMapper.selectTotalCount");
		return totalCount;
	}

	@Override
	public List<ReviewVO> selectReviewList(SqlSession session, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<ReviewVO> rList = session.selectList("ReviewMapper.selectReviewList", pi.getType(), rowBounds);
		return rList;
	}
	
	@Override
	public List<ReviewVO> selectReviewList(SqlSession session, PageInfo pi, String sortType) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<ReviewVO> sortList = session.selectList("ReviewMapper.sortReviewByType", sortType, rowBounds);
		return sortList;
	}

	@Override
	public List<ReviewVO> selectMyReviewList(SqlSession session, String realName, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
//		List<ReviewVO> myReviewList = session.selectList("ReviewMapper.selectMyReviewList", pi.getType(), rowBounds);
		List<ReviewVO> myReviewList = session.selectList("ReviewMapper.selectMyReviewList", realName);
		return myReviewList;
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

	@Override
	public ReviewVO selectBestReview(SqlSession session) {
		ReviewVO bestReview = session.selectOne("ReviewMapper.selectBestReview");
		return bestReview;
	}

	@Override
	public List<ReviewVO> getTopLikedReviews(SqlSession session) {
		List<ReviewVO> lList = session.selectList("ReviewMapper.selectTopLikedReview");
		return lList;
	}

	@Override
	public List<ReviewVO> getReviews(SqlSession session, int startIdx, int endIdx) {
		// startIdx부터 endIdx까지의 범위에 해당하는 리뷰 목록 반환
        // 매퍼에서 정의한 쿼리를 실행하여 데이터베이스에서 리뷰 목록을 가져옴
	    RowBounds rowBounds = new RowBounds(startIdx, endIdx - startIdx); // 시작 인덱스와 가져올 개수 설정
        List<ReviewVO> reviewList = session.selectList("ReviewMapper.getReviewsInRange", null, rowBounds);
        return reviewList;
	}

	@Override
	public int deleteReview(SqlSession session, int reviewNo) {
		return session.delete("ReviewMapper.deleteReview", reviewNo);
	}

	@Override
	public int deleteUserLikedReview(SqlSession session, int reviewNo) {
		return session.delete("ReviewMapper.deleteUserLikedReview", reviewNo);
	}

	@Override
	public int deleteReviewImage(SqlSession session, int reviewNo) {
		return session.delete("ReviewMapper.deleteReviewImage", reviewNo);
	}

	@Override
	public int updateReview(SqlSession session, ReviewVO review) {
		int result = session.update("ReviewMapper.updateReview", review);
//		result += session.update("ReviewMapper.updateReviewImg", review);
		return result;
	}

	@Override
	public List<ReviewVO> selectReviewList(SqlSession session) {
		List<ReviewVO> rList = session.selectList("ReviewMapper.adminSelectReviewList");
		return rList;
	}
	
	@Override
    public List<ReviewImageVO> select6ReviewList(SqlSession session) {
        List<ReviewImageVO> String = session.selectList("ReviewMapper.select6ReviewList");
        return String;
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
