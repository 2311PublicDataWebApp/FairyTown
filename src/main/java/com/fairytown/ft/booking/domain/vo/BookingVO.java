package com.fairytown.ft.booking.domain.vo;

import java.sql.Date;

import com.fairytown.ft.ride.domain.vo.RideVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BookingVO {
    private int bookingNumber;
    private String userId;
    private String ticketCode;
    private int rideId;
    private Date bookingDate;
    private Date bookingTime;
    private int bookingPeople;
    
    private RideVO ride;
}
