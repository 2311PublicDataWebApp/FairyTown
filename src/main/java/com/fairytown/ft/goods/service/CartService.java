package com.fairytown.ft.goods.service;

import java.util.List;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.CartVO;

public interface CartService {

	int addCart(CartVO cart);

	List<CartVO> selectCartList(String userId);

	int getTotalCount(String userId);
	
	int deleteCart(String cartNum);

	CartVO selectOrderList(String cartNum);

	CartVO findByUserIdAndGoodsCode(CartVO cart);

	int addCnt(CartVO cart);

	int changeCnt(CartVO cart);

}
