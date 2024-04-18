package com.fairytown.ft.booking.service;

import java.util.List;

import com.fairytown.ft.booking.domain.vo.BookingVO;
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
	 * 예약 전체 삭제
	 * @return result
	 */
	int bookingDelete(String userId);

	/**
	 * 기본예약 예약
	 * @param rideList
	 * @return result
	 */
	int bookingBasic(List<RideVO> rideList);

}
