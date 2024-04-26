package com.fairytown.ft.goods.store;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.OrderVO;

public interface OrderStore {

	void insertOrder(SqlSession session, OrderVO order);

	void insertOrderDetail(SqlSession session, OrderVO orderDetail);

	void orderReset(SqlSession session, OrderVO orderDetail);

	void minusStock(SqlSession session, OrderVO orderDetail);
	
	List<OrderVO> selectByOrderCode(SqlSession session, String goodsOrderCode);

	int selectOrderCount(SqlSession session, String userId);

	List<OrderVO> selectOrderList(SqlSession session, PageInfo pi, String userId);

	void deleteOrder(SqlSession session, OrderVO order);

	void deleteOrderDetail(SqlSession session, OrderVO order);

	void plusStock(SqlSession session, OrderVO order);

	List<OrderVO> selectAdminOrderList(SqlSession session);
	// 대쉬보드
	List<Map<String,Object>> adminOrderBoard(SqlSession session, Date today);


	
	
	
}
