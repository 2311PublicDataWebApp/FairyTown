package com.fairytown.ft.ticket.service;

import java.util.List;
import java.util.Map;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ticket.domain.vo.TicketVO;

public interface TicketService {


	int getTotalCount();

	List<TicketVO> selectTicketList(PageInfo pi);

	int getTotalCount(Map<String, String> paramMap);

	List<TicketVO> selectTicketByKeyword(PageInfo pi, Map<String, String> paramMap);

	int insertTicket(TicketVO ticket);

	int modifyTicket(TicketVO ticket);

	int deleteTicket(int ticketNo);

	TicketVO selectByTicketNo(int ticketNo);

}