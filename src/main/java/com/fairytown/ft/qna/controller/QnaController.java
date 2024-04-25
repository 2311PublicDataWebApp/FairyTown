package com.fairytown.ft.qna.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.goods.domain.vo.GoodsVO;
import com.fairytown.ft.qna.domain.vo.QnaVO;
import com.fairytown.ft.qna.service.QnaService;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class QnaController {
	@Autowired
	private QnaService qService;
	
	@GetMapping("/qna/adminList.ft")
    public ModelAndView ShowAdminQnaList(ModelAndView mv,
            @RequestParam(value="page", 
            required=false, defaultValue="1") Integer currentPage) {
		try {
			int totalCount = qService.getTotalCount();
			PageInfo pInfo = this.getPageInfo(currentPage, totalCount);
			List<QnaVO> qList = qService.selectQnaList(pInfo);
			mv.addObject("qList", qList);
			mv.addObject("pInfo", pInfo);
			mv.setViewName("admin/qnaadmin");
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
	
	// 문의 작성 페이지
	@GetMapping("/qna/insert.ft")
	public String showInsertForm() {
		return "qna/register";
	}
	
	// 문의 작성
	@PostMapping("/qna/insert.ft")
	public ModelAndView insertqna(ModelAndView mv
			, @ModelAttribute QnaVO qna
			, HttpSession session
			, HttpServletRequest request) {
		try {
			// 게시물을 추가하기 전에 상태를 "처리 중"으로 설정합니다.
	        qna.setQnaStatus("처리 중");
			int result = qService.insertQna(qna);
			if (result > 0) {
				mv.setViewName("redirect:/qna/list.ft");
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
	

 	// 문의 상세보기
    @GetMapping("/qna/detail.ft")
    public ModelAndView showQnaDetail(ModelAndView mv, @RequestParam("qnaNo") int qnaNo) {
		try {
			QnaVO qna = qService.selectByQnaNo(qnaNo);
			if (qna != null) {
				mv.addObject("qna", qna).setViewName("admin/qnaadmindetail");
			} else {
				mv.addObject("msg", "데이터 불러오기가 실패.");
				mv.setViewName("common/errorPage");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
    

 	// 공지사항 수정 페이지 이동
    @GetMapping("/qna/modify.ft")
    public ModelAndView showModifyForm(ModelAndView mv, 
    		@RequestParam("qnaNo") Integer qnaNo) {
		try {
			QnaVO qna = qService.selectByQnaNo(qnaNo);
			if (qna != null) {
				mv.addObject("qna", qna);
				mv.setViewName("qna/modify");
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
    

 	// 공지사항 수정
    @PostMapping("/qna/modify.ft")
    public ModelAndView updateQna(ModelAndView mv, 
    		@ModelAttribute QnaVO qna, 
    		@RequestParam("qnaNo") Integer qnaNo) {
		try {
			
			int result = qService.updateQna(qna);
			if (result > 0) {
				mv.setViewName("redirect:/qna/detail.ft?qnaNo=" + qna.getQnaNo());
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
    
 	// 문의 삭제
    @GetMapping("/qna/delete.ft")
    public ModelAndView deleteQna(ModelAndView mv, @RequestParam("qnaNo") Integer qnaNo) {
		try {
			int result = qService.deleteQna(qnaNo);
			if (result > 0) {
				mv.setViewName("redirect:/qna/list.ft");
			} else {
				mv.addObject("msg", "데이터가 존재하지 않습니다.").setViewName("common/errorPage");
			}
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage()).setViewName("common/errorPage");
		}
		return mv;
	}
	
	
	// 문의 리스트
	@GetMapping("/qna/list.ft")
    public ModelAndView ShowQnaList(ModelAndView mv,
            @RequestParam(value="page", 
            required=false, defaultValue="1") Integer currentPage) {
		try {
			int totalCount = qService.getTotalCount();
			PageInfo pInfo = this.getPageInfo(currentPage, totalCount);
			List<QnaVO> qList = qService.selectQnaList(pInfo);
			mv.addObject("qList", qList);
			mv.addObject("pInfo", pInfo);
			mv.setViewName("qna/qnalist");
		} catch (Exception e) {
			// TODO: handle exception
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/errorPage");
		}
		return mv;
    };
    
    
    

 	// 페이징 처리
    private PageInfo getPageInfo(Integer currentPage, int totalCount) {
		PageInfo pi = null;
		int boardLimit = 10; // 한 페이지당 보여줄 게시물의 갯수
		
		pi = new PageInfo(currentPage, totalCount, boardLimit);
		return pi;
	}
    
    
    
    

}

