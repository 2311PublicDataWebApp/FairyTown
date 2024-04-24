package com.fairytown.ft.ticketing.store.impl;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ticket.domain.vo.TicketVO;
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
		// 1. 티켓 예약 정보 조회
		List<TicketingVO> tingList = session.selectList("TicketingMapper.ticketingListSelect", user);
		// 2. 티켓 정보 조회
	    for (TicketingVO ting : tingList) {
	    	 TicketVO ticket = session.selectOne("com.fairytown.ft.ticket.store.TicketStore.selectByTicketNumber", ting.getTicketNumber());
	    	 ting.setTicket(ticket);
	    }
		return tingList;
	}
	// 티켓 변경 로직
	@Override
	public TicketingVO sendTicketingCode(SqlSession session, String ticketingCode) {
		TicketingVO tingOne = session.selectOne("TicketingMapper.sendTicketingCode", ticketingCode);
		return tingOne;
	}

	// 티켓 결제 취소
	@Override
	public int ticketingCancle(SqlSession session, String ticketingCode) {
		int result = session.update("TicketingMapper.ticketingCancle", ticketingCode);
		return result;
	}

	// 티켓 번호로 조회
	@Override
	public TicketVO selectByTicketNo(SqlSession session, Integer ticketNumber) {
		TicketVO ticketOne = session.selectOne("com.fairytown.ft.ticket.store.TicketStore.selectByTicketNumber", ticketNumber);
		ticketOne.setTicketNo(ticketNumber.toString());
		return ticketOne;
	}

	// 관리자 - 티켓팅조회
	@Override
	public List<TicketingVO> TicketingList(SqlSession session) {
		List<TicketingVO> tingList = session.selectList("TicketingMapper.TicketingList");
		return tingList;
	}

	// 관리자 티켓 결제상세 뷰
	@Override
	public TicketingVO TicketingDetail(SqlSession session, String ticketCode) {
		TicketingVO tingOne = session.selectOne("TicketingMapper.TicketingDetail",ticketCode);
		return tingOne;
	}

	@Override
	public List<TicketingVO> ticketingListSelectPage(SqlSession session, UserVO user, PageInfo pInfo) {
		int limit = pInfo.getBoardLimit();
		int offset = (pInfo.getCurrentPage() - 1) * pInfo.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<TicketingVO> tingListP = session.selectList("TicketingMapper.ticketingListSelect", user, rowBounds); 
		return tingListP;
	}

}
