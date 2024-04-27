package com.fairytown.ft.goods.service.impl;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.OrderVO;
import com.fairytown.ft.goods.service.OrderService;
import com.fairytown.ft.goods.store.OrderStore;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderStore oStore;
	@Autowired
	private SqlSession session;

	@Override
	public void insertOrder(OrderVO order) {
		oStore.insertOrder(session, order);
	}

	@Override
	public void insertOrderDetail(OrderVO orderDetail) {
		oStore.insertOrderDetail(session, orderDetail);
	}

	@Override
	public List<OrderVO> selectByOrderCode(String goodsOrderCode) {
		List<OrderVO> oList = oStore.selectByOrderCode(session, goodsOrderCode);
		return oList;
	}

	@Override
	public void orderReset(OrderVO orderDetail) {
		oStore.orderReset(session, orderDetail);
	}

	@Override
	public void minusStock(OrderVO orderDetail) {
		oStore.minusStock(session, orderDetail);
	}

	@Override
	public int getTotalCount(String userId) {
		int totalCount = oStore.selectOrderCount(session, userId);
		return totalCount;
	}

	@Override
	public List<OrderVO> selectOrderList(PageInfo pi, String userId) {
		List<OrderVO> oList = oStore.selectOrderList(session, pi, userId);
		return oList;
	}

	@Override
	public void deleteOrder(OrderVO order) {
		oStore.deleteOrder(session, order);
	}

	@Override
	public void deleteOrderDetail(OrderVO order) {
		oStore.deleteOrderDetail(session, order);
	}

	@Override
	public void plusStock(OrderVO order) {
		oStore.plusStock(session, order);
	}

	@Override
	public List<OrderVO> selectOrderList() {
		List<OrderVO> oList = oStore.selectAdminOrderList(session);
		return oList;
	}
	// 대쉬보드
	@Override
	public List<Map<String,Object>> adminOrderBoard(Date today) {
		List<Map<String,Object>> listGoodsOrder = oStore.adminOrderBoard(session, today);
		return listGoodsOrder;
	}
}
