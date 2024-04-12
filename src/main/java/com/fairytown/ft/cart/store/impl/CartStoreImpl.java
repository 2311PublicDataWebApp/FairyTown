package com.fairytown.ft.cart.store.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.cart.store.CartStore;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.store.GoodsStore;

@Repository
public class CartStoreImpl implements CartStore{


	

	@Override
	public void insertCart(SqlSession session, CartVO cart) {
		session.insert("CartMapper.insertCart", cart);
		
	}

	@Override
	public List<CartVO> selectCartList(SqlSession session, String userId, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<CartVO> cList = session.selectList("CartMapper.selectCartList", null, rowBounds);
		return cList;
	}

	@Override
	public int selectTotalCount(SqlSession session, String userId) {
		int totalCount = session.selectOne("CartMapper.selectCartCount",userId);
		return totalCount;
	}

	@Override
	public List<CartVO> selectCartList(SqlSession session) {
		List<CartVO> cList = session.selectList("CartMapper.selectCartList");
		return cList;
	}

	@Override
	public int deleteCart(SqlSession session, String cartNum) {
		int result = session.delete("CartMapper.deleteCart", cartNum);
		return result;
	}

	@Override
	public CartVO selectOrderList(SqlSession session, String cartNum) {
		CartVO cartItem = session.selectOne("CartMapper.selectOrderList", cartNum);
		return cartItem;
	}



}
