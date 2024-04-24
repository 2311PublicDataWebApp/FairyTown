package com.fairytown.ft.booking.store.impl;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.booking.domain.vo.BookingVO;
import com.fairytown.ft.booking.store.BookingStore;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.user.domain.vo.UserVO;

@Repository
public class BookingStoreImpl implements BookingStore{

	// 사용자 예약 목록 조회
	@Override
	public List<BookingVO> BookingListSelect(SqlSession session, UserVO user) {
		List<BookingVO> bList = session.selectList("BookingMapper.BookingListSelect", user);
		return bList;
	}

	// 예약 개별 삭제
	@Override
	public int bookingDeleteOne(SqlSession session, String bookingNumber) {
		int result = session.delete("BookingMapper.bookingDeleteOne", bookingNumber);
		return result;
	}

	// 예약 개별 수정
	@Override
	public int bookingUpdateOne(SqlSession session, BookingVO bbOne) {
		int result = session.update("BookingMapper.bookingUpdateOne", bbOne);
		return result;
	}

	// 예약 전체 삭제
	@Override
	public int bookingDelete(SqlSession session,  String userId) {
		int result = session.delete("BookingMapper.bookingDelete", userId);
		return result;
	}

	// 기본예약 예약
	@Override
	public int bookingBasic(SqlSession session, List<BookingVO> bookingList) {
	    int totalCount = 0;
	    for (BookingVO booking : bookingList) {
	        int result = session.insert("BookingMapper.bookingBasic", booking);
	        totalCount += result;
	    }
	    return totalCount;
	}

	// 관리자 놀이기구 예약관리
	@Override
	public List<BookingVO> BookingList(SqlSession session) {
		List<BookingVO> bList = session.selectList("BookingMapper.BookingList");
		return bList;
	}

	// 관리자 놀이기구 상세 뷰
	@Override
	public BookingVO BookingDetail(SqlSession session, String bookingNumber) {
		BookingVO bOne = session.selectOne("BookingMapper.BookingDetail",bookingNumber);
		return bOne;
	}

	// 관리자 놀이기구 예약 수정 
	@Override
	public BookingVO adminBookingUpdate(SqlSession session,BookingVO bbOne) {
		int result = session.update("BookingMapper.adminBookingUpdate", bbOne);
		if (result > 0) {
			String bookingNumber = String.valueOf(bbOne.getBookingNumber());
			BookingVO bOne = this.BookingDetail(session, bookingNumber);
			return bOne;
		}else {
	        throw new RuntimeException("Failed to update booking.");
		}
	}

	// 관리자 놀이기구 예약 삭제
	@Override
	public int adminBookingDelete(SqlSession session, BookingVO bbOne) {
		int result = session.delete("BookingMapper.adminBookingDelete", bbOne);
		return result;
	}

	@Override
	public List<BookingVO> BookingListSelectPage(SqlSession session, UserVO user, PageInfo pInfo) {
		int limit = pInfo.getBoardLimit();
		int offset = (pInfo.getCurrentPage() - 1) * pInfo.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<BookingVO> bListP = session.selectList("BookingMapper.BookingListSelect", user, rowBounds);
		for (BookingVO booking : bListP) {
			RideVO ride = session.selectOne("com.fairytown.ft.ride.store.RideStore.selectByRideId",booking.getRideId());
			booking.setRide(ride);
		}
		return bListP;
	}
}
