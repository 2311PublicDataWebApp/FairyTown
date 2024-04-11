package com.fairytown.ft.ticketing.service;

import java.util.List;

import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fairytown.ft.user.domain.vo.UserVO;

public interface TicketingService {

	/**
	 * 결제 후처리 - 결제정보 저장
	 * @param tingOne
	 * @return result
	 */
	int ticktingRegister(TicketingVO tingOne);

	/**
	 * 결제 내역 조회
	 * @param user
	 * @return list
	 */
	List<TicketingVO> ticketingListSelect(UserVO user);

}
