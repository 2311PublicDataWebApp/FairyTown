package com.fairytown.ft.goods.store.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.domain.vo.OrderVO;
import com.fairytown.ft.goods.store.OrderStore;

@Repository
public class OrderStoreImpl implements OrderStore{

	@Override
	public void insertOrder(SqlSession session, OrderVO order) {
		session.insert("OrderMapper.insertOrder", order);
	}

	@Override
	public void insertOrderDetail(SqlSession session, OrderVO order) {
		session.insert("OrderMapper.insertOrderDetail", order);
	}

	@Override
	public OrderVO selectByOrderCode(SqlSession session, String goodsOrderCode) {
		OrderVO order = session.selectOne("OrderMapper.selectByOrderCode", goodsOrderCode);
		return order;
	}


}
