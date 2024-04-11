package com.fairytown.ft.notice.domain.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeReplyVO {
	private int replyNo;
	private int refNoticeNo;
	private String replyContent;
	private String replyWriter;
	private Date rCreateDate;
	private Timestamp rUpdateDate;
	private String updateYn;
	private String rStatus;
	
}
