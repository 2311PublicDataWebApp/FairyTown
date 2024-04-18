package com.fairytown.ft.review.domain.vo;

import lombok.Data;

@Data
public class ReviewLikedVO {
	private String userId;
    private int reviewNo;
    private int liked; // 0 또는 1로 좋아요 여부를 표시
}

