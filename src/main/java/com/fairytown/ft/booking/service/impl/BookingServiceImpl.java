package com.fairytown.ft.booking.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.booking.domain.vo.BookingVO;
import com.fairytown.ft.booking.service.BookingService;
import com.fairytown.ft.booking.store.BookingStore;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.user.domain.vo.UserVO;

@Service
public class BookingServiceImpl implements BookingService{
	
	@Autowired
	private SqlSession session;
	@Autowired
	private BookingStore bStore;
	
	// 사용자 예약 목록 조회
	@Override
	public List<BookingVO> BookingListSelect(UserVO user) {
		List<BookingVO> bList = bStore.BookingListSelect(session, user);
		return bList;
	}

	// 예약 개별 삭제
	@Override
	public int bookingDeleteOne(String bookingNumber) {
		int result = bStore.bookingDeleteOne(session, bookingNumber);
		return result;
	}

	// 예약 개별 수정
	@Override
	public int bookingUpdateOne(BookingVO bbOne) {
		int result = bStore.bookingUpdateOne(session, bbOne);
		return result;
	}

	// 예약 전체 삭제
	@Override
	public int bookingDelete(String userId) {
		int result = bStore.bookingDelete(session, userId);
		return result;
	}

	// 기본예약 예약
	@Override
	public int bookingBasic(List<BookingVO> bookingList) {
		int result = bStore.bookingBasic(session, bookingList);
		return result;
	}
	// 관리자 놀이기구 예약관리
	@Override
	public List<BookingVO> BookingList() {
		List<BookingVO> bList = bStore.BookingList(session);
		return bList;
	}

	// 관리자 놀이기구 상세 뷰
	@Override
	public BookingVO BookingDetail(String bookingNumber) {
		BookingVO bOne = bStore.BookingDetail(session, bookingNumber);
		return bOne;
	}

	// 관리자 놀이기구 예약 수정
	@Override
	public BookingVO adminBookingUpdate(BookingVO bbOne) {
		BookingVO bOne = bStore.adminBookingUpdate(session, bbOne);
		return bOne;
	}

	// 관리자 놀이기구 예약 삭제
	@Override
	public int adminBookingDelete(BookingVO bbOne) {
        int result = bStore.adminBookingDelete(session, bbOne);
		return result;
	}

	@Override
	public List<BookingVO> BookingListSelectPage(UserVO user, PageInfo pInfo) {
		List<BookingVO> bListP = bStore.BookingListSelectPage(session, user, pInfo);
		return bListP;
	}

	
}
