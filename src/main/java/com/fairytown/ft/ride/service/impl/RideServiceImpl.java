package com.fairytown.ft.ride.service.impl;

import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.ride.service.RideService;
import com.fairytown.ft.ride.store.RideStore;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RideServiceImpl implements RideService {

	@Autowired
	private RideStore rStore;
	
	@Override
	public int insertClose(RideVO close) {
		int result = rStore.insertClose(close);
		return result;
	}

	
	
	
	
}
