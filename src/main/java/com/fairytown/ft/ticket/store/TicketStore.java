package com.fairytown.ft.ticket.store;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ticket.domain.vo.TicketVO;

@Mapper
public interface TicketStore {


	int selectTotalCount(Map<String, String> paramMap);

	List<TicketVO> selectTicketList(PageInfo pi);

	int selectTotalCount();

	List<TicketVO> searchTicketByKeyword(RowBounds rowBounds, Map<String, String> paramMap);

	int insertTicket(TicketVO ticket);

	int modifyTicket(TicketVO ticket);

	int deleteTicket(int ticketNo);

	TicketVO selectByTicketNo(int ticketNo);


	

}