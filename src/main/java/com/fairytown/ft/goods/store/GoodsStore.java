package com.fairytown.ft.goods.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;

public interface GoodsStore {

	int insertGoods(SqlSession session, GoodsVO goods);

	List<GoodsVO> selectGoodsList(SqlSession session, PageInfo pi);

	int selectTotalCount(SqlSession session);

	int selectTotalCount(SqlSession session, Map<String, String> paramMap);

	List<GoodsVO> selectGoodsByKeyword(SqlSession session, RowBounds rowBounds, Map<String, String> paramMap);

	GoodsVO selectByGoodsCode(SqlSession session, Integer goodsCode);

	int updateGoods(SqlSession session, GoodsVO goods);

	int deleteGoods(SqlSession session, Integer goodsCode);

	List<GoodsVO> selectGoodsList(SqlSession session, PageInfo pi, String sortType);

	List<GoodsVO> sortSelectGoodsByKeyword(SqlSession session, RowBounds rowBounds, Map<String, String> paramMap);

	
	
	
}
