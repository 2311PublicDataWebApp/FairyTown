package com.fairytown.ft.review.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;
import com.fairytown.ft.review.domain.vo.ReviewImageVO;
import com.fairytown.ft.review.domain.vo.ReviewVO;
import com.fairytown.ft.review.service.ReviewService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import oracle.jdbc.proxy.annotation.Post;

@Controller
public class ReviewController {

	@Autowired
	private ReviewService rService;
	
	
	// ===================
	// 리뷰 등록 페이지
	// ===================
//	@GetMapping("/review/insert.ft")
//	public String showWriteForm(Model model, ReviewVO review) {
//		// * 로그인 안정화 후 주석 해제
//		// 세션에서 실제 사용자의 이름을 가져와서 review 객체에 설정
////	    String realName = (String) session.getAttribute("realName");
////	    review.setRealName(realName);
//		// 실명 우선 하드코딩 (로그인 안정화 후 realName 받아올 것.)
//		review.setRealName("페어리용자");
//		// 셀렉트박스에 필요한 데이터를 가져와서 모델에 추가 (임시적용)
//		List<String> ticketTypes = Arrays.asList("자유이용권", "오전이용권", "오후이용권");
//		model.addAttribute("ticketTypes", ticketTypes);
//		return "review/write";		
//	}
	
