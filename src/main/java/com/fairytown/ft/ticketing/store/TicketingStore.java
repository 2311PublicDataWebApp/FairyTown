package com.fairytown.ft.ticketing.store;

import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.ticketing.domain.vo.TicketingVO;

public interface TicketingStore {

	/**
	 * 입력 값으로 티켓 값 계산
	 * @param session 
	 * @param tingOne
	 * @return ticketing
	 */
	TicketingVO ticktingSelect(SqlSession session, TicketingVO tingOne);

}
