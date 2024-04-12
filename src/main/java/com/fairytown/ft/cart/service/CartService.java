package com.fairytown.ft.cart.service;

import java.util.List;

import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.cart.domain.vo.CartVO;
import com.fairytown.ft.common.PageInfo;

public interface CartService {

	void addCart(CartVO cart);

	List<CartVO> selectCartList(String userId, PageInfo pi);

	int getTotalCount(String userId);

	List<CartVO> selectCartList();

	int deleteCart(String cartNum);

	CartVO selectCartList(String cartNum);


}
