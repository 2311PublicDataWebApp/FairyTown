package com.fairytown.ft.goods.service;

import java.util.List;
import java.util.Map;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;

public interface GoodsService {

	int insertGoods(GoodsVO goods);

	int getTotalCount();

	List<GoodsVO> selectGoodsList(PageInfo pi);

	int getTotalCount(Map<String, String> paramMap);

	List<GoodsVO> searchGoodsByKeyword(PageInfo pi, Map<String, String> paramMap);

	GoodsVO selectByGoodsCode(Integer goodsCode);

	int updateGoods(GoodsVO goods);

	int deleteGoods(Integer goodsCode);

	List<GoodsVO> selectGoodsList(PageInfo pi, String sortType);

	List<GoodsVO> sortSearchGoodsByKeyword(PageInfo pi, Map<String, String> paramMap);

	List<GoodsVO> selectGoodsList();

}
