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

	TicketVO selectByTicketNo(SqlSession session, int ticketNo);

	int selectTotalCount(SqlSession session, Map<String, String> paramMap);

	List<TicketVO> selectTicketList(SqlSession session, PageInfo pi);

	int selectTotalCount(SqlSession session);

	List<TicketVO> selectTicketByKeyword(RowBounds rowBounds, Map<String, String> paramMap);

	int insertTicket(TicketVO ticket);

	int modifyTicket(SqlSession session, TicketVO ticket);

	int deleteTicket(SqlSession session, int ticketNo);

	

}