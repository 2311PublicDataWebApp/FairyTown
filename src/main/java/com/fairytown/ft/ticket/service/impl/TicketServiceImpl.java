package com.fairytown.ft.ticket.service.impl;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ticket.domain.vo.TicketVO;
import com.fairytown.ft.ticket.service.TicketService;
import com.fairytown.ft.ticket.store.TicketStore;

import lombok.AllArgsConstructor;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class TicketServiceImpl implements TicketService {

	@Autowired
	private TicketStore tStore;
	private SqlSession session;
	
	@Override
	public int insertTicket(TicketVO ticket) {
		int result = tStore.insertTicket(ticket);
		return result;
	}

	@Override
	public TicketVO selectByTicketNo(int ticketNo) {
		TicketVO ticket = tStore.selectByTicketNo(session, ticketNo);
		return ticket;
	}

	@Override
	public int getTotalCount() {
		int totalCount = tStore.selectTotalCount(session);
		return totalCount;
	}

	@Override
	public List<TicketVO> selectTicketList(PageInfo pi) {
		List<TicketVO> tList = tStore.selectTicketList(session, pi);
		return tList;
	}

	@Override
	public int getTotalCount(Map<String, String> paramMap) {
		int totalCount = tStore.selectTotalCount(session, paramMap);
		return totalCount;
	}

	@Override
	public List<TicketVO> selectTicketByKeyword(PageInfo pi, Map<String, String> paramMap) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<TicketVO> sList = tStore.selectTicketByKeyword(rowBounds, paramMap);
		return sList;
	}

	@Override
	public int modifyTicket(TicketVO ticket) {
		int result = tStore.modifyTicket(session, ticket);
		return result;
	}

	@Override
	public int deleteTicket(int ticketNo) {
		int result = tStore.deleteTicket(session, ticketNo);
		return result;
	}

}
