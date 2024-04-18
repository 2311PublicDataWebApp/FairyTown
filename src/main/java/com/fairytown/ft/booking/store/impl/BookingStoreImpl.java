package com.fairytown.ft.booking.store.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.booking.domain.vo.BookingVO;
import com.fairytown.ft.booking.store.BookingStore;
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

	// 예약 전체 삭제
	@Override
	public int bookingDelete(SqlSession session,  String userId) {
		int result = session.delete("BookingMapper.bookingDelete", userId);
		return result;
	}

	// 기본예약 예약
	@Override
	public int bookingBasic(SqlSession session, List<RideVO> rideList) {
	    int totalCount = 0;
	    for (RideVO ride : rideList) {
	        int result = session.insert("BookingMapper.bookingBasic", ride);
	        totalCount += result;
	    }
	    return totalCount;
	}
}
