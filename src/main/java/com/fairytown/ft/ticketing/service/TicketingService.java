package com.fairytown.ft.ticketing.service;

import com.fairytown.ft.ticketing.domain.vo.TicketingVO;

public interface TicketingService {

	/**
	 * 입력 값으로 티켓 값 계산
	 * @param tingOne
	 * @return ticketing
	 */
	TicketingVO ticktingSelect(TicketingVO tingOne);

}
