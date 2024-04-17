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


	int searchTotalCount(Map<String, String> paramMap);

	int selectTotalCount();

	int insertTicket(TicketVO ticket);

	int modifyTicket(TicketVO ticket);

	int deleteTicket(int ticketNo);

	TicketVO selectByTicketNo(int ticketNo);

	List<TicketVO> selectTicketList(RowBounds rowBounds, PageInfo pi);

	List<TicketVO> searchTicketByKeyword(RowBounds rowBounds, Map<String, String> paramMap);



	

}