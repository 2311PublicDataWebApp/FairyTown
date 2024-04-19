package com.fairytown.ft.review.domain.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

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
    private List<ReviewImageVO> images; // 이미지 정보를 담을 리스트 필드
}
