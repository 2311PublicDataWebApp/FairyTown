package com.fairytown.ft.notice.domain.vo;

import java.beans.ConstructorProperties;
import java.sql.Date;
import java.sql.Timestamp;

import io.micrometer.common.lang.Nullable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;

@Data
public class NoticeVO {
	
	private int noticeNo;
	private String userId;
	private String noticeSubject;
	private String noticeContent;
	private Date noticeDate;
	private Timestamp updateDate;
	private String noticeFileName; 
	private String noticeFileRename; 
	private String noticeFilePath; 
	private Long noticeFileLength;
	
	// 파라미터 이름을 명시적으로 지정 
//	@ConstructorProperties({"noticeNo", "userId", "noticeSubject", "noticeContent", "noticeDate", "updateDate", "noticeFileName", "noticeFileRename", "noticeFilePath", "noticeFileLength"})
//	public NoticeVO(int noticeNo, String userId, String noticeSubject, String noticeContent, Date noticeDate,
//			Timestamp updateDate, String noticeFileName, String noticeFileRename, String noticeFilePath,
//			Long noticeFileLength) {
//		super();
//		this.noticeNo = noticeNo;
//		this.userId = userId;
//		this.noticeSubject = noticeSubject;
//		this.noticeContent = noticeContent;
//		this.noticeDate = noticeDate;
//		this.updateDate = updateDate;
//		this.noticeFileName = noticeFileName;
//		this.noticeFileRename = noticeFileRename;
//		this.noticeFilePath = noticeFilePath;
//		this.noticeFileLength = noticeFileLength;
//	} 
}
