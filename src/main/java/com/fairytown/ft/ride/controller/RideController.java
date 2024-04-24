package com.fairytown.ft.ride.controller;

import java.io.File;
import java.io.IOException;
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
		        @RequestParam(value = "uploadFile", required = false) List<MultipartFile> uploadFile,
		        HttpServletRequest request) {
		    try {
		    	int result = 0;
		    	result += rService.insertRide(ride);
		    	if (uploadFile != null && !uploadFile.isEmpty()) {
		    		int count = 1;
		    		for(MultipartFile file: uploadFile) {
			            Map<String, Object> infoMap = saveMultiFile(file, request, count);
			            rImg.setRideId(ride.getRideId());
			            rImg.setRideImgName((String) infoMap.get("fileName"));
			            rImg.setRideImgRename((String) infoMap.get("fileRename"));
			            rImg.setRideImgFilepath((String) infoMap.get("filePath"));
			            rImg.setRideImgFilelength((long) infoMap.get("fileSize"));
			            result += rService.insertRideImg(rImg);
			            count++;
			        }
		    		if (result > 0) {
		    			mv.setViewName("redirect:/admin/ridelist.ft");
		    		} else {
		    			mv.addObject("msg", "등록이 완료되지 못했습니다.");
		    			mv.setViewName("common/errorPage");
		    		}
		        }
		    } catch (Exception e) {
		        mv.addObject("msg", e.getMessage());
		        mv.setViewName("common/errorPage");
		    }
		    return mv;
		}

		private Map<String, Object> saveMultiFile(MultipartFile uploadFile, HttpServletRequest request, int count) {
		    String fileName = uploadFile.getOriginalFilename();
		    String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/nuploadFiles");
		    File sDir = new File(saveDirectory);
		    if (!sDir.exists()) {
		        sDir.mkdirs();
		    }
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		    String strResult = sdf.format(new Date(System.currentTimeMillis()));
		    String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
		    String fileRename = strResult + "_" + count + "." + ext;
		    String savePath = saveDirectory + File.separator + fileRename;
		    File file = new File(savePath);
		    try {
		        uploadFile.transferTo(file);
		    } catch (IOException e) {
		        e.printStackTrace();
		        // 파일 전송 중 오류 발생 시 null 반환
		        return null;
		    }
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


		@GetMapping("/admin/ridedetail.ft")
		public ModelAndView selectridedetail(ModelAndView mv,
				@RequestParam("rideId") int rideId) {
			try {
				RideVO ride = rService.selectByRideId(rideId);
				List<RimgVO> rImg = rService.selectImgByRideId(rideId);
				ride.setRideId(ride.getRideId());
				if (ride != null) {
					mv.addObject("ride", ride);
					mv.addObject("rImg", rImg);
					mv.setViewName("admin/ridedetail");
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
		public ModelAndView showModifyRide(ModelAndView mv,
				@RequestParam("rideId") int rideId
				) {
	 	 	try {
	 	 		RideVO ride = rService.selectByRideId(rideId);
	 	 		List<RimgVO> rImg = rService.selectRideImgList(rideId);
	 	 		mv.addObject("ride", ride);
	 	 		mv.addObject("rImg", rImg);
	 	 		mv.setViewName("admin/ridemodify");
				
			} catch (Exception e) {
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage") ;
			}
	 	 	return mv;
		}
	 	
	 	
	 	@PostMapping("/admin/ridemodify.ft")
	 	public ModelAndView modifyRide(ModelAndView mv, 
	 	                              @ModelAttribute RideVO ride,
	 	                              @ModelAttribute List<RimgVO> rImg,
	 	                              @RequestParam(value = "reloadFile", required = false) MultipartFile[] reloadFiles, 
	 	                              HttpServletRequest request,
	 	                              @RequestParam("rideId") Integer rideId, int count) {
	 	    try {
	 	        // 파일 수정 로직
	 	        for (int i = 0; i < reloadFiles.length; i++) {
	 	            MultipartFile reloadFile = reloadFiles[i];
	 	            if (reloadFile != null && !reloadFile.isEmpty()) {
	 	                String fileName = rImg.get(i).getRideImgRename();
	 	                if (fileName != null) {
	 	                    this.deleteFile(request, fileName);
	 	                }
	 	                Map<String, Object> infoMap = this.saveMultiFile(reloadFile, request, count);
	 	                String rideFilename = (String) infoMap.get("fileName");
	 	                rImg.get(i).setRideImgName(rideFilename);
	 	                rImg.get(i).setRideImgRename((String) infoMap.get("fileRename"));
	 	                rImg.get(i).setRideImgFilepath((String) infoMap.get("filePath"));
	 	                rImg.get(i).setRideImgFilelength((long) infoMap.get("fileSize"));
	 	            }
	 	        }

	 	        // 데이터베이스 수정 로직
	 	        int result = rService.modifyRide(ride);
	 	        result += rService.modifyRideImg(rImg);
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
	 	
	    // 파일 삭제
	    private void deleteFile(HttpServletRequest request, String fileName) {
			String rPath = request.getSession().getServletContext().getRealPath("resources");
			String delFilePath = rPath + "\\nuploadFiles\\" + fileName;
			File delFile = new File(delFilePath);
			if (delFile.exists()) {
				delFile.delete();
			}
			
		}
	 	
		//		놀이기구 삭제
//		/admin/ridedelete.ft
	 	@GetMapping("/admin/ridedelete.ft")
	    public ModelAndView deleteride(ModelAndView mv, 
	    		@RequestParam("rideId") int rideId) {
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
	 	public ModelAndView showUserRideList(ModelAndView mv,
		        @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage,
		        RideVO ride) {
		    try {
		    	ride.setRideId(ride.getRideId());
		        int totalCount = rService.getTotalCount();
		        PageInfo pi = new PageInfo(currentPage, totalCount, 10);
		        List<RideVO> rlist = rService.selectUserRideList(pi);
		        List<RimgVO> rImg = rService.selectUserRideImg();
		        mv.addObject("rImg", rImg);
		        mv.addObject("rlist", rlist);
		        mv.addObject("pi", pi);
		        mv.addObject("totalCount", totalCount);
		        mv.setViewName("ride/list");
		    } catch (Exception e) {
		        mv.addObject("msg", e.getMessage());
		        mv.setViewName("common/errorPage");
		    }
		    return mv;
		}
	 	
	 	
//      놀이기구 상세
//      ride/detail.ft
       @GetMapping("/ride/detail.ft")
      public ModelAndView selectrideuserdetail(ModelAndView mv,
              @RequestParam("rideId") int rideId) {
          try {
              RideVO rList = rService.selectUserRideByRideId(rideId);
              List<RimgVO> rImg = rService.selectUserImgByRideId(rideId);
                  mv.addObject("rList", rList);
                  mv.addObject("rImg", rImg);
                  mv.setViewName("ride/detail");
          } catch (Exception e) {
              mv.addObject("msg", e.getMessage());
              mv.setViewName("common/errorPage");
          }
          return mv;
      }

       @PostMapping("/ride/detail.ft")
       public String showRideDetailForBooking(@ModelAttribute RideVO ride, HttpSession session) {
           List<RideVO> rideList = new ArrayList<>();
           rideList.add(ride);
           session.setAttribute("rideList", rideList);
           return "redirect:/booking/basic.ft";
       }

	 	
	

	
//	놀이기구 코스짜기
//	course/regist.ft
//	놀이기구 코스짜기 검색
//	course/search.ft
//	나의 코스보기
//	course/mycourse.ft
	
	
	
//		 휴무 등록 페이지 이동
		@GetMapping("/admin/closeregist.ft")
		public String showCloseRegistPage(Model model) {
			List<RideVO> close = rService.selectRideNameForClose();
			model.addAttribute("close",close);
			return "admin/closeregist";
		}

//		휴무 등록
//		admin/closeregist.ft
		@PostMapping("/admin/closeregist.ft")
		public ModelAndView insertclose(ModelAndView mv
				, @ModelAttribute RideVO close
				, HttpSession session
				, HttpServletRequest request
				,  @RequestParam("closeReason") String closeReason
				,  @RequestParam("rideId") int rideId
				 ){
			try {
				close.setRideId(rideId);
				 close.setCloseReason(closeReason);
				int result = rService.insertClose(close);
				if (result > 0) {
					mv.setViewName("redirect:/admin/closedetail.ft?rideId=" + close.getRideId());
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
		public ModelAndView showCloseDetail(ModelAndView mv, 
				@RequestParam("rideId") int rideId) {
			RideVO close = rService.selectByRideId(rideId);
	 		mv.addObject("close", close);
			return mv;
		}
		
		
		@PostMapping("/admin/closedetail.ft")
		public ModelAndView selectCloseDetail(ModelAndView mv,
				@RequestParam("rideId") int rideId) {
			try {
				RideVO close = rService.selectByRideId(rideId);
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
	            @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage
	            ) {
			try {
				int totalCount = rService.getCloseTotalCount();
				PageInfo pi = new PageInfo(currentPage, totalCount, 10);
				List<RideVO> cList = rService.selectCloseList(pi);
				mv.addObject("cList", cList);
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
	 	@GetMapping("/admin/closemodify.ft")
		public String showModifyClose(Model model,
	 		@RequestParam("rideId") int rideId) {
	 	 		RideVO close = rService.selectByRideId(rideId);
	 	 		model.addAttribute("close", close);
	 			return "admin/closemodify";
		}
	 	
	 	 @PostMapping("/admin/closemodify.ft")
	     public ModelAndView modifyClose(ModelAndView mv, 
	    		 @ModelAttribute RideVO close,
	    		 @RequestParam("rideId") int rideId) {
	 		try {
	 			int result = rService.modifyclose(close);
	 			if (result > 0) {
	 				mv.setViewName("redirect:/admin/closedetail.ft?rideId=" + close.getRideId());
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
	    public ModelAndView deleteclose(ModelAndView mv,
	    		@RequestParam("rideId") int rideId) {
			try {
				int result = rService.deleteclose(rideId);
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
	 	

	
}
