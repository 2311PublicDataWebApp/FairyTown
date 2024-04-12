package com.fairytown.ft.cart.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.cart.service.CartService;
import com.fairytown.ft.cart.store.CartStore;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartStore cStore;
	@Autowired
	private SqlSession session;
	
	@Override
	public void addCart(CartVO cart) {
		cStore.insertCart(session, cart);
	}

	@Override
	public List<CartVO> selectCartList(String userId, PageInfo pi) {
		List<CartVO> cList = cStore.selectCartList(session, userId, pi);
		return cList;
	}

	@Override
	public int getTotalCount(String userId) {
		int totalCount = cStore.selectTotalCount(session, userId);
		return totalCount;
	}

	@Override
	public List<CartVO> selectCartList() {
		List<CartVO> cList = cStore.selectCartList(session);
		return cList;
	}

	@Override
	public int deleteCart(String cartNum) {
		int result = cStore.deleteCart(session, cartNum);
		return result;
	}

	@Override
	public CartVO selectCartList(String cartNum) {
		CartVO cartItem = cStore.selectOrderList(session, cartNum);
		return cartItem;
	}

}
