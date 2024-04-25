package com.fairytown.ft.ticketing.domain.vo;

import java.sql.Date;

import com.fairytown.ft.ticket.domain.vo.TicketVO;

import lombok.*;



@Getter @Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class TicketingVO {
    private String ticketingCode;
    private String ticketNumber;
    private String userId;
    private Date reservationDate;
    private Date purchaseDate;
    private int adult;
    private int teenager;
    private int child;
    private int purchasePrice;
    private String purchaseSuccess;
    private String impUid;
    private String merchantUid;
    
    private TicketVO ticket;
}