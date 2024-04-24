package com.fairytown.ft.booking.store;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.booking.domain.vo.BookingVO;
import com.fairytown.ft.common.PageInfo;
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
	 * 예약 개별 수정
	 * @param session
	 * @param bookingNumber
	 * @return
	 */
	int bookingUpdateOne(SqlSession session, BookingVO bbOne);

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
	int bookingBasic(SqlSession session, List<BookingVO> bookingList);
	
	/**
	 * 관리자 놀이기구 예약관리
	 * @param session
	 * @return
	 */
	List<BookingVO> BookingList(SqlSession session);

	/**
	 * 관리자 놀이기구 상세 뷰
	 * @param session
	 * @param bookingNumber
	 * @return
	 */
	BookingVO BookingDetail(SqlSession session, String bookingNumber);

	/**
	 * 관리자 놀이기구 예약 수정
	 * @param session
	 * @param bookingNumber
	 * @return
	 */
	BookingVO adminBookingUpdate(SqlSession session, BookingVO bbOne);

	/**
	 * 관리자 놀이기구 예약 삭제
	 * @param session
	 * @param bbOne
	 * @return
	 */
	int adminBookingDelete(SqlSession session, BookingVO bbOne);

	List<BookingVO> BookingListSelectPage(SqlSession session, UserVO user, PageInfo pInfo);


}
