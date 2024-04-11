package com.fairytown.ft.notice.domain.vo;

import lombok.Data;

@Data
public class NoticePageInfo {

    private int currentPage;
    private int totalCount;
    private int naviTotalCount;
    private int boardLimit;
    private int naviLimit;
    private int startNavi;
    private int endNavi;

    public NoticePageInfo() {
    }

    public NoticePageInfo(int currentPage, int totalCount, int naviTotalCount, int boardLimit, int naviLimit, int startNavi, int endNavi) {
    	this.currentPage = currentPage;
		this.totalCount = totalCount;
		this.naviTotalCount = naviTotalCount;
		this.boardLimit = boardLimit;
		this.naviLimit = naviLimit;
		this.startNavi = startNavi;
		this.endNavi = endNavi;
    }
}