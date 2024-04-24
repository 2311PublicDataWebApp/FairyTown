package com.fairytown.ft.ride.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@RequiredArgsConstructor
public class RimgVO {
	private int rideImgNo;
	private int rideId;
	private String rideImgName;
	private String rideImgRename;
	private String rideImgFilepath;
	private long rideImgFilelength;
	private String displayYn;
	private int displaySeq;
	private String thumbList;
	private String thumbBest;


	
}
