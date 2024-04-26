package com.fairytown.ft.goods.store.impl;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.time.DateUtils;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.OrderVO;
import com.fairytown.ft.goods.store.OrderStore;

@Repository
public class OrderStoreImpl implements OrderStore{

	@Override
	public void insertOrder(SqlSession session, OrderVO order) {
		session.insert("OrderMapper.insertOrder", order);
	}

	@Override
	public void insertOrderDetail(SqlSession session, OrderVO orderDetail) {
		session.insert("OrderMapper.insertOrderDetail", orderDetail);
	}

	@Override
	public void orderReset(SqlSession session, OrderVO orderDetail) {
		session.delete("OrderMapper.orderReset", orderDetail);
	}

	@Override
	public void minusStock(SqlSession session, OrderVO orderDetail) {
		session.update("OrderMapper.minusStock", orderDetail);
	}

	@Override
	public List<OrderVO> selectByOrderCode(SqlSession session, String goodsOrderCode) {
		List<OrderVO> oList = session.selectList("OrderMapper.selectByOrderCode", goodsOrderCode);
		return oList;
	}

	@Override
	public int selectOrderCount(SqlSession session, String userId) {
		int totalCount = session.selectOne("OrderMapper.selectOrderCount",userId);
		return totalCount;
	}

	@Override
	public List<OrderVO> selectOrderList(SqlSession session, PageInfo pi, String userId) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<OrderVO> oList = session.selectList("OrderMapper.selectOrderList", userId, rowBounds);
		return oList;
	}

	@Override
	public void deleteOrder(SqlSession session, OrderVO order) {
		session.delete("OrderMapper.deleteOrder", order);
	}

	@Override
	public void deleteOrderDetail(SqlSession session, OrderVO order) {
		session.delete("OrderMapper.deleteOrderDetail", order);
	}

	@Override
	public void plusStock(SqlSession session, OrderVO order) {
		session.update("OrderMapper.plusStock", order);
	}

	@Override
	public List<OrderVO> selectAdminOrderList(SqlSession session) {
		List<OrderVO> oList = session.selectList("OrderMapper.selectAdminOrderList");
		return oList;
	}

	@Override
	public List<Map<String,Object>> adminOrderBoard(SqlSession session, Date today) {
	    Map<String, Object> param = new HashMap<>();
	    param.put("today", today);
	    java.util.Date startDateUtil = DateUtils.addDays(today, -6);
	    java.sql.Date startDate = new java.sql.Date(startDateUtil.getTime());
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    String formattedStartDate = dateFormat.format(startDate);
	    param.put("startDate", formattedStartDate);
	    List<Map<String, Object>> dateSumMap = session.selectList("OrderMapper.adminOrderBoard", param);
		return dateSumMap;
	}


}
