package com.fairytown.ft.review.domain.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReviewImageVO {
	private int imageNo;
	private int reviewNo;
	private String fileName;
	private String fileRename;
	private String filePath;
	private long fileSize;
	private String fileType;
	private Timestamp uploadDate;
	private String thumbnailPath;
	
}
