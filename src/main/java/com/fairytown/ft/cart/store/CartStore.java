package com.fairytown.ft.cart.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;

public interface CartStore {

	void insertCart(SqlSession session, CartVO cart);

	List<CartVO> selectCartList(SqlSession session, String userId, PageInfo pi);

	int selectTotalCount(SqlSession session, String userId);

	List<CartVO> selectCartList(SqlSession session);

	int deleteCart(SqlSession session, String cartNum);

	CartVO selectOrderList(SqlSession session, String cartNum);
	
	
}
