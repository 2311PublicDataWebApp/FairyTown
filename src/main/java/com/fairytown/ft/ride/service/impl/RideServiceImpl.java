package com.fairytown.ft.ride.service.impl;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.ride.domain.vo.RimgVO;
import com.fairytown.ft.ride.service.RideService;
import com.fairytown.ft.ride.store.RideStore;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RideServiceImpl implements RideService {

	@Autowired
	private RideStore rStore;

	

	// --------------------------------------- 놀이기구 관련
	// -----------------------어드민
	
	//등록
	@Override
	public int insertRide(RideVO ride, RimgVO rImg) {
		int result = rStore.insertRide(ride);
		result += rStore.insertRideImg(rImg);
		return result;
	}
	
	
	//수정
	@Override
	public int modifyRide(RideVO ride) {
		int result = rStore.modifyRide(ride);
		return result;
	}
	
	@Override
	public int modifyRideImg(RimgVO rImg) {
		int result = rStore.modifyRideImg(rImg);
		return result;
	}
	
	//삭제
	@Override
	public int deleteRide(int rideId) {
		int result = rStore.deleteRide(rideId);
		return result;
	}

	//목록
	@Override
	public List<RideVO> selectRideList(PageInfo pi) {
		List<RideVO> rList = rStore.selectRideList(pi);
		return rList;
	}
	//상세
	@Override
	public RideVO selectByRideId(int rideId) {
		RideVO ride = rStore.selectByRideId(rideId);
		return ride;
	}
	
	// 검색
	@Override
	public List<RideVO> selectrideByKeyword(PageInfo pi, Map<String, String> paramMap) {
		int limit = pi.getBoardLimit();
		int offset =(pi.getCurrentPage()-1)*limit;
		RowBounds rb = new RowBounds(offset, limit);
		List<RideVO> sList = rStore.searchrideByKeyword(rb, paramMap);
		return sList;
	}

	// 전체개수
	@Override
	public int getTotalCount() {
		int totalCount = rStore.selectTotalCount();
		return totalCount;
	}
	
	@Override
	public int getTotalCount(Map<String, String> paramMap) {
		int totalCount = rStore.selectTotalCount(paramMap);
		return totalCount;
	}

	
	// --------------------------------------- 운휴 관련
	// 운휴 등록
		@Override
		public int insertClose(RideVO close) {
		int result = rStore.insertClose(close);
		return result;
	}

		
		@Override
		public int modifyclose(RideVO close) {
			int result = rStore.modifyclose(close);
			return result;
		}


		@Override
		public int deleteclose(int closeNo) {
			int result = rStore.deleteclose(closeNo);
			return result;
		}
		

		@Override
		public RideVO selectByCloseNo(int closeNo) {
			RideVO ride = rStore.selectByCloseNo(closeNo);
			return ride;
		}


		@Override
		public List<RideVO> selectCloseList(PageInfo pi) {
			List<RideVO> rList = rStore.selectCloseList(pi);
			return rList;
		}


		@Override
		public List<RideVO> selectcloseByKeyword(PageInfo pi, Map<String, String> paramMap) {
			int limit = pi.getBoardLimit();
			int offset =(pi.getCurrentPage()-1)*limit;
			RowBounds rb = new RowBounds(offset, limit);
			List<RideVO> sList = rStore.searchcloseByKeyword(rb, paramMap);
			return sList;
		}


		


	
	
	
}
