package com.fairytown.ft.review.domain.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewVO {
	private int reviewNo;
    private String userId;
    private String realName;
    private String ticketType;
    private String reviewTitle;
    private String reviewContent;
    private Date reviewDate;
    private Timestamp updateDate;
    private int likeCount;
    private int viewCount;
    private ReviewLikedVO reviewLiked; // ReviewLikedVO 객체를 포함
}
