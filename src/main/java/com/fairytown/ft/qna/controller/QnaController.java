package com.fairytown.ft.qna.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fairytown.ft.qna.domain.vo.QnaVO;
import com.fairytown.ft.qna.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService qService;
	
	// 게시물 등록 페이지
		@RequestMapping(value = "/qna/insert.ft", method = RequestMethod.GET)
		public String ShowRegisterForm(Model model) {
			return "qna/register";
		}

		// 게시물 등록
		@RequestMapping(value = "/qna/insert.ft", method = RequestMethod.POST)
		public String insertQna(@ModelAttribute QnaVO qna
		        , Model model
		        , HttpServletRequest request
		        , HttpSession session) {
		    try {
		        String qaWriter = null;
		        qaWriter = (String) session.getAttribute("memberId");
		        if (session != null && qaWriter != null && !"".equals(qaWriter)) {
		            qna.setQaWriter(qaWriter);
		        } else {
		            model.addAttribute("msg", "로그인이 필요합니다.");
		            return "common/errorPage";
		        }
		        int result = qService.insertQna(qna);
		        if (result > 0) {
		            return "redirect:/qna/list.ft";
		        } else {
		            model.addAttribute("msg", "게시물 등록이 완료되지 못했습니다.");
		            return "common/errorPage";
		        }
		    } catch (Exception e) {
		        model.addAttribute("msg", e.getMessage());
		        return "common/errorPage";
		    }
		}
}
