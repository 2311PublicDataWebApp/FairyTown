package com.fairytown.ft.goods.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;

//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.goods.service.GoodsService;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class GoodsController {
		
	
		@Autowired
		private GoodsService gService;
	
		// 굿즈 등록 페이지 이동
		@GetMapping("/goods/insert.ft")
		public String showWriteForm() {
			return "goods/regist";
		}
		
		// 굿즈 등록
		@PostMapping("/goods/insert.ft")
		public ModelAndView insertGoods(ModelAndView mv
				, @ModelAttribute GoodsVO goods
				, @RequestParam("goodsStock") int goodsStock
				, HttpSession session
				, @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile
				, HttpServletRequest request) {
			goods.setGoodsStock(goodsStock);
			try {
				if (uploadFile != null && !uploadFile.getOriginalFilename().equals("")) {
					Map<String, Object> infoMap = this.saveFile(uploadFile, request);
					String fileName 	= (String) infoMap.get("fileName");
					String fileRename 	= (String) infoMap.get("fileRename");
					String filePath 	= (String) infoMap.get("filePath");
					long fileLength 	= (long) infoMap.get("fileSize");
					
					goods.setGoodsFilename(fileName);
					goods.setGoodsFileRename(fileRename);
					goods.setGoodsFilePath(filePath);
					goods.setGoodsFileLength(fileLength);
				}
				int result = gService.insertGoods(goods);
				if (result > 0) {
					mv.setViewName("redirect:/goods/list.ft");
				} else {
					mv.addObject("msg", "공지사항 등록이 완료되지 못했습니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				// TODO: handle exception
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
		}
		
		@ResponseBody
		@RequestMapping(value = "/goods/ckUpload", method = {RequestMethod.POST, RequestMethod.GET})
		public String fileUpload(Model model,  
		        @RequestParam(value="upload", required = false) MultipartFile fileload,
		        HttpServletRequest req) {
			
		    String filename = fileload.getOriginalFilename();
		    UUID uid = UUID.randomUUID();
		    
		    String projectPath 	 = req.getSession().getServletContext().getRealPath("resources");
			String saveDirectory = projectPath + "\\ckUpload" + "\\" + uid + "_" + filename;
		    
   
		    File file = new File(saveDirectory);
		    
		    try {
		        FileUtils.writeByteArrayToFile(file, fileload.getBytes() );	        
		        return "{ \"uploaded\" : true, \"url\" : \"/resources/ckUpload/" + uid + "_" + filename + "\" }";
		    } catch (IOException e) {
		    	return "업로드 실패";
		    }
		}
		
	

		// 굿즈 목록
		@GetMapping("/goods/list.ft")
	    public ModelAndView ShowGoodsList(ModelAndView mv,
	            @RequestParam(value="page", 
	            required=false, defaultValue="1") Integer currentPage) {
			try {
				int totalCount = gService.getTotalCount();
				PageInfo pi = this.getPageInfo(currentPage, totalCount);
				List<GoodsVO> gList = gService.selectGoodsList(pi);
				mv.addObject("gList", gList);
				mv.addObject("pi", pi);
				mv.setViewName("goods/list");
			} catch (Exception e) {
				// TODO: handle exception
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
	    };
		
	    // 굿즈 검색
	 	@GetMapping(value="/goods/search.ft")
	 	public ModelAndView searchGoodsList(ModelAndView mv
	 			, @RequestParam("searchCondition") String searchCondition
	 			, @RequestParam("searchKeyword") String searchKeyword
	 			, @RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
	 		
	 		Map<String, String> paramMap = new HashMap<String, String>();
	 		paramMap.put("searchCondition", searchCondition);
	 		paramMap.put("searchKeyword", searchKeyword);
	 		int totalCount = gService.getTotalCount(paramMap);
	 		PageInfo pi = this.getPageInfo(currentPage, totalCount);
	 		List<GoodsVO> searchList = gService.searchGoodsByKeyword(pi, paramMap);
	 		mv.addObject("sList", searchList);
	 		mv.addObject("pi", pi);
	 		mv.addObject("searchCondition", searchCondition);
	 		mv.addObject("searchKeyword", searchKeyword);
	 		mv.setViewName("goods/search");
	 		return mv;
	 	}
	 	
	 	// 굿즈 상세조회
	    @GetMapping("/goods/detail.ft")
	    public ModelAndView showGoodsDetail(ModelAndView mv
	    		, @RequestParam("goodsCode") Integer goodsCode) {
			try {
				GoodsVO goods = gService.selectByGoodsCode(goodsCode);
				if (goods != null) {
					mv.addObject("goods", goods).setViewName("goods/detail");
				} else {
					mv.addObject("msg", "데이터 불러오기가 완료되지 못했습니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				// TODO: handle exception
				mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
			}
			return mv;
		}
	 	
	 	// 굿즈 수정 페이지 이동
	    @GetMapping("/goods/modify.ft")
	    public ModelAndView showModifyForm(ModelAndView mv, @RequestParam("goodsCode") Integer goodsCode) {
			try {
				GoodsVO goods = gService.selectByGoodsCode(goodsCode);
				if (goods != null) {
					mv.addObject("goods", goods);
					mv.setViewName("goods/modify");
				} else {
					mv.addObject("msg", "데이터 불러오기가 완료되지 못했습니다.");
					mv.setViewName("common/errorPage");
				}
			} catch (Exception e) {
				// TODO: handle exception
				mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
			}
			return mv;
		}
	    
	 	// 굿즈 수정
	 	@PostMapping("/goods/modify.ft")
	    public ModelAndView updateGoods(ModelAndView mv, @ModelAttribute GoodsVO goods, @RequestParam("goodsStock") int goodsStock, @RequestParam("goodsCode") Integer goodsCode, 
	 			@RequestParam(value = "reloadFile", required = false) MultipartFile reloadFile, HttpServletRequest request) {
	 		try {
	 			goods.setGoodsStock(goodsStock);
	 			if (reloadFile != null && !reloadFile.isEmpty()) {
	 				String fileName = goods.getGoodsFileRename();
	 				if (fileName != null) {
	 					// 있으면 파일 삭제
	 					this.deleteFile(request, fileName);
	 				}
	 				// 없으면 새로 업로드하려는 파일 저장
	 				Map<String, Object> infoMap = this.saveFile(reloadFile, request);
	 				String goodsFilename = (String) infoMap.get("fileName");
	 				goods.setGoodsFilename(goodsFilename);
	 				goods.setGoodsFileRename((String) infoMap.get("fileRename"));
	 				goods.setGoodsFilePath((String) infoMap.get("filePath"));
	 				goods.setGoodsFileLength((long) infoMap.get("fileSize"));
	 			}
	 			int result = gService.updateGoods(goods);
	 			if (result > 0) {
	 				mv.setViewName("redirect:/goods/detail.ft?goodsCode=" + goodsCode);
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
	 	
	 	// 굿즈 삭제
	    @GetMapping("/goods/delete.ft")
	    public ModelAndView deleteGoods(ModelAndView mv, @RequestParam("goodsCode") Integer goodsCode) {
	 		try {
	 			int result = gService.deleteGoods(goodsCode);
	 			if (result > 0) {
	 				mv.setViewName("redirect:/goods/list.ft");
	 			} else {
	 				mv.addObject("msg", "데이터가 존재하지 않습니다.").setViewName("common/errorPage");
	 			}
	 		} catch (Exception e) {
	 			// TODO: handle exception
	 			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
	 		}
	 		return mv;
	 	}
	    
	    // 굿즈 정렬
	    @ResponseBody
	    @GetMapping(value="/goods/sortList.ft")
	    public Object sortGoods(
	            @RequestParam(value="page", 
	            required=false, defaultValue="1") Integer currentPage
	            , @RequestParam("sortType") String sortType) {
	    	try {
				int totalCount = gService.getTotalCount();
				PageInfo pi = this.getPageInfo(currentPage, totalCount);
				List<GoodsVO> sortList = gService.selectGoodsList(pi, sortType);
				return sortList;
			} catch (Exception e) {
				// TODO: handle exception
				return e.getMessage();
			}
	    }
	    
	    // 굿즈 검색 정렬
	    @ResponseBody
	    @GetMapping(value="/goods/sortSearchList.ft")
	    public Object sortSearchGoods(
	            @RequestParam(value="page", 
	            required=false, defaultValue="1") Integer currentPage
	            , @RequestParam("searchCondition") String searchCondition
	 			, @RequestParam("searchKeyword") String searchKeyword
	            , @RequestParam("sortType") String sortType) {
	    	try {
	    		Map<String, String> paramMap = new HashMap<String, String>();
		 		paramMap.put("searchCondition", searchCondition);
		 		paramMap.put("searchKeyword", searchKeyword);
		 		paramMap.put("sortType", sortType);
		 		int totalCount = gService.getTotalCount(paramMap);
		 		PageInfo pi = this.getPageInfo(currentPage, totalCount);
		 		List<GoodsVO> sortSearchList = gService.sortSearchGoodsByKeyword(pi, paramMap);
				return sortSearchList;
			} catch (Exception e) {
				// TODO: handle exception
				return e.getMessage();
			}
	    }
	    
		// 파일 저장
	    private Map<String, Object> saveFile(MultipartFile uploadFile, HttpServletRequest request) throws Exception {
			// 파일 이름
			String fileName = uploadFile.getOriginalFilename();
			// 저장 경로
			String projectPath 	 = request.getSession().getServletContext().getRealPath("resources");
			String saveDirectory = projectPath + "\\guploadFiles";
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
			// TODO Auto-generated method stub
			String rPath = request.getSession().getServletContext().getRealPath("resources");
			String delFilePath = rPath + "\\guploadFiles\\" + fileName;
			File delFile = new File(delFilePath);
			if (delFile.exists()) {
				delFile.delete();
			}
		}
	    
	    // 페이징
	    private PageInfo getPageInfo(Integer currentPage, int totalCount) {
			PageInfo pi = null;
			int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
			
			pi = new PageInfo(currentPage, totalCount, boardLimit);
			return pi;
		}
}
