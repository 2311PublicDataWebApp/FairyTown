package com.fairytown.ft.ticketing.store;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ticket.domain.vo.TicketVO;
import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fairytown.ft.user.domain.vo.UserVO;

public interface TicketingStore {


	/**
	 * 결제 후처리 - 결제정보 저장
	 * @param session
	 * @param tingOne
	 * @return result
	 */
	int ticktingRegister(SqlSession session, TicketingVO tingOne);

	/**
	 * 결제 내역 조회
	 * @param session
	 * @param user
	 * @return list
	 */
	List<TicketingVO> ticketingListSelect(SqlSession session, UserVO user);

	/**
	 * 티켓 변경 로직
	 * @param session
	 * @param ticketingCode
	 * @return tingOne
	 */
	TicketingVO sendTicketingCode(SqlSession session, String ticketingCode);

	/**
	 * 티켓 결제 취소
	 * @param session
	 * @param ticketingCode
	 * @return result
	 */
	int ticketingCancle(SqlSession session, String ticketingCode);

	/**
	 * 티켓 번호로 조회
	 * @param session 
	 * @param ticketNo
	 * @return
	 */
	TicketVO selectByTicketNo(SqlSession session, Integer ticketNo);

	/**
	 * 관리자 - 티켓팅조회
	 * @param session
	 * @return
	 */
	List<TicketingVO> TicketingList(SqlSession session);

	/**
	 * 관리자 티켓 결제상세 뷰
	 * @param session
	 * @param ticketCode
	 * @return
	 */
	TicketingVO TicketingDetail(SqlSession session, String ticketCode);

	List<TicketingVO> ticketingListSelectPage(SqlSession session, UserVO user, PageInfo pInfo);

}