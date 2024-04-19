package com.fairytown.ft.qna.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fairytown.ft.qna.domain.vo.QnaReplyVO;
import com.fairytown.ft.qna.service.QnaReplyService;
import com.fairytown.ft.user.domain.vo.UserVO;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpSession;

@Controller
public class QnaReplyController {
	
	@Autowired
	private QnaReplyService qService;
	
	
	// 댓글 등록 POST
	@ResponseBody
	@RequestMapping(value = "/qreply/add.ft", method = RequestMethod.POST)
	public String insertQnaReply(@ModelAttribute QnaReplyVO reply
			, HttpSession session) {
		try {
			int result = 0;
			UserVO uOne = (UserVO) session.getAttribute("user");
            String qnaReplyWriter = uOne.getUserId();
			if (qnaReplyWriter != null) {
				reply.setQnaReplyWriter(qnaReplyWriter);
				result = qService.insertQnaReply(reply);				
			} else {
				return "Login needed";
			}
			if (result > 0) {
				return "success";
			} else {
				return "failed";
			}
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	
	// 댓글 수정 POST
	@ResponseBody
	@RequestMapping(value = "/qreply/modify.ft", method = RequestMethod.POST)
	public String updateQnaReply(@ModelAttribute QnaReplyVO reply) {
		try {
			int result = qService.updateQnaReply(reply);
			if (result > 0) {
				return "success";
			} else {
				return "failed";
			}
		} catch (Exception e) {
			return e.getMessage();
		}
		
	}
	
	// 댓글 삭제 POST
	@ResponseBody
	@RequestMapping(value = "/qreply/remove.ft", method = RequestMethod.POST)
	public String removeQReplyAjax(@RequestParam("qnaReplyNo") Integer qnaReplyNo) {
		try {
			int result = qService.removeQnaReply(qnaReplyNo);
			if (result > 0) {
				return "success";
			} else {
				return "failed";
			}
		} catch (Exception e) {
			return e.getMessage();
		}
		
	}
	
	// 댓글 리스트를 가져오는 API
	@ResponseBody
	@RequestMapping(value = "/qreply/list.ft"
			, produces = "application/json;charset=utf-8"
			, method = RequestMethod.GET)
	public String showQReplyList(@RequestParam("refQnaNo") Integer refQnaNo) {
		List<QnaReplyVO> rList = qService.selectQnaReplyList(refQnaNo);
		
		Gson gson = new Gson();
		return gson.toJson(rList);
	}

}
