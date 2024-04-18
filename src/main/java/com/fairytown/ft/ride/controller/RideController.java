package com.fairytown.ft.ride.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ride.service.RideService;
import com.fairytown.ft.ticket.domain.vo.TicketVO;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.ride.domain.vo.RimgVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RideController {

	@Autowired
	private RideService rService;
	
	// --------- [어드민] ---------

//	놀이기구 등록
//	/admin/rideregist.ft
		@GetMapping("/admin/rideregist.ft")
		public String showRideRegist() {
			return "admin/rideregist";
		}
		
//		놀이기구 등록
//		//admin/rideregist.ft
		@PostMapping("/admin/rideregist.ft")
		public ModelAndView insertRide(ModelAndView mv,
		        @ModelAttribute RideVO ride,
		        @ModelAttribute RimgVO rImg,
		        HttpSession session,
		        @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile,
//		        @RequestParam("rideId") Integer rideId,
		        HttpServletRequest request) {
		    try {
//		    	rideId = (Integer) session.getAttribute("rideId");
//		        if (rideId != null) {
//		            ride.setRideId(rideId);
//		        } else {
//		            throw new Exception("세션에서 rideId를 찾을 수 없습니다.");
//		        }
		        
		        if (uploadFile != null && !uploadFile.isEmpty()) {
		            Map<String, Object> infoMap = saveFile(uploadFile, request);
		            String fileName = (String) infoMap.get("fileName");
		            String fileRename = (String) infoMap.get("fileRename");
		            String filePath = (String) infoMap.get("filePath");
		            long fileLength = (long) infoMap.get("fileSize");
		            rImg.setRideImgName(fileName);
		            rImg.setRideImgRename(fileRename);
		            rImg.setRideImgFilepath(filePath);
		            rImg.setRideImgFilelength(fileLength);
		        }

		        int result = rService.insertRide(ride, rImg);
		        if (result > 0) {
		            mv.setViewName("redirect:/admin/ridelist.ft");
		        } else {
		            mv.addObject("msg", "등록이 완료되지 못했습니다.");
		            mv.setViewName("common/errorPage");
		        }
		    } catch (Exception e) {
		        mv.addObject("msg", e.getMessage());
		        mv.setViewName("common/errorPage");
		    }
		    return mv;
		}

		// 파일 저장
		private Map<String, Object> saveFile(MultipartFile uploadFile, HttpServletRequest request) throws Exception {
		    String fileName = uploadFile.getOriginalFilename();
		    String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/nuploadFiles");
		    File sDir = new File(saveDirectory);
		    if (!sDir.exists()) {
		        sDir.mkdirs();
		    }

		    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		    String strResult = sdf.format(new Date(System.currentTimeMillis()));
		    String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
		    String fileRename = strResult + "." + ext;
		    String savePath = saveDirectory + File.separator + fileRename;
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
	   
		
//		놀이기구 상세
//		/admin/ridedetail.ft
//		@GetMapping("/admin/ridedetail.ft")
//		public String showRdetailPage() {
//			return "/admin/ridedetail";
//		}

		@GetMapping("/admin/ridedetail.ft")
		public ModelAndView selectridedetail(ModelAndView mv,
				@RequestParam("rideId") int rideId) {
			try {
				RideVO ride = rService.selectByRideId(rideId);
				if (ride != null) {
					mv.addObject("ride", ride);
					mv.setViewName("admin/ridedetail");
				} else {
					mv.addObject("msg", "데이터가 존재하지 않았습니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
		
		
		
//		놀이기구 목록
//		/admin/ridelist.ft
		@GetMapping("/admin/ridelist.ft") 
		public ModelAndView showRideList(ModelAndView mv,
		        @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
		    try {
		        int totalCount = rService.getTotalCount();
		        PageInfo pi = new PageInfo(currentPage, totalCount, 10);
		        List<RideVO> rList = rService.selectRideList(pi);
		        mv.addObject("rList", rList);
		        mv.addObject("pi", pi);
		        mv.addObject("totalCount", totalCount);
		        mv.setViewName("admin/ridelist"); // 수정: 경로 수정
		    } catch (Exception e) {
		        mv.addObject("msg", e.getMessage());
		        mv.setViewName("common/errorPage");
		    }
		    return mv;
		}
		
		
		
//		놀이기구 검색
//		/admin/ridesearch.ft
	 	@PostMapping(value="/admin/ridesearch.ft")
	 	public ModelAndView showRideSearch(ModelAndView mv
	 			, @RequestParam("searchCondition") String searchCondition
	 			, @RequestParam("searchKeyword") String searchKeyword
	 			, @RequestParam(value="page", required=false, defaultValue="1") Integer page) {
	 		
	 		Map<String, String> paramMap = new HashMap<String, String>();
	 		paramMap.put("searchCondition", searchCondition);
	 		paramMap.put("searchKeyword", searchKeyword);
	 		int totalCount = rService.getTotalCount(paramMap);
	 		PageInfo pi = new PageInfo(page, totalCount, 10);
	 		List<RideVO> sList = rService.searchRideByKeyword(pi, paramMap);
	 		mv.addObject("sList", sList);
	 		mv.addObject("pi", pi);
	 		mv.addObject("totalCount", totalCount);
	 		mv.addObject("searchCondition", searchCondition);
	 		mv.addObject("searchKeyword", searchKeyword);
	 		mv.setViewName("admin/ridesearch");
	 		return mv;
	 	}
		
//		놀이기구 수정
//		//admin/ridemodify.ft
	 	@GetMapping("/admin/ridemodify.ft")
		public String showModifyRide(Model model,
	 		@RequestParam("rideId") int rideId) {
	 	 		RideVO ride = rService.selectByRideId(rideId);
	 	 		List<RimgVO> imgList = rService.selectRideImgList(rideId);
	 	 		model.addAttribute("ride", ride);
	 			return "admin/ridemodify";
		}
	 	
	 	 @PostMapping("/admin/ridemodify.ft")
	     public ModelAndView modifyRide(ModelAndView mv, 
	    		@ModelAttribute RideVO ride,
	    		@ModelAttribute RimgVO rImg,
	    		@ModelAttribute ArrayList<RimgVO> rImgList,
	 			@RequestParam(value = "reloadFile", required = false) MultipartFile reloadFile, HttpServletRequest request,
	 			@RequestParam("rideId") Integer rideId) {
	 		try {
	 			if (reloadFile != null && !reloadFile.isEmpty()) {
	 				String fileName = rImg.getRideImgRename();
	 				if (fileName != null) {
	 					this.deleteFile(request, fileName);
	 				}
	 				Map<String, Object> infoMap = this.saveFile(reloadFile, request);
	 				String rideFilename = (String) infoMap.get("fileName");
	 				rImg.setRideImgName(rideFilename);
	 				rImg.setRideImgRename((String) infoMap.get("fileRename"));
	 				rImg.setRideImgFilepath((String) infoMap.get("filePath"));
	 				rImg.setRideImgFilelength((long) infoMap.get("fileSize"));
	 			}
	 			int result = rService.modifyRide(ride);
	 			result+= rService.modifyRideImg(rImg);
	 			if (result > 0) {
	 				mv.setViewName("redirect:/admin/ridedetail.ft?rideId=" + ride.getRideId());
	 			} else {
	 				mv.addObject("msg", "데이터가 존재하지 않습니다.");
	 				mv.setViewName("common/errorPage");
	 			}
	 		} catch (Exception e) {
	 			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
	 		}
	 		return mv;
	 	}
	 	 
	 	 
	 	 
//		놀이기구 삭제
//		/admin/ridedelete.ft
	 	@GetMapping("/admin/ridedelete.ft")
	    public ModelAndView deleteride(ModelAndView mv, int rideId) {
			try {
				int result = rService.deleteRide(rideId);
				if (result > 0) {
					mv.setViewName("redirect:/admin/ridelist.ft");
				} else {
					mv.addObject("msg", "데이터가 존재하지 않습니다.")
					.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
			}
			return mv;
		}

	 	
	 	
	 	
	// --------- [유저] --------- 
//		놀이기구 목록
//		ride/list.ft
	 	
	 	@GetMapping("ride/list.ft")
	 	public String showridelist() {
	 		return "ride/list";
	 	}
		
	 	
	 	
//		놀이기구 상세
//		ride/detail.ft
	 	
	 	@GetMapping("ride/detail.ft")
	 	public String showridedetail() {
	 		return "ride/detail";
	 	}
	 	
	

	
//	놀이기구 코스짜기
//	course/regist.ft
//	놀이기구 코스짜기 검색
//	course/search.ft
//	나의 코스보기
//	course/mycourse.ft
	
	
	
		// 휴무 등록 페이지 이동
		@GetMapping("/admin/closeregist.ft")
		public String showCloseRegistPage(Model model) {
			List<RideVO> clist = rService.selectCloseList();
			model.addAttribute("clist", clist);
			return "admin/closeregist";
		}

		
//		휴무 등록
//		admin/closeregist.ft
		@PostMapping("/admin/closeregist.ft")
		public ModelAndView insertclose(ModelAndView mv
				, @ModelAttribute RideVO close
				, HttpSession session
				, HttpServletRequest request
				,@RequestParam("closeNo") Integer closeNo){
			try {
				
				closeNo = (Integer)session.getAttribute("closeNo");
				close.setCloseNo(closeNo);
				int result = rService.insertClose(close);
				if (result > 0) {
					mv.setViewName("redirect:/admin/closelist.ft");
				} else {
					mv.addObject("msg", "등록이 완료되지 못했습니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
		
		
//		휴무 상세
//		admin/closedetail.ft
		@GetMapping("/admin/closedetail.ft")
		public String showTdetailPage() {
			return "admin/closedetail";
		}

		@PostMapping("/admin/closedetail.ft")
		public ModelAndView selectclosedetail(ModelAndView mv, int closeNo) {
			try {
				RideVO close = rService.selectByCloseNo(closeNo);
				if (close != null) {
					mv.addObject("close", close);
					mv.setViewName("admin/closedetail");
				} else {
					mv.addObject("msg", "데이터가 존재하지 않았습니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
	   
	    
		
//		휴무 목록
//		admin/closelist.ft
		@GetMapping("/admin/closelist.ft")
	    public ModelAndView ShowcloseList(ModelAndView mv,
	            @RequestParam(value="page", 
	            required=false, defaultValue="1") Integer currentPage) {
			try {
				int totalCount = rService.getTotalCount();
				PageInfo pi = new PageInfo(currentPage, totalCount, 10);
				List<RideVO> rList = rService.selectCloseList();
				mv.addObject("rList", rList);
				mv.addObject("pi", pi);
				mv.setViewName("admin/closelist");
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
	    };
		
//		휴무 검색
//		admin/closesearch.ft
	 	@PostMapping(value="/admin/closesearch.ft")
	 	public ModelAndView showcloseSearch(ModelAndView mv
	 			, @RequestParam("searchCondition") String searchCondition
	 			, @RequestParam("searchKeyword") String searchKeyword
	 			, @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
	 		
	 		Map<String, String> paramMap = new HashMap<String, String>();
	 		paramMap.put("searchCondition", searchCondition);
	 		paramMap.put("searchKeyword", searchKeyword);
	 		int totalCount = rService.getTotalCount(paramMap);
	 		PageInfo pi = new PageInfo(currentPage, totalCount, 10);
	 		List<RideVO> sList = rService.selectcloseByKeyword(pi, paramMap);
	 		mv.addObject("sList", sList);
	 		mv.addObject("pi", pi);
	 		mv.addObject("searchCondition", searchCondition);
	 		mv.addObject("searchKeyword", searchKeyword);
	 		mv.setViewName("admin/closesearch");
	 		return mv;
	 	}
		
//		휴무 수정
//		admin/closemodify.ft
	 	 @PostMapping("/admin/closemodify.ft")
	     public ModelAndView modifyclose(ModelAndView mv, @ModelAttribute RideVO close,
	 			int closeNo) {
	 		try {
	 			int result = rService.modifyclose(close);
	 			if (result > 0) {
	 				mv.setViewName("redirect:/admin/closedetail.ft?closeNo=" + close.getCloseNo());
	 			} else {
	 				mv.addObject("msg", "데이터가 존재하지 않습니다.");
	 				mv.setViewName("common/errorPage");	
	 			}
	 		} catch (Exception e) {
	 			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
	 		}
	 		return mv;
	 	}
	 	 
	 	 
	 	 
//		휴무 삭제
//		admin/closedelete.ft
	 	@GetMapping("/admin/closedelete.ft")
	    public ModelAndView deleteclose(ModelAndView mv, int closeNo) {
			try {
				int result = rService.deleteclose(closeNo);
				if (result > 0) {
					mv.setViewName("redirect:/admin/closelist.ft");
				} else {
					mv.addObject("msg", "데이터가 존재하지 않습니다.")
					.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
			}
			return mv;
		}
	
	
//	-----------------------------------------기타 필요 코드
	 	
	 	
    // 파일 저장
//    private Map<String, Object> saveFile(MultipartFile uploadFile, HttpServletRequest request) throws Exception {
//		String fileName = uploadFile.getOriginalFilename();
//		String projectPath 	 = request.getSession().getServletContext().getRealPath("resources");
//		String saveDirectory = projectPath + "\\nuploadFiles";
//		File sDir 			 = new File(saveDirectory);
//		if (!sDir.exists()) {
//			sDir.mkdir(); 
//		}
//		
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
//		String strResult = sdf.format(new Date(System.currentTimeMillis())); 
//		String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
//		String fileRename = strResult + "." + ext;
//		String savePath 	 = saveDirectory + "\\" + fileRename;
//		File file = new File(savePath);
//		uploadFile.transferTo(file);
//		long fileLength = uploadFile.getSize();
//		Map<String, Object> infoMap = new HashMap<String, Object>();
//		infoMap.put("fileName"	, fileName);
//		infoMap.put("fileRename", fileRename);
//		infoMap.put("filePath"	, savePath);
//		infoMap.put("fileSize"	, fileLength);
//		return infoMap;
//	}
//    
    // 파일 삭제
    private void deleteFile(HttpServletRequest request, String fileName) {
		String rPath = request.getSession().getServletContext().getRealPath("resources");
		String delFilePath = rPath + "\\nuploadFiles\\" + fileName;
		File delFile = new File(delFilePath);
		if (delFile.exists()) {
			delFile.delete();
		}
		
	}
	
}
