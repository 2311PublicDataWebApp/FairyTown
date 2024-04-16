package com.fairytown.ft.ticket.controller;

import java.io.File;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ticket.domain.vo.TicketVO;
import com.fairytown.ft.ticket.service.TicketService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class TicketController {

	@Autowired
	private TicketService tService;
	
	
// --------- [어드민] ---------

// 티켓 등록 페이지 이동
	@GetMapping("/admin/ticketregist.ft")
	public String showRegistPage() {
		return "admin/ticketregist";
	}

	
//	티켓 등록
//	admin/ticketregist.ft
	@PostMapping("/admin/ticketregist.ft")
	public ModelAndView insertTicket(ModelAndView mv
			, @ModelAttribute TicketVO ticket
			, HttpSession session
			, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile
			, HttpServletRequest request) {
		try {
			String ticketNo = (String)session.getAttribute("ticketNo");
			ticket.setTicketNo(ticketNo);
			
			if (uploadFile != null && !uploadFile.getOriginalFilename().equals("")) {
				Map<String, Object> infoMap = this.saveFile(uploadFile, request);
				String fileName 	= (String) infoMap.get("fileName");
				String fileRename 	= (String) infoMap.get("fileRename");
				String filePath 	= (String) infoMap.get("filePath");
				long fileLength 	= (long) infoMap.get("fileSize");
				
				ticket.setTicketImgName(fileName);
				ticket.setTicketImgRename(fileRename);
				ticket.setTicketImgFilepath(filePath);
				ticket.setTicketImgFilelength(fileLength);
			}
			
			int result = tService.insertTicket(ticket);
			if (result > 0) {
				mv.setViewName("redirect:/admin/ticketlist.ft");
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
	
	
//	티켓 상세
//	admin/ticketdetail.ft
//	@GetMapping("/admin/ticketdetail.ft")
//	public String showTdetailPage() {
//		return "admin/ticketdetail";
//	}

	@GetMapping("/admin/ticketdetail.ft")
	public ModelAndView selectTicketdetail(ModelAndView mv,
			@RequestParam("ticketNo") int ticketNo) {
		try {
			TicketVO ticket = tService.selectByTicketNo(ticketNo);
			if (ticket != null) {
				mv.addObject("ticket", ticket);
				mv.setViewName("admin/ticketdetail");
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
   
    
	
//	티켓 목록
//	admin/ticketlist.ft
	@GetMapping("/admin/ticketlist.ft")
    public ModelAndView ShowTicketList(ModelAndView mv,
            @RequestParam(value="page", 
            required=false, defaultValue="1") Integer currentPage) {
		try {
			int totalCount = tService.getTotalCount();
			PageInfo pi = new PageInfo(currentPage, totalCount, 10);
			List<TicketVO> tList = tService.selectTicketList(pi);
			mv.addObject("tList", tList);
			mv.addObject("pi", pi);
			mv.setViewName("admin/ticketlist");
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
	
//	티켓 검색
//	admin/ticketsearch.ft
 	@PostMapping(value="/admin/ticketsearch.ft")
 	public ModelAndView showTicketSearch(ModelAndView mv
 			, @RequestParam("searchCondition") String searchCondition
 			, @RequestParam("searchKeyword") String searchKeyword
 			, @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
 		
 		Map<String, String> paramMap = new HashMap<String, String>();
 		paramMap.put("searchCondition", searchCondition);
 		paramMap.put("searchKeyword", searchKeyword);
 		int totalCount = tService.getTotalCount(paramMap);
 		PageInfo pi = new PageInfo(currentPage, totalCount, 10);
 		List<TicketVO> sList = tService.selectTicketByKeyword(pi, paramMap);
 		mv.addObject("sList", sList);
 		mv.addObject("pi", pi);
 		mv.addObject("searchCondition", searchCondition);
 		mv.addObject("searchKeyword", searchKeyword);
 		mv.setViewName("admin/ticketsearch");
 		return mv;
 	}
	
//	티켓 수정
//	admin/ticketmodify.ft
 	@GetMapping("/admin/ticketmodify.ft")
	public String showModifyPage(Model model,
 		@RequestParam("ticketNo") int ticketNo) {
 		TicketVO ticket = tService.selectByTicketNo(ticketNo);
 		model.addAttribute("ticket", ticket);
		return "admin/ticketmodify";
	}
 	
 	@PostMapping("/admin/ticketmodify.ft")
     public ModelAndView modifyTicket(ModelAndView mv, 
    		@ModelAttribute TicketVO ticket,
 			@RequestParam(value = "reloadFile", required = false) MultipartFile reloadFile, 
 			HttpServletRequest request,
 			@RequestParam("ticketNo") int ticketNo) {
 		try {
 			if (reloadFile != null && !reloadFile.isEmpty()) {
 				String fileName = ticket.getTicketImgRename();
 				if (fileName != null) {
 					this.deleteFile(request, fileName);
 				}
 				Map<String, Object> infoMap = this.saveFile(reloadFile, request);
 				String ticketFilename = (String) infoMap.get("fileName"); 
 				ticket.setTicketImgName(ticketFilename);
 				ticket.setTicketImgRename((String) infoMap.get("fileRename"));
 				ticket.setTicketImgFilepath((String) infoMap.get("filePath"));
 				ticket.setTicketImgFilelength((long) infoMap.get("fileSize"));
 			}
 			int result = tService.modifyTicket(ticket);
 			if (result > 0) {
 				mv.setViewName("redirect:/admin/ticketdetail.ft?ticketNo=" + ticket.getTicketNo());
 			} else {
 				mv.addObject("msg", "데이터가 존재하지 않습니다.");
 				mv.setViewName("common/errorPage");	
 			}
 		} catch (Exception e) {
 			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
 		}
 		return mv;
 	}
 	 
 	 
 	 
//	티켓 삭제
//	admin/ticketdelete.ft
 	@GetMapping("/admin/ticketdelete.ft")
    public ModelAndView deleteTicket(ModelAndView mv,
    		@RequestParam("ticketNo") int ticketNo) {
		try {
			int result = tService.deleteTicket(ticketNo);
			if (result > 0) {
				mv.setViewName("redirect:/admin/ticketlist.ft");
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
//	티켓 목록
//	ticket/list.ft
 	
 	@GetMapping("ticket/list.ft")
    public ModelAndView showTicketlist(ModelAndView mv,
            @RequestParam(value="page", 
            required=false, defaultValue="1") Integer currentPage
            ) {
		try {
			int totalCount = tService.getTotalCount();
			PageInfo pi = new PageInfo(currentPage, totalCount, 10);
			List<TicketVO> tList = tService.selectTicketList(pi);
			mv.addObject("tList", tList);
			mv.addObject("pi", pi);
			mv.setViewName("ticket/list");
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
	
 	
 	
//	티켓 상세
//	ticket/detail.ft

	@GetMapping("ticket/detail.ft")
	public ModelAndView showTicketdetail(ModelAndView mv,
			@RequestParam("ticketNo") int ticketNo) {
		try {
			TicketVO ticket = tService.selectByTicketNo(ticketNo);
			if (ticket != null) {
				mv.addObject("ticket", ticket);
				mv.setViewName("ticket/detail");
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
 	
 	
 	
//	-----------------------------------------기타 필요 코드

    
    // 파일 저장
    private Map<String, Object> saveFile(MultipartFile uploadFile, HttpServletRequest request) throws Exception {
		String fileName = uploadFile.getOriginalFilename();
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
