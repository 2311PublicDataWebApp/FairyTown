package com.fairytown.ft.blacklist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.blacklist.domain.vo.BlacklistVO;
import com.fairytown.ft.blacklist.service.BlacklistService;
import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;

@Controller
public class BlacklistController {
	
	private BlacklistService bService;
	

	// ===================
	// 리스트
	// ===================
	@GetMapping("/blacklist.ft")
    public ModelAndView ShowBlacklist(ModelAndView mv,
            @RequestParam(value="page", 
            required=false, defaultValue="1") Integer currentPage) {
		try {
			int totalCount = bService.getTotalCount();
			NoticePageInfo pi = this.getPageInfo(currentPage, totalCount);
			List<BlacklistVO> bList = bService.selectBlacklist(pi);
			mv.addObject("bList", bList);
			mv.addObject("pi", pi);
			mv.setViewName("blacklist/blacklist");
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
    
    // ===================
 	// 조회
 	// ===================
// 	@GetMapping(value="/blacklist/search.ft")
// 	public ModelAndView searchBlacklist(ModelAndView mv
// 			, @RequestParam("searchCondition") String searchCondition
// 			, @RequestParam("searchKeyword") String searchKeyword
// 			, @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
// 		
// 		Map<String, String> paramMap = new HashMap<String, String>();
// 		paramMap.put("searchCondition", searchCondition);
// 		paramMap.put("searchKeyword", searchKeyword);
// 		int totalCount = bService.getTotalCount(paramMap);
// 		// 공지사항 페이징 그대로 사용
// 		NoticePageInfo pi = this.getPageInfo(currentPage, totalCount);
// 		List<BlacklistVO> searchList = bService.searchBlacklistsByKeyword(pi, paramMap);
// 		mv.addObject("sList", searchList);
// 		mv.addObject("pi", pi);
// 		mv.addObject("searchCondition", searchCondition);
// 		mv.addObject("searchKeyword", searchKeyword);
// 		mv.setViewName("blacklist/search");
// 		return mv;
// 	}
    
    // ===================
 	// 페이징 처리
 	// ===================
    private NoticePageInfo getPageInfo(Integer currentPage, int totalCount) {
		NoticePageInfo pi = null;
		int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
		int naviLimit = 5; 	 // 한 페이지당 보여줄 네비 범위의 갯수
		int naviTotalCount;  // 범위의 총 갯수
		int startNavi;
		int endNavi;
		
		naviTotalCount = (int)((double) totalCount / boardLimit + 0.9);
		startNavi = (((int)((double) currentPage / naviLimit + 0.9)) - 1) * naviLimit + 1;
		endNavi = startNavi + naviLimit - 1;
		if (endNavi > naviTotalCount) {
			endNavi = naviTotalCount;
		}
		pi = new NoticePageInfo(currentPage, totalCount, naviTotalCount, boardLimit, naviLimit, startNavi,
				endNavi);
		return pi;
	}

}
