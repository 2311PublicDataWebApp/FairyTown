package com.fairytown.ft.common;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor

public class PageInfo {
		private int currentPage;
		private int totalCount;
		private int naviTotalCount;
		private int boardLimit;
		private int naviLimit;
		private int startNavi;
		private int endNavi;
		private int recordCountPerPage;
		private int startRow;
		private int endRow;
		
		//검색 필터
		private String	keyword;
		private String	type;
		
		public PageInfo() {
		}

		public PageInfo(int currentPage, int totalCount, int boardLimit) {
			super();
			this.startRow = (currentPage - 1) * boardLimit + 1;
			this.endRow = currentPage * boardLimit;
			this.currentPage = currentPage;
			this.totalCount = totalCount;
			this.naviLimit = 5;
			this.boardLimit = boardLimit;
			this.naviTotalCount = (int) Math.ceil((double) totalCount / boardLimit);
			this.startNavi = ((int) ((double) currentPage / naviLimit + 0.9) - 1) * naviLimit + 1;
			this.endNavi = startNavi + naviLimit - 1;
			if (endNavi > naviTotalCount) {
				endNavi = naviTotalCount;
			}
		}
	
	
}
