package com.fairytown.ft.goods.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
		
		// ck 에디터에서 파일 업로드
		@RequestMapping(value = "/goods/ckUpload", method = RequestMethod.POST)
		public void postCKEditorImgUpload(HttpServletRequest req,
		          HttpServletResponse res,
		          @RequestParam(value = "upload", required = false) MultipartFile upload) throws Exception {
		 
		JsonObject jsonObject = new JsonObject();
		 // 랜덤 문자 생성
		 UUID uid = UUID.randomUUID();
		 
		 OutputStream out = null;
		 PrintWriter printWriter = null;
		   
		 // 인코딩
		 res.setCharacterEncoding("utf-8");
		 res.setContentType("text/html;charset=utf-8");
		 
		 try {
		  
		  String fileName = upload.getOriginalFilename();  // 파일 이름 가져오기
		  byte[] bytes = upload.getBytes();
		  
		  // 업로드 경로
		  // String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uid + "_" + fileName;
		  String projectPath 	 = req.getSession().getServletContext().getRealPath("resources");
		  String saveDirectory = projectPath + "\\ckUpload" + "\\" + uid + "_" + fileName;
		  
		  out = new FileOutputStream(new File(saveDirectory));
		  out.write(bytes);
		  out.flush();  // out에 저장된 데이터를 전송하고 초기화
		  
		  String callback = req.getParameter("CKEditorFuncNum");
		  printWriter = res.getWriter();
		  // String fileUrl = "/ckUpload/" + uid + "_" + fileName;  // 작성화면
		  String fileUrl = "/resources/ckUpload/" + uid + "_" + fileName;
		  
		  
		  // 업로드시 메시지 출력
//		  printWriter.println("<script type='text/javascript'>"
//		     + "window.parent.CKEDITOR.tools.callFunction("
//		     + callback+",'"+ fileUrl+"','이미지를 업로드하였습니다.')"
//		     +"</script>");
		  // printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
		  JsonObject json = new JsonObject();
          json.addProperty("uploaded", 1);
          json.addProperty("fileName", fileName);
          json.addProperty("url", fileUrl);
          printWriter.print(json);
          System.out.println(json);
		  printWriter.flush();
		  
		 } catch (IOException e) { e.printStackTrace();
		 } finally {
		  try {
		   if(out != null) { out.close(); }
		   if(printWriter != null) { printWriter.close(); }
		  } catch(IOException e) { e.printStackTrace(); }
		 }
		 
		 return; 
		}
		
	

		// 굿즈 목록
		@GetMapping("/goods/list.ft")
	    public ModelAndView ShowGoodsList(ModelAndView mv,
	            @RequestParam(value="page", 
	            required=false, defaultValue="1") Integer currentPage) {
			try {
				int totalCount = gService.getTotalCount();
				PageInfo pInfo = this.getPageInfo(currentPage, totalCount);
				List<GoodsVO> gList = gService.selectGoodsList(pInfo);
				mv.addObject("gList", gList);
				mv.addObject("pi", pInfo);
				mv.setViewName("goods/list");
			} catch (Exception e) {
				// TODO: handle exception
				mv.addObject("msg", e.getMessage());
				mv.setViewName("common/errorPage");
			}
			return mv;
	    };
		
	    // 공지사항 검색
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
	 	
	 	// 공지 상세조회
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
	 	
	 	// 공지 수정 페이지 이동
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
	    
	 	// 공지 수정
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
	 	
	 	// 공지 삭제
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
