package com.fairytown.ft.ride.domain.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString 
@AllArgsConstructor
@RequiredArgsConstructor
public class RideVO {
	private Integer rideId;
	private String rideName;
	private String rideDescription;
	private int rideCount;
	private String rideStatus;
	private Date rideDate;
	private String rideLimit;
	private String rideX;
	private String rideY;
	private Date closeDate;
	private String closeReason;
	private int closeNo;
}
