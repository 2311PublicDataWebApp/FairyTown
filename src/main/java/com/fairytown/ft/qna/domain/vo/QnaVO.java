package com.fairytown.ft.qna.domain.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString 
@AllArgsConstructor
public class QnaVO {
	
	private int qaNo;
	private String qaName;
	private String qaContent;
	private String qaWriter;
	private String status;
	private Date qaDate;
	
	
}
