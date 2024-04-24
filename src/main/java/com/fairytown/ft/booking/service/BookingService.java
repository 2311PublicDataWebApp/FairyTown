package com.fairytown.ft.booking.service;

import java.util.List;

import com.fairytown.ft.booking.domain.vo.BookingVO;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.user.domain.vo.UserVO;

public interface BookingService {

	/**
	 * 사용자 예약 목록 조회
	 * @param user
	 * @return bList
	 */
	List<BookingVO> BookingListSelect(UserVO user);

	/**
	 * 예약 개별 삭제
	 * @param bookingNumber
	 * @return result
	 */
	int bookingDeleteOne(String bookingNumber);

	/**
	 * 예약 개별 수정
	 * @param bookingNumber
	 * @return
	 */
	int bookingUpdateOne(BookingVO bbOne);

	/**
	 * 예약 전체 삭제
	 * @return result
	 */
	int bookingDelete(String userId);

	/**
	 * 기본예약 예약
	 * @param bookingList
	 * @return result
	 */
	int bookingBasic(List<BookingVO> bookingList);

	/**
	 * 관리자 놀이기구 예약관리
	 * @return
	 */
	List<BookingVO> BookingList();
	
	/**
	 * 관리자 놀이기구 상세 뷰
	 * @param bookingNumber
	 * @return
	 */
	BookingVO BookingDetail(String bookingNumber);

	/**
	 * 관리자 놀이기구 예약 수정
	 * @param bookingNumber
	 * @return
	 */
	BookingVO adminBookingUpdate(BookingVO bbOne);

	/**
	 * 관리자 놀이기구 예약 삭제
	 * @param bbOne
	 * @return
	 */
	int adminBookingDelete(BookingVO bbOne);

	List<BookingVO> BookingListSelectPage(UserVO user, PageInfo pInfo);

}
