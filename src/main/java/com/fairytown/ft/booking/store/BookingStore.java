package com.fairytown.ft.booking.store;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.booking.domain.vo.BookingVO;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.user.domain.vo.UserVO;

public interface BookingStore {

	/**
	 * 사용자 예약 목록 조회
	 * @param session
	 * @param user
	 * @return bList
	 */
	List<BookingVO> BookingListSelect(SqlSession session, UserVO user);

	/**
	 * 예약 개별 삭제
	 * @param session
	 * @param bookingNumber
	 * @return result
	 */
	int bookingDeleteOne(SqlSession session, String bookingNumber);

	/**
	 * 예약 전체 삭제
	 * @param session
	 * @return result
	 */
	int bookingDelete(SqlSession session, String userId);

	/**
	 * 기본예약 예약
	 * @param session
	 * @param rideList
	 * @return result
	 */
	int bookingBasic(SqlSession session, List<RideVO> rideList);

}
