package com.fairytown.ft.notice.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.notice.domain.vo.NoticePageInfo;
import com.fairytown.ft.notice.domain.vo.NoticeVO;
import com.fairytown.ft.notice.service.NoticeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;




@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService nService;
	
	
	// =========================
	// 공지사항 등록 페이지 (Admin)
	// =========================
	@GetMapping("/admin/notice/insert.ft")
	public String showWriteForm(Model model) {
		// 셀렉트박스에 필요한 데이터를 가져와서 모델에 추가
        List<String> noticeTypes = Arrays.asList("공지", "이벤트");
        model.addAttribute("noticeTypes", noticeTypes);
		return "notice/write";
	}
		
	// ====================
	// 공지사항 등록 (Admin)
	// ====================
	@PostMapping("/admin/notice/insert.ft")
	public ModelAndView insertNotice(ModelAndView mv
			, @ModelAttribute NoticeVO notice
			, HttpSession session
			, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile
			, HttpServletRequest request) {
		try {
			// 로그인 안정화 후 주석 해제 
//			String userId = (String)session.getAttribute("userId");
//			notice.setUserId(userId);
			
			 // 사용자 ID를 "khuser01"로 고정 중
	        notice.setUserId("khuser04");
	        
	        // ===========
	        // 파일 영역
			if (uploadFile != null && !uploadFile.getOriginalFilename().equals("")) {
				Map<String, Object> infoMap = this.saveFile(uploadFile, request);
				String fileName 	= (String) infoMap.get("fileName");
				String fileRename 	= (String) infoMap.get("fileRename");
				String filePath 	= (String) infoMap.get("filePath");
				long fileLength 	= (long) infoMap.get("fileSize");
				
				notice.setNoticeFileName(fileName);
				notice.setNoticeFileRename(fileRename);
				notice.setNoticeFilePath(filePath);
				notice.setNoticeFileLength(fileLength);
			}
			// ==========		
			
			int result = nService.insertNotice(notice);
			if (result > 0) {
				int noticeNo = notice.getNoticeNo(); // 등록된 공지사항의 번호를 가져옴. 혹은 등록 후에 생성된 ID를 가져오는 방법에 따라 달라질 수 있음.
//				mv.setViewName("redirect:/notice/detail?noticeNo="+notice.getNoticeNo());
				// 공지사항 등록이 성공한 경우
			    // 등록된 공지사항의 ID를 가져옴

				// 상세 페이지로 이동하기 위해 공지사항 ID를 사용하여 URL을 생성
			    String redirectUrl = "/admin/notice/detail.ft?noticeNo=" + noticeNo;
			    
			    // 생성된 URL로 리다이렉트
			    mv.setViewName("redirect:" + redirectUrl);

			} else {
				mv.addObject("msg", "공지사항 등록 실패.");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	// ===================
 	// 공지사항 상세보기
 	// ===================
    @GetMapping("/notice/detail.ft")
    public ModelAndView showNoticeDetail(ModelAndView mv, @RequestParam("noticeNo") int noticeNo) {
		try {
			NoticeVO notice = nService.selectByNoticeNo(noticeNo);
			if (notice != null) {
				mv.addObject("notice", notice).setViewName("notice/detail");
			} else {
				mv.addObject("msg", "데이터 불러오기가 실패.");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
    
	// ======================
 	// 공지사항 상세보기 (Admin)
 	// ======================
    @GetMapping("/admin/notice/detail.ft")
    public ModelAndView showAdminNoticeDetail(ModelAndView mv, @RequestParam("noticeNo") int noticeNo) {
		try {
			NoticeVO notice = nService.selectByNoticeNo(noticeNo);
			if (notice != null) {
				mv.addObject("notice", notice).setViewName("notice/adminDetail");
			} else {
				mv.addObject("msg", "데이터 불러오기가 실패.");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}    
    
    // =========================
 	// 공지사항 수정 페이지 (Admin)
 	// =========================
    @GetMapping("/admin/notice/modify.ft")
    public ModelAndView showModifyForm(ModelAndView mv, @RequestParam("noticeNo") int noticeNo) {
		try {
			NoticeVO notice = nService.selectByNoticeNo(noticeNo);
			if (notice != null) {
				mv.addObject("notice", notice);
				mv.setViewName("notice/modify");
			} else {
				mv.addObject("msg", "데이터 불러오기 실패.");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
    
    // ===================
 	// 공지사항 수정 (Admin)
 	// ===================
    @PostMapping("/admin/notice/modify,ft")
    public ModelAndView updateNotice(ModelAndView mv, @ModelAttribute NoticeVO notice,
			@RequestParam(value = "reloadFile", required = false) MultipartFile reloadFile, HttpServletRequest request,
			@RequestParam("noticeNo") int noticeNo) {
		try {
			if (reloadFile != null && !reloadFile.isEmpty()) {
				String fileName = notice.getNoticeFileRename();
				if (fileName != null) {
					// 있으면 파일 삭제
					this.deleteFile(request, fileName);
				}
				// 없으면 새로 업로드하려는 파일 저장
				Map<String, Object> infoMap = this.saveFile(reloadFile, request);
				String noticeFilename = (String) infoMap.get("fileName");
				notice.setNoticeFileName(noticeFilename);
				notice.setNoticeFileRename((String) infoMap.get("fileRename"));
				notice.setNoticeFilePath((String) infoMap.get("filePath"));
				notice.setNoticeFileLength((long) infoMap.get("fileSize"));
			}
			int result = nService.updateNotice(notice);
			if (result > 0) {
				mv.setViewName("redirect:/admin/notice/detail.ft?noticeNo=" + notice.getNoticeNo());
			} else {
				mv.addObject("msg", "데이터가 존재하지 않습니다.");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
    
    // ===================
 	// 공지사항 삭제 (Admin)
 	// ===================
    @GetMapping("/admin/notice/delete.ft")
    public ModelAndView deleteNotice(ModelAndView mv, @RequestParam("noticeNo") int noticeNo) {
		try {
			int result = nService.deleteNotice(noticeNo);
			if (result > 0) {
				mv.setViewName("redirect:/admin/notice/list.ft");
			} else {
				mv.addObject("msg", "데이터가 존재하지 않습니다.").setViewName("common/errorPage");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
	
	
	// ===================
	// 공지사항 리스트
	// ===================
	@GetMapping("/notice/list.ft")
    public ModelAndView ShowNoticeList(ModelAndView mv,
            @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
		try {
			// 전체 공지사항 개수를 가져옴
			int totalCount = nService.getTotalCount();
			
			// 페이지 정보를 생성
			NoticePageInfo pi = this.getPageInfo(currentPage, totalCount);
			
			// 현재 페이지에 해당하는 공지사항 목록을 가져옴
			List<NoticeVO> nList = nService.selectNoticeList(pi);
			
			// 모델에 공지사항 목록과 페이지 정보를 추가
			mv.addObject("nList", nList);
			mv.addObject("pi", pi);
			
			// 공지사항 목록 뷰로 이동
			mv.setViewName("notice/list");
		} catch (Exception e) {
			// 오류가 발생할 경우 처리
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
    
	// =====================
	// 공지사항 리스트 (Admin)
	// =====================
	@GetMapping("/admin/notice/list.ft")
    public ModelAndView ShowAdminNoticeList(ModelAndView mv,
            @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
		try {
			// 전체 공지사항 개수를 가져옴
			int totalCount = nService.getTotalCount();
			
			// 페이지 정보를 생성
//			NoticePageInfo pi = this.getPageInfo(currentPage, totalCount);
			
			// 현재 페이지에 해당하는 공지사항 목록을 가져옴
			List<NoticeVO> nList = nService.selectNoticeList();
			
			// 모델에 공지사항 목록과 페이지 정보를 추가
			mv.addObject("nList", nList);
//			mv.addObject("pi", pi);
			
			// 공지사항 목록 뷰
			mv.setViewName("notice/adminList");
		} catch (Exception e) {
			// 오류가 발생할 경우 처리
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
    
    // ===================
 	// 공지사항 검색
 	// ===================
 	@GetMapping(value="/notice/search.ft")
 	public ModelAndView searchNoticeList(ModelAndView mv
 			, @RequestParam("searchCondition") String searchCondition
 			, @RequestParam("searchKeyword") String searchKeyword
 			, @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
 		
 		Map<String, String> paramMap = new HashMap<String, String>();
 		paramMap.put("searchCondition", searchCondition);
 		paramMap.put("searchKeyword", searchKeyword);
 		int totalCount = nService.getTotalCount(paramMap);
 		NoticePageInfo pi = this.getPageInfo(currentPage, totalCount);
 		List<NoticeVO> searchList = nService.searchNoticesByKeyword(pi, paramMap);
 		mv.addObject("sList", searchList);
 		mv.addObject("pi", pi);
 		mv.addObject("searchCondition", searchCondition);
 		mv.addObject("searchKeyword", searchKeyword);
 		mv.setViewName("notice/search");
 		return mv;
 	}
 	
    // ===================
 	// 공지사항 검색(Admin)
 	// ===================
 	@GetMapping(value="/admin/notice/search.ft")
 	public ModelAndView searchAdminNoticeList(ModelAndView mv
 			, @RequestParam("searchCondition") String searchCondition
 			, @RequestParam("searchKeyword") String searchKeyword
 			, @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
 		
 		Map<String, String> paramMap = new HashMap<String, String>();
 		paramMap.put("searchCondition", searchCondition);
 		paramMap.put("searchKeyword", searchKeyword);
 		int totalCount = nService.getTotalCount(paramMap);
 		NoticePageInfo pi = this.getPageInfo(currentPage, totalCount);
 		List<NoticeVO> searchList = nService.searchNoticesByKeyword(pi, paramMap);
 		mv.addObject("sList", searchList);
 		mv.addObject("pi", pi);
 		mv.addObject("searchCondition", searchCondition);
 		mv.addObject("searchKeyword", searchKeyword);
 		mv.setViewName("notice/adminSearch");
 		return mv;
 	}
    
    // ===================
 	// 페이징 처리
 	// ===================
    private NoticePageInfo getPageInfo(Integer currentPage, int totalCount) {
		NoticePageInfo pi = null;
		int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
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
    
    // ===================
 	// 파일 저장
 	// ===================
    private Map<String, Object> saveFile(MultipartFile uploadFile, HttpServletRequest request) throws Exception {
		// 파일 이름
		String fileName = uploadFile.getOriginalFilename();
		// 저장 경로
		String projectPath 	 = request.getSession().getServletContext().getRealPath("resources");
		String saveDirectory = projectPath + "\\nuploadFiles";
		File sDir 			 = new File(saveDirectory);
		if (!sDir.exists()) {
			sDir.mkdir(); 
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
		String strResult = sdf.format(new Date(System.currentTimeMillis())); 
		String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
		String fileRename = strResult + "." + ext;

		
		String savePath 	 = saveDirectory + "\\" + fileRename;
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
    
    // ===================
 	// 파일 삭제
 	// ===================
    private void deleteFile(HttpServletRequest request, String fileName) {
		// TODO Auto-generated method stub
		String rPath = request.getSession().getServletContext().getRealPath("resources");
		String delFilePath = rPath + "\\nuploadFiles\\" + fileName;
		File delFile = new File(delFilePath);
		if (delFile.exists()) {
			delFile.delete();
		}
		
	}
}
