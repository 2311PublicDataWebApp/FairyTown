package com.fairytown.ft.ticket.domain.vo;

import java.sql.Date;

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
	private String  ticketNo;
	private String 	ticketName;
	private String 	ticketDetail;
	private String 	ticketCard;
	private int 	ticketAdult;
	private int 	ticketTeen;
	private int 	ticketChild;
	private int 	ticketImgNo;
	private String 	ticketImgName;
	private String 	ticketImgRename;
	private String 	ticketImgFilepath;
	private long 	ticketImgFilelength;
	private Date 	ticketDate;
	private String 	ticketStatus;
}