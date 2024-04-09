package com.fairytown.ft.ticketing.domain.vo;

import lombok.*;

import java.sql.Date;

@Getter @Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class TicketingVO {
    private String ticketCode;
    private String ticketNumber;
    private String userId;
    private Date reservationDate;
    private Date purchaseDate;
    private int adult;
    private int teenager;
    private int child;
    private int purchasePrice;
    private String purchaseSuccess;
}
