package com.fairytown.ft.review.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.common.PageInfo;
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
	public ModelAndView insertReview(ModelAndView mv,
	        @ModelAttribute ReviewVO review,
	        HttpSession session,
	        @RequestParam(value = "uploadFiles", required = false) List<MultipartFile> uploadFiles,
	        HttpServletRequest request) {
	    try {
	        // 리뷰 작성자 설정 (로그인 안정화 후 주석 해제)
	        // String realName = (String) session.getAttribute("realName");
	        // review.setRealName(realName);
	        review.setRealName("페어리용자");

	        // 리뷰 등록
	        int result = rService.insertReview(review);

	        // 이미지 업로드 및 저장 (최대 3개까지)
	        if (uploadFiles != null && uploadFiles.size() <= 3) {
	            for (MultipartFile uploadFile : uploadFiles) {
	                Map<String, Object> infoMap = saveFile(uploadFile, request);
	                String fileName = (String) infoMap.get("fileName");
	                String fileRename = (String) infoMap.get("fileRename");
	                String filePath = (String) infoMap.get("filePath");
	                long fileLength = (long) infoMap.get("fileSize");

	                // 각 이미지 정보 저장
	                ReviewImageVO image = new ReviewImageVO();
	                image.setFileName(fileName);
	                image.setFileRename(fileRename);
	                image.setFilePath(filePath);
	                image.setFileSize(fileLength);
	                image.setReviewNo(review.getReviewNo()); // 리뷰 번호 설정

	                rService.insertImage(image);
	            }
	        } else {
	            // 업로드 파일 개수가 3개를 초과하는 경우 에러 처리
	            mv.addObject("msg", "최대 3개의 이미지만 업로드 가능합니다.");
	            mv.setViewName("common/errorPage");
	            return mv;
	        }

	        if (result > 0) {
	            // 등록한 글로 리다이렉트 (상세보기, sql문까지 완료 후 주석 해제)
//	            int reviewNo = review.getReviewNo();
//	            String redirectUrl = "/review/detail.ft?reviewNo=" + reviewNo;
//	            mv.setViewName("redirect:" + redirectUrl);
	        	mv.setViewName("redirect:/review/list.ft");
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
    public ModelAndView deleteReview(ModelAndView mv, @RequestParam("reviewNo") int reviewNo) {
        try {
            int result = rService.deleteReview(reviewNo);
            if (result > 0) {
                mv.setViewName("redirect:/review/list.ft");
            } else {
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
            @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage
            , @RequestParam(value="sortType", required=false, defaultValue="recentReviewSort") String sortType
            ) {
		try {
			// 전체 리뷰 개수를 가져옴
			int totalCount = rService.getTotalCount();
			mv.addObject("totalCount", totalCount); // 모델에 totalCount 속성 추가
			
			// 페이지 정보를 생성
			PageInfo pi = this.getPageInfo(currentPage, totalCount);
			pi.setType(sortType);
			// 현재 페이지에 해당하는 리뷰 목록을 가져옴
			List<ReviewVO> rList = rService.selectReviewList(pi);
			// 정렬
//			List<ReviewVO> sortList = rService.selectReviewList(pi);
			// 모델에 리뷰 목록과 페이지 정보를 추가
			mv.addObject("rList", rList);
//			mv.addObject("sortList", sortList);
			mv.addObject("pi", pi);	
			
			
			// 베스트 리뷰(top1)
			ReviewVO bestReview = rService.getBestReview(); // bestReview 객체를 ModelAndView에 추가
            mv.addObject("bestReview", bestReview);
			
			// 추천 리뷰 리스트(best3)
			List<ReviewVO> lList = rService.getTopLikedReviews();
	    	mv.addObject("lList", lList);
			
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
    
    // ==============
    // 리뷰 리스트(정렬)
    // ==============
    @ResponseBody
    @GetMapping("/review/sortedList.ft")
    public Map<String, Object> sortReviews(
            @RequestParam(value="page", 
            required=false, defaultValue="1") Integer currentPage
            , @RequestParam("sortType") String sortType) {
    	Map<String, Object> result = new HashMap<String, Object>();
    	try {
			int totalCount = rService.getTotalCount();
			PageInfo pi = this.getPageInfo(currentPage, totalCount);
			List<ReviewVO> sortList = rService.selectReviewList(pi, sortType);
			result.put("sortList", sortList);
	 		result.put("pi", pi);
	 		result.put("sortType", sortType);
	 		result.put("msg", "success");
		} catch (Exception e) {
			// TODO: handle exception
			result.put("msg", e.getMessage());
		}
    	return result;
    }
    
    
 // 이전 페이지에 대한 리뷰 목록 반환 핸들러 메서드
    @GetMapping("/review/previous")
    public String getPreviousPageReviews(@RequestParam("currentPage") int currentPage, Model model) {
        int previousPage = currentPage - 1; // 이전 페이지 번호 계산
        List<ReviewVO> reviews = rService.getReviewsForPage(previousPage); // 이전 페이지에 대한 리뷰 목록 가져오기
        model.addAttribute("reviews", reviews); // 리뷰 목록 모델에 추가
        model.addAttribute("currentPage", previousPage); // 이전 페이지 번호를 모델에 추가
        return "review/list"; // 이전 페이지에 대한 리뷰 목록이 표시되는 뷰의 이름을 반환
    }

    // 다음 페이지에 대한 리뷰 목록 반환 핸들러 메서드
    @GetMapping("/review/next")
    public String getNextPageReviews(@RequestParam("currentPage") int currentPage, Model model) {
        int nextPage = currentPage + 1; // 다음 페이지 번호 계산
        List<ReviewVO> reviews = rService.getReviewsForPage(nextPage); // 다음 페이지에 대한 리뷰 목록 가져오기
        model.addAttribute("reviews", reviews); // 리뷰 목록 모델에 추가
        model.addAttribute("currentPage", nextPage); // 다음 페이지 번호를 모델에 추가
        return "review/list"; // 다음 페이지에 대한 리뷰 목록이 표시되는 뷰의 이름을 반환
    }
    
    // ===================
    // 추천 리뷰 리스트(best3)
    // ===================
//    @GetMapping("topLikedReviews")
//    public String getTopLikedReviews(Model model) {
//    	List<ReviewVO> lList = rService.getTopLikedReviews();
//    	model.addAttribute("lList", lList);
//    	return "review/list"; 
////    	return "topLikedReviews";
//    }
    
    // ===================
    // 베스트 리뷰(조회수 기준)
    // ===================
//    @GetMapping("/review/best")
//    @ResponseBody
//    public ModelAndView showBestReview(ModelAndView mv) {
//        try {
//            // 가장 조회수가 높은 리뷰를 가져옴
//            ReviewVO bestReview = rService.getBestReview(); // bestReview 객체를 ModelAndView에 추가
//            mv.addObject("bestReview", bestReview);            	
//            if (bestReview == null) {
//            	mv.addObject("noBestReviewMessage", "베스트 리뷰가 없습니다.");
//            } 
//            mv.setViewName("review/list"); // 뷰 이름 설정
//            // bestReview가 제대로 작동하는지 체크
//        } catch (Exception e) {
//            // 오류가 발생할 경우 처리
//            mv.addObject("msg", e.getMessage());
//            mv.setViewName("common/errorPage");
//        }
//        return mv;
//    }
    
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
		
		// 추천 리뷰 리스트(best3)
		List<ReviewVO> lList = rService.getTopLikedReviews();
    	mv.addObject("lList", lList);
		
 		Map<String, String> paramMap = new HashMap<String, String>();
 		paramMap.put("searchCondition", searchCondition);
 		paramMap.put("searchKeyword", searchKeyword);
 		int totalCount = rService.getTotalCount(paramMap);
 		PageInfo pi = this.getPageInfo(currentPage, totalCount);
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
    private PageInfo getPageInfo(Integer currentPage, int totalCount) {
		PageInfo pi = null;
		int boardLimit = 12; // 한 페이지당 보여줄 게시물의 갯수
		int naviLimit = 5; 	 // 한 페이지당 보여줄 범위의 갯수
		pi = new PageInfo(currentPage, totalCount, boardLimit);
		pi.setNaviLimit(naviLimit);
		return pi;
	}		
    
    // ==============
    // 파일 저장
    // ==============
    private Map<String, Object> saveFile(MultipartFile uploadFile, HttpServletRequest request) throws Exception {
        String fileName = uploadFile.getOriginalFilename();
        // String projectPath = request.getSession().getServletContext().getRealPath("resources");
        String projectPath = "/Users/jeonggyuyu/git/FairyTown/src/main/webapp/resources";
        String saveDirectory = projectPath + "/ruploadFiles";
        File sDir = new File(saveDirectory);
        if (!sDir.exists()) {
            sDir.mkdir(); 
        }

        String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
        String fileRename = UUID.randomUUID().toString() + "." + ext;
        String savePath = saveDirectory + "/" + fileRename;
        File file = new File(savePath);
        uploadFile.transferTo(file);
        long fileLength = uploadFile.getSize();
        Map<String, Object> infoMap = new HashMap<>();
        infoMap.put("fileName", fileName);
        infoMap.put("fileRename", fileRename);
        infoMap.put("filePath", savePath);
        infoMap.put("fileSize", fileLength);
        return infoMap;
    }
    
    // =============
    // 다중 파일 저장
    // =============
    private List<Map<String, Object>> saveFiles(List<MultipartFile> uploadFiles, HttpServletRequest request) throws Exception {
        List<Map<String, Object>> infoList = new ArrayList<>();
        String projectPath = "/Users/jeonggyuyu/git/FairyTown/src/main/webapp/resources";
        String saveDirectory = projectPath + "/ruploadFiles";
        File sDir = new File(saveDirectory);
        if (!sDir.exists()) {
            sDir.mkdir(); 
        }

        for (MultipartFile uploadFile : uploadFiles) {
            String fileName = uploadFile.getOriginalFilename();
            String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
            String fileRename = UUID.randomUUID().toString() + "." + ext;
            String savePath = saveDirectory + "/" + fileRename;
            File file = new File(savePath);
            uploadFile.transferTo(file);
            long fileLength = uploadFile.getSize();
            Map<String, Object> infoMap = new HashMap<>();
            infoMap.put("fileName", fileName);
            infoMap.put("fileRename", fileRename);
            infoMap.put("filePath", savePath);
            infoMap.put("fileSize", fileLength);
            infoList.add(infoMap);
        }
        return infoList;
    }
    
    // =================
    // 다중 파일 업로드 처리
    // =================
    public ResponseEntity<?> uploadFiles(@RequestParam("files") List<MultipartFile> files, HttpServletRequest request) {
        try {
            List<Map<String, Object>> fileInfoList = saveFiles(files, request);
            // 파일 업로드가 성공했을 때의 처리
            return new ResponseEntity<>(fileInfoList, HttpStatus.OK);
        } catch (Exception e) {
            // 파일 업로드 중 오류가 발생했을 때의 처리
            return new ResponseEntity<>("Failed to upload files", HttpStatus.INTERNAL_SERVER_ERROR);
        }
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
