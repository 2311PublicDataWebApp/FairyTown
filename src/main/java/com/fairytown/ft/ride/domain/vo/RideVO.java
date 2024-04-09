package com.fairytown.ft.ride.domain.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString 
@AllArgsConstructor
public class RideVO {
	private int rideId;
	private String rideName;
	private String rideDescription;
	private int rideCount;
	private String rideClose;
	private int rideX;
	private int rideY;
	private Date rideDate;
	private String rideLimit;
	private int rideImgNo;
	private String rideImgName;
	private String rideImgRename;
	private String rideImgFilePath;
	private int rideImgFilelength;
	private String rideImgThumbnail;
	
}
