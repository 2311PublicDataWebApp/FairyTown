package com.fairytown.ft.ride.store;

import org.apache.ibatis.annotations.Mapper;

import com.fairytown.ft.ride.domain.vo.RideVO;

@Mapper
public interface RideStore {

	int insertClose(RideVO close);

}
