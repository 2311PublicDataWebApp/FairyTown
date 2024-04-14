package com.fairytown.ft.goods.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
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
	public void insertOrderDetail(OrderVO order) {
		oStore.insertOrderDetail(session, order);
	}

	@Override
	public OrderVO selectByOrderCode(String goodsOrderCode) {
		OrderVO order = oStore.selectByOrderCode(session, goodsOrderCode);
		return order;
	}
}
