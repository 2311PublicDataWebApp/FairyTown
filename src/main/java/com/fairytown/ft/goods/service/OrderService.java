package com.fairytown.ft.goods.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.OrderVO;

public interface OrderService {

	void insertOrder(OrderVO order);

	void insertOrderDetail(OrderVO orderDetail);

	void orderReset(OrderVO orderDetail);

	void minusStock(OrderVO orderDetail);

	List<OrderVO> selectByOrderCode(String goodsOrderCode);

	int getTotalCount(String userId);

	List<OrderVO> selectOrderList(PageInfo pi, String userId);

	void deleteOrder(OrderVO order);

	void deleteOrderDetail(OrderVO order);

	void plusStock(OrderVO order);

	List<OrderVO> selectOrderList();
	// 대쉬보드
	List<Map<String,Object>> adminOrderBoard(Date today);

}
