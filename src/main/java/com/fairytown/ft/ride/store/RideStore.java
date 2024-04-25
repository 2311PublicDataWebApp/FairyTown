package com.fairytown.ft.ride.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.ride.domain.vo.RimgVO;

@Mapper
public interface RideStore {

	//놀이기구 어드민
	int insertRide(RideVO ride);
	int insertRideImg(RimgVO rImg);

	int modifyRide(RideVO ride);
	int modifyRideImg(RimgVO rImg);

	int deleteRide(int rideId);

	List<RideVO> selectRideList(RowBounds rb);
	List<RimgVO> selectRideImgList(int rideId);
	
	RideVO selectByRideId(int rideId);
	List<RimgVO> selectImgByRideId(int rideId);
	
	List<RideVO> selectUserRideList(RowBounds rb);
	
	List<RideVO> searchRideByKeyword(RowBounds rb, Map<String, String> paramMap);

	int selectTotalCount();
	
	int searchTotalCount(Map<String, String> paramMap);

	// 운휴 관련
	int insertClose(RideVO close);
	List<RideVO> searchcloseByKeyword(RowBounds rb, Map<String, String> paramMap);
	RideVO selectByCloseNo(int rideId);
	int deleteclose(int rideId);
	int modifyclose(RideVO close);
	List<RideVO> selectRideNameForClose();
	List<RideVO> selectCloseList(RowBounds rb);
	int selectCloseTotalCount();
	int rideId(RideVO rideId);
	List<RimgVO> selectUserRideImg();
	
	List<RimgVO> selectUserImgByRideId(int rideId);
	RideVO selectUserRideByRideId(int rideId);
	int modifyRideImg(List<RimgVO> rImg);
	int addCourse(RideVO ride);
	int deleteCourse(RideVO ride);
	List<RideVO> selectCourse(RideVO ride);
	List<RideVO> selectCourseList(RideVO ride);

}
