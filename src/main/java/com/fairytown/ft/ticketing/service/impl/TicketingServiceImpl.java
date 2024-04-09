package com.fairytown.ft.ticketing.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fairytown.ft.ticketing.service.TicketingService;
import com.fairytown.ft.ticketing.store.TicketingStore;

@Service
public class TicketingServiceImpl implements TicketingService {

	@Autowired
	private SqlSession session;
	@Autowired
	private TicketingStore tingStore;
	
	// 입력 값으로 티켓 값 계산
	@Override
	public TicketingVO ticktingSelect(TicketingVO tingOne) {
		TicketingVO ticketing = tingStore.ticktingSelect(session, tingOne);
		return ticketing;
	}

}
