package com.fairytown.ft.goods.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.domain.vo.OrderVO;

public interface OrderStore {

	void insertOrder(SqlSession session, OrderVO order);

	void insertOrderDetail(SqlSession session, OrderVO order);

	OrderVO selectByOrderCode(SqlSession session, String goodsOrderCode);

	
	
	
}
