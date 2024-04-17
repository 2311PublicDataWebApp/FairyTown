package com.fairytown.ft.ride.service;

import java.util.List;
import java.util.Map;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.ride.domain.vo.RimgVO;

public interface RideService {

	int insertRide(RideVO ride, RimgVO rImg);

	int deleteRide(int rideId);

	int getTotalCount(Map<String, String> paramMap);

	List<RideVO> searchRideByKeyword(PageInfo pi, Map<String, String> paramMap);

	List<RideVO> selectRideList(PageInfo pi);

	int getTotalCount();

	RideVO selectByRideId(int rideId);

	int modifyRide(RideVO ride);
	int modifyRideImg(RimgVO rImg);

	
	
	
	
	//운휴 관련
	int insertClose(RideVO close);

	RideVO selectByCloseNo(int closeNo);

	List<RideVO> selectCloseList();

	List<RideVO> selectcloseByKeyword(PageInfo pi, Map<String, String> paramMap);

	int modifyclose(RideVO close);

	int deleteclose(int closeNo);

	List<RimgVO> selectRideImgList(int rideId);




}
