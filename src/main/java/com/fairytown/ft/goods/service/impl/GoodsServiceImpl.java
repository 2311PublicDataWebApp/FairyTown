package com.fairytown.ft.goods.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.service.GoodsService;
import com.fairytown.ft.goods.store.GoodsStore;

@Service
public class GoodsServiceImpl implements GoodsService {
	
	@Autowired
	private GoodsStore gStore;
	@Autowired
	private SqlSession session;
	
	@Override
	public int insertGoods(GoodsVO goods) {
		int result = gStore.insertGoods(session, goods);
		return result;
	}

	@Override
	public List<GoodsVO> selectGoodsList(PageInfo pi) {
		List<GoodsVO> gList = gStore.selectGoodsList(session, pi);
		return gList;
	}
	
	@Override
	public int getTotalCount() {
		int totalCount = gStore.selectTotalCount(session);
		return totalCount;
	}

	@Override
	public int getTotalCount(Map<String, String> paramMap) {
		int totalCount = gStore.selectTotalCount(session, paramMap);
		return totalCount;
	}

	@Override
	public List<GoodsVO> searchGoodsByKeyword(PageInfo pi, Map<String, String> paramMap) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<GoodsVO> searchList = gStore.selectGoodsByKeyword(session, rowBounds, paramMap);
		return searchList;
	}

	@Override
	public GoodsVO selectByGoodsCode(Integer goodsCode) {
		GoodsVO goods = gStore.selectByGoodsCode(session, goodsCode);
		return goods;
	}

	@Override
	public int updateGoods(GoodsVO goods) {
		int result = gStore.updateGoods(session, goods);
		return result;
	}
	
	@Override
	public int deleteGoods(Integer goodsCode) {
		int result = gStore.deleteGoods(session, goodsCode);
		return result;
	}

	@Override
	public List<GoodsVO> selectGoodsList(PageInfo pi, String sortType) {
		List<GoodsVO> sortList = gStore.selectGoodsList(session, pi, sortType);
		return sortList;
	}

	@Override
	public List<GoodsVO> sortSearchGoodsByKeyword(PageInfo pi, Map<String, String> paramMap) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<GoodsVO> searchList = gStore.sortSelectGoodsByKeyword(session, rowBounds, paramMap);
		return searchList;
	}
}
