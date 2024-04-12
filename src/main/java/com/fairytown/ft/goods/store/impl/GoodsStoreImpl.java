package com.fairytown.ft.goods.store.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.store.GoodsStore;

@Repository
public class GoodsStoreImpl implements GoodsStore{

	@Override
	public int insertGoods(SqlSession session, GoodsVO goods) {
		int result = session.insert("GoodsMapper.insertGoods", goods);
		return result;
	}

	@Override
	public List<GoodsVO> selectGoodsList(SqlSession session, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<GoodsVO> gList = session.selectList("GoodsMapper.selectGoodsList", null, rowBounds);
		return gList;
	}

	@Override
	public int selectTotalCount(SqlSession session) {
		int totalCount = session.selectOne("GoodsMapper.selectTotalCount");
		return totalCount;
	}

	@Override
	public int selectTotalCount(SqlSession session, Map<String, String> paramMap) {
		int totalCount = session.selectOne("GoodsMapper.searchTotalCount", paramMap);
		return totalCount;
	}

	@Override
	public List<GoodsVO> selectGoodsByKeyword(SqlSession session, RowBounds rowBounds, Map<String, String> paramMap) {
		List<GoodsVO> sList = session.selectList("GoodsMapper.selectGoodsByKeyword", paramMap, rowBounds);
		return sList;
	}

	@Override
	public GoodsVO selectByGoodsCode(SqlSession session, Integer goodsCode) {
		GoodsVO notice = session.selectOne("GoodsMapper.selectByGoodsCode", goodsCode);
		return notice;
	}

	@Override
	public int updateGoods(SqlSession session, GoodsVO goods) {
		int result = session.update("GoodsMapper.updateGoods", goods);
		return result;
	}

	@Override
	public int deleteGoods(SqlSession session, Integer goodsCode) {
		int result = session.update("GoodsMapper.deleteGoods", goodsCode);
		return result;
	}


}
