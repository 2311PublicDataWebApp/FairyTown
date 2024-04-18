package com.fairytown.ft.ticketing.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.ticket.domain.vo.TicketVO;
import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fairytown.ft.ticketing.service.TicketingService;
import com.fairytown.ft.ticketing.store.TicketingStore;
import com.fairytown.ft.user.domain.vo.UserVO;

@Service
public class TicketingServiceImpl implements TicketingService {

	@Autowired
	private SqlSession session;
	@Autowired
	private TicketingStore tingStore;

	// 결제 후처리 - 결제정보 저장
	@Override
	public int ticktingRegister(TicketingVO tingOne) {
		int result = tingStore.ticktingRegister(session, tingOne);
		return result;
	}

	// 결제 내역 조회
	@Override
	public List<TicketingVO> ticketingListSelect(UserVO user) {
		List<TicketingVO> tingList = tingStore.ticketingListSelect(session, user);
		return tingList;
	}
	// 티켓 변경 로직
	@Override
	public TicketingVO sendTicketingCode(String ticketingCode) {
		TicketingVO tingOne = tingStore.sendTicketingCode(session, ticketingCode);
		return tingOne;
	}
	// 티켓 결제 취소
	@Override
	public int ticketingCancle(String ticketingCode) {
		int result = tingStore.ticketingCancle(session, ticketingCode);
		return result;
	}

	// 티켓 번호로 조회
	@Override
	public TicketVO selectByTicketNo(Integer ticketNo) {
		TicketVO ticketOne = tingStore.selectByTicketNo(session, ticketNo);
		return ticketOne;
	}

}
