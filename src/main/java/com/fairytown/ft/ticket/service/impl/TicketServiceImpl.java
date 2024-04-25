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
public class TicketServiceImpl implements TicketService {

	@Autowired
	private TicketStore tStore;
	
	@Override
	public int insertTicket(TicketVO ticket) {
		int result = tStore.insertTicket(ticket);
		return result;
	}
	
	@Override
	public int modifyTicket(TicketVO ticket) {
		int result = tStore.modifyTicket(ticket);
		return result;
	}

	@Override
	public int deleteTicket(int ticketNo) {
		int result = tStore.deleteTicket(ticketNo);
		return result;
	}

	@Override
	public List<TicketVO> selectTicketList(PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<TicketVO> tList = tStore.selectTicketList(rowBounds, pi);
		return tList;
	}

	@Override
	public TicketVO selectByTicketNo(int ticketNo) {
		TicketVO ticket = tStore.selectByTicketNo(ticketNo);
		return ticket;
	}
	
	@Override
	public List<TicketVO> selectTicketByKeyword(PageInfo pi, Map<String, String> paramMap) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<TicketVO> sList = tStore.searchTicketByKeyword(rowBounds, paramMap);
		return sList;
	}
	
	@Override
	public int getTotalCount() {
		int totalCount = tStore.selectTotalCount();
		return totalCount;
	}
	@Override
	public int getTotalCount(Map<String, String> paramMap) {
		int totalCount = tStore.searchTotalCount(paramMap);
		return totalCount;
	}
	


	
}