	// ===================
	// 리뷰 등록
	// ===================
	@PostMapping("/review/insert.ft")
	public ModelAndView insertReview(ModelAndView mv
			, @ModelAttribute ReviewVO review
			, @ModelAttribute ReviewImageVO image
			, HttpSession session
			, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile
			, HttpServletRequest request){
		try {
			// 로그인 안정화 후 주석 해제
//			String realName = (String)session.getAttribute("realName");
//			review.setRealName(realName);
			review.setRealName("페어리용자");
			
			int result = rService.insertReview(review);
			if (uploadFile != null && !uploadFile.getOriginalFilename().equals("")) {
				Map<String, Object> infoMap = this.saveFile(uploadFile, request);
				String fileName 	= (String) infoMap.get("fileName");
				String fileRename 	= (String) infoMap.get("fileRename");
				String filePath 	= (String) infoMap.get("filePath");
				long fileLength 	= (long) infoMap.get("fileSize");
				
				image.setFileName(fileName);
				image.setFileRename(fileRename);
				image.setFilePath(filePath);
				image.setFileSize(fileLength);
				// 각 이미지 정보 저장
                rService.insertImage(image);
			}			
			
			if (result > 0) {
				// 등록한 글로 리다이렉트 (상세보기, sql문까지 완료 후 주석 해제)
				int reviewNo = review.getReviewNo();				
				String redirectUrl = "/review/detail.ft?reviewNo=" + reviewNo;
				mv.setViewName("redirect:" + redirectUrl);
			} else {
				mv.addObject("msg", "리뷰 등록 실패");
				mv.setViewName("common/errorPage");
			}			
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
//	@PostMapping("/review/insert.ft")
//	public ModelAndView insertReview(ModelAndView mv
//			, @ModelAttribute ReviewVO review
//			, HttpSession session
//			, HttpServletRequest request){
//		try {
//			// 로그인 안정화 후 주석 해제
////			String realName = (String)session.getAttribute("realName");
////			review.setRealName(realName);
//			review.setRealName("페어리용자");
//			
//			int result = rService.insertReview(review);
//			if (result > 0) {
//				// 등록한 글로 리다이렉트 (상세보기, sql문까지 완료 후 주석 해제)
//				int reviewNo = review.getReviewNo();				
//				String redirectUrl = "/review/detail.ft?reviewNo=" + reviewNo;
//				mv.setViewName("redirect:" + redirectUrl);
//			} else {
//				mv.addObject("msg", "리뷰 등록 실패");
//				mv.setViewName("common/errorPage");
//			}			
//		} catch (Exception e) {
//			mv.addObject("msg", e.getMessage());
//			mv.setViewName("common/errorPage");
//		}
//		return mv;
//	}
	
	// ===================
 	// 리뷰 상세보기
 	// ===================
    @GetMapping("/review/detail.ft")
    public ModelAndView showReviewDetail(ModelAndView mv, @RequestParam("reviewNo") int reviewNo) {
		try {
			ReviewVO review = rService.selectByReviewNo(reviewNo);
			if (review != null) {
				// 조회수 업데이트
				rService.updateViewCount(reviewNo);
				mv.addObject("review", review).setViewName("review/detail");
			} else {
				mv.addObject("msg", "데이터 불러오기가 실패.");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
    
    // ===================
    // 조회수 응답처리
    // ===================
    @ResponseBody
    @PostMapping("/review/updateViewCount/{reviewNo}")
    public ResponseEntity<String> updateViewCount(@PathVariable("reviewNo") int reviewNo){
    	// reviewNo에 해당하는 리뷰 조회 및 조회수 업데이트 로직 수행
    	rService.updateViewCount(reviewNo);   	
		return new ResponseEntity<>("Success", HttpStatus.OK);    	
    }
    
	// ===================
	// 유용해요
	// ===================
    @ResponseBody
    @PostMapping("/review/like/{reviewNo}")
    public ResponseEntity<String> likeReview(@PathVariable("reviewNo") int reviewNo
    		, @RequestParam("liked") boolean liked) {
        try {
            // 좋아요 수 업데이트
        	if(!liked) {
        		rService.decreaseLikeCount(reviewNo);
        	}else {
        		rService.increaseLikeCount(reviewNo);
        	}
            return ResponseEntity.ok("Success");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred: " + e.getMessage());
        }
    }

//    @ResponseBody
//    @PostMapping("/review/unlike/{reviewNo}")
//    public ResponseEntity<String> unlikeReview(@PathVariable("reviewNo") int reviewNo) {
//        try {
//            // 좋아요 수 업데이트
//            rService.decreaseLikeCount(reviewNo);
//            return ResponseEntity.ok("Success");
//        } catch (Exception e) {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred: " + e.getMessage());
//        }
//    }
//    
    
//     @ResponseBody
//	 @GetMapping("/review/updateLikeCountByAction")
//	 public String likeReview(@RequestParam("reviewNo") int reviewNo) {
//	     // 좋아요 수 업데이트
//	     rService.updateLikeCount(reviewNo);
//	
//	     // 리뷰 상세 페이지로 리다이렉트
//	     return "redirect:/review/detail.ft?reviewNo=" + reviewNo;
//	 }
	
	 // 좋아요 수 업데이트를 처리하는 메서드
//	 @ResponseBody
//	 @GetMapping("/review/updateLikeCountByMap")
//	 public ResponseEntity<String> updateLikeCount(@RequestParam("reviewNo") int reviewNo,
//	                                               @RequestParam("action") String action) {
//	     try {
//	         // 좋아요 수 업데이트를 서비스에 요청
//	         rService.updateLikeCount(reviewNo, action);
//	         return ResponseEntity.ok("Success");
//	     } catch (Exception e) {
//	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred: " + e.getMessage());
//	     }
//	 }
	    
    
    // ===================
 	// 리뷰 수정 페이지
 	// ===================
    
    // ===================
 	// 리뷰 수정
 	// ===================
	
    // ===================
 	// 리뷰 삭제
 	// ===================
    @GetMapping("review/delete.ft")
    public ModelAndView deleteReview(ModelAndView mv, int reviewNo) {
    	try {
			int result = rService.deleteReview(reviewNo);
			if (result > 0) {
				mv.setViewName("redirect:/review/list.ft");
			}else {
				mv.addObject("msg", "데이터가 존재하지 않습니다.").setViewName("common/errorPage");
			}
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
    	return mv;
    }
    
    // ===================
 	// 리뷰 리스트
 	// ===================
    @GetMapping("/review/list.ft")
    public ModelAndView ShowReviewList(ModelAndView mv, ReviewVO review,
            @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
		try {
			// 전체 리뷰 개수를 가져옴
			int totalCount = rService.getTotalCount();
			mv.addObject("totalCount", totalCount); // 모델에 totalCount 속성 추가
			
			
			// 페이지 정보를 생성
			NoticePageInfo pi = this.getPageInfo(currentPage, totalCount);
			
			// 현재 페이지에 해당하는 리뷰 목록을 가져옴
			List<ReviewVO> rList = rService.selectReviewList(pi);
			// 모델에 리뷰 목록과 페이지 정보를 추가
			mv.addObject("rList", rList);
			mv.addObject("pi", pi);
						
			// 작성하기
			review.setRealName("페어리용자");
//			// * 로그인 안정화 후 주석 해제
//			// 세션에서 실제 사용자의 이름을 가져와서 review 객체에 설정
////		String realName = (String) session.getAttribute("realName");
////		review.setRealName(realName);
			// 셀렉트박스에 필요한 데이터를 가져와서 모델에 추가 (임시적용)
			List<String> ticketTypes = Arrays.asList("자유이용권", "오전이용권", "오후이용권");
			mv.addObject("ticketTypes", ticketTypes);
			
			// 리뷰 목록 뷰로 이동
			mv.setViewName("review/list"); // 뷰 이름 설정
		} catch (Exception e) {
			// 오류가 발생할 경우 처리
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
    
    // ===================
 	// 리뷰 검색
 	// ===================
 	@GetMapping(value="/review/search.ft")
 	public ModelAndView searchNoticeList(ModelAndView mv
 			, @RequestParam("searchCondition") String searchCondition
 			, @RequestParam("searchKeyword") String searchKeyword
 			, @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
		// 전체 리뷰 개수를 가져옴
		int totalCounts = rService.getTotalCount();
		mv.addObject("totalCounts", totalCounts); // 모델에 totalCounts 속성 추가
		
 		Map<String, String> paramMap = new HashMap<String, String>();
 		paramMap.put("searchCondition", searchCondition);
 		paramMap.put("searchKeyword", searchKeyword);
 		int totalCount = rService.getTotalCount(paramMap);
 		NoticePageInfo pi = this.getPageInfo(currentPage, totalCount);
 		List<ReviewVO> searchList = rService.searchReviewsByKeyword(pi, paramMap);
 		mv.addObject("sList", searchList);
 		mv.addObject("pi", pi);
 		mv.addObject("searchCondition", searchCondition);
 		mv.addObject("searchKeyword", searchKeyword);
 		mv.setViewName("review/search");
 		return mv;
 	}
    
    // ===================
 	// 페이징 처리
 	// ===================
    private NoticePageInfo getPageInfo(Integer currentPage, int totalCount) {
		NoticePageInfo pi = null;
		int boardLimit = 12; // 한 페이지당 보여줄 게시물의 갯수
		int naviLimit = 5; 	 // 한 페이지당 보여줄 범위의 갯수
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

    
    // ==============
    // 파일 저장
    // ==============
    private Map<String, Object> saveFile(MultipartFile uploadFile, HttpServletRequest request) throws Exception {
		String fileName = uploadFile.getOriginalFilename();
//		String projectPath 	 = request.getSession().getServletContext().getRealPath("resources");
		String projectPath 	 = "/Users/jeonggyuyu/git/FairyTown/src/main/webapp/resources";
		String saveDirectory = projectPath + "/ruploadFiles";
		File sDir 			 = new File(saveDirectory);
		if (!sDir.exists()) {
			sDir.mkdir(); 
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
		String strResult = sdf.format(new Date(System.currentTimeMillis())); 
		String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
		String fileRename = strResult + "." + ext;
		String savePath 	 = saveDirectory + "/" + fileRename;
		File file = new File(savePath);
		uploadFile.transferTo(file);
		long fileLength = uploadFile.getSize();
		Map<String, Object> infoMap = new HashMap<String, Object>();
		infoMap.put("fileName"	, fileName);
		infoMap.put("fileRename", fileRename);
		infoMap.put("filePath"	, savePath);
		infoMap.put("fileSize"	, fileLength);
		return infoMap;
	}
    
    // ==============
    // 파일 삭제
    // ==============
    private void deleteFile(HttpServletRequest request, String fileName) {
		String rPath = request.getSession().getServletContext().getRealPath("resources");
		String delFilePath = rPath + "\\ruploadFiles\\" + fileName;
		File delFile = new File(delFilePath);
		if (delFile.exists()) {
			delFile.delete();
		}
		
	}
    
    
}
