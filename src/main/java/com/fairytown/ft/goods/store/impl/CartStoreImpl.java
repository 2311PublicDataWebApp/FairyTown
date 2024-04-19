package com.fairytown.ft.goods.store.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.CartVO;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.store.CartStore;
import com.fairytown.ft.goods.store.GoodsStore;

@Repository
public class CartStoreImpl implements CartStore{


	

	@Override
	public int insertCart(SqlSession session, CartVO cart) {
		int result = session.insert("CartMapper.insertCart", cart);
		return result;
	}

	@Override
	public List<CartVO> selectCartList(SqlSession session, String userId) {
		List<CartVO> cList = session.selectList("CartMapper.selectCartList", userId);
		return cList;
	}

	@Override
	public int selectTotalCount(SqlSession session, String userId) {
		int totalCount = session.selectOne("CartMapper.selectCartCount",userId);
		return totalCount;
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

	@Override
	public CartVO findByUserIdAndGoodsCode(SqlSession session, CartVO cart) {
		CartVO cartItem = session.selectOne("CartMapper.findByUserIdAndGoodsCode", cart);
		return cartItem;
	}

	@Override
	public int addCnt(SqlSession session, CartVO cart) {
		int result = session.update("CartMapper.addCnt", cart);
		return result;
	}


	@Override
	public int changeCnt(SqlSession session, CartVO cart) {
		int result = session.update("CartMapper.changeCnt", cart);
		return result;
	}





}
