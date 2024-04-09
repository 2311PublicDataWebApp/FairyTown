package com.fairytown.ft.ticket.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString 
@AllArgsConstructor
@NoArgsConstructor
public class TicketVO {

    private String ticketNumber;
    private String ticketName;
    private String ticketDetail;
    private String ticketImg;
    private int ticketPrice;
    private String ticketCard;
    private int ticketAdult;
    private int ticketTeen;
    private int ticketChild;

}
