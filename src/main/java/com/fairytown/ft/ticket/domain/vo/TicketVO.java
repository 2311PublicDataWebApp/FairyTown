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
	// 임시 수정본
	private String ticketNo;
	private String ticketName;
	private String ticketDetail;
	private String ticketCard;
	private int ticketAdult;
	private int ticketTeen;
	private int ticketChild;
	private int ticketImgNo;
	private String ticketImgName;
	private String ticketImgRename;
	private String ticketImgFilePath;
	private int ticketImgFileLength;
	private Date ticketDate;
	private String ticketStatus;
	// 임시 수정본
}
