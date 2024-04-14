package com.fairytown.ft.goods.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.CartVO;
import com.fairytown.ft.goods.domain.vo.GoodsVO;

public interface CartStore {

	int insertCart(SqlSession session, CartVO cart);

	List<CartVO> selectCartList(SqlSession session, String userId);

	int selectTotalCount(SqlSession session, String userId);

	int deleteCart(SqlSession session, String cartNum);

	CartVO selectOrderList(SqlSession session, String cartNum);

	CartVO findByUserIdAndGoodsCode(SqlSession session, CartVO cart);

	int addCnt(SqlSession session, CartVO cart);

	int MinusCnt(SqlSession session, CartVO cart);

	
	
}
