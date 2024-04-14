package com.fairytown.ft.goods.service;

import java.util.List;
import java.util.Map;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.domain.vo.OrderVO;

public interface OrderService {

	void insertOrder(OrderVO order);

	void insertOrderDetail(OrderVO order);

	OrderVO selectByOrderCode(String goodsOrderCode);

}
