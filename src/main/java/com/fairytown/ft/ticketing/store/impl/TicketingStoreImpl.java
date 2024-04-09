package com.fairytown.ft.ticketing.store.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fairytown.ft.ticketing.store.TicketingStore;

@Repository
public class TicketingStoreImpl implements TicketingStore{

	// 입력 값으로 티켓 값 계산
	@Override
	public TicketingVO ticktingSelect(SqlSession session, TicketingVO tingOne) {
		// 2. 어른, 청소년, 어린이 가격을 계산하여
		// 3. 티켓팅 테이블 형식으로 값을 가져와..
		
		TicketingVO ticketing = session.selectOne("", tingOne);
		tingOne.setPurchasePrice(1000);
//		return ticketing;
		return tingOne;
		// 임시로 값 보내기
	}

}
