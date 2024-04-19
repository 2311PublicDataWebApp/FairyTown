package com.fairytown.ft.goods.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.CartVO;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.service.CartService;
import com.fairytown.ft.goods.store.CartStore;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartStore cStore;
	@Autowired
	private SqlSession session;
	
	@Override
	public int addCart(CartVO cart) {
		int result = cStore.insertCart(session, cart);
		return result;
	}

	@Override
	public List<CartVO> selectCartList(String userId) {
		List<CartVO> cList = cStore.selectCartList(session, userId);
		return cList;
	}

	@Override
	public int getTotalCount(String userId) {
		int totalCount = cStore.selectTotalCount(session, userId);
		return totalCount;
	}

	@Override
	public int deleteCart(String cartNum) {
		int result = cStore.deleteCart(session, cartNum);
		return result;
	}

	@Override
	public CartVO selectOrderList(String cartNum) {
		CartVO cartItem = cStore.selectOrderList(session, cartNum);
		return cartItem;
	}

	@Override
	public CartVO findByUserIdAndGoodsCode(CartVO cart) {
		CartVO cartItem = cStore.findByUserIdAndGoodsCode(session, cart);
		return cartItem;
	}

	@Override
	public int addCnt(CartVO cart) {
		int result = cStore.addCnt(session, cart);
		return result;
	}

	@Override
	public int changeCnt(CartVO cart) {
		int result = cStore.changeCnt(session, cart);
		return result;
	}


}
