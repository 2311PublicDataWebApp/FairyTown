package com.fairytown.ft.user.domain.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BlackListVO {
	private int			blackListNo;
	private String		userId;
	private String		reason;
	private Timestamp	regiDate;
	private Timestamp	stopDate;
	
}
