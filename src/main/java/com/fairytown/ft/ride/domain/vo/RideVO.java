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
	// 임시 수정본
	private int rideId;
    private String rideName;
    private String rideDescription;
    private int rideCount;
    private String rideStatus;
    private Date rideDate;
    private String rideLimit;
    private String rideX;
    private String rideY;
    private String rideImgNo;
    private Date closeDate;
    private String closeReason;
    private int closeNo;
	// 임시 수정본
}
