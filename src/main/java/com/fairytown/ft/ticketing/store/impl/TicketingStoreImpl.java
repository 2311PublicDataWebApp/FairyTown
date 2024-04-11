package com.fairytown.ft.ticketing.store.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fairytown.ft.ticketing.store.TicketingStore;
import com.fairytown.ft.user.domain.vo.UserVO;

@Repository
public class TicketingStoreImpl implements TicketingStore{


	// 결제 후처리 - 결제정보 저장
	@Override
	public int ticktingRegister(SqlSession session, TicketingVO tingOne) {
		int result = session.insert("TicketingMapper.ticktingRegister", tingOne);
		return result;
	}

	// 결제 내역 조회
	@Override
	public List<TicketingVO> ticketingListSelect(SqlSession session, UserVO user) {
		List<TicketingVO> tingList = session.selectList("TicketingMapper.ticketingListSelect", user);
		// 티켓 예약 정보에 있는 티켓 번호로 티켓 정보 조회해야합니다.
//		List<TicketVO> tList = session.selectList("", tingList);
		return tingList;
	}

}
