package com.fairytown.ft.notice.controller;

import java.util.List;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fairytown.ft.notice.domain.vo.NoticeReplyVO;
import com.fairytown.ft.notice.service.NoticeReplyService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpSession;


@Controller
public class NoticeReplyController {

    @Autowired
    private NoticeReplyService rService;
    
    // 댓글 입력
    @ResponseBody
    @RequestMapping(value="/notice/reply/add.ft", method=RequestMethod.POST)
    public String insertReplyAjax(@ModelAttribute NoticeReplyVO reply
    		, HttpSession session) {
    	try {
			String replyWriter = (String)session.getAttribute("userId");
			int result = 0;
			if (replyWriter != null && !replyWriter.equals("")) {
				reply.setReplyWriter(replyWriter);
				result = rService.insertReply(reply);
			} else {
				return "로그인이 필요합니다.";
			}
			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			// TODO: handle exception
			return e.getMessage();
		}
    }
    
    // 댓글 삭제
    @ResponseBody
    @RequestMapping(value="/notice/reply/delete.ft", method=RequestMethod.POST)
    public String deleteReply(Integer replyNo) {
    	try {
			int result = rService.deleteReply(replyNo);
			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			// TODO: handle exception
			return e.getMessage();
		}
    }
    
    // 댓글 수정
    @ResponseBody
    @RequestMapping(value="/notice/reply/update.ft", method=RequestMethod.POST)
    public String updateReply(@ModelAttribute NoticeReplyVO reply) {
    	try {
			int result = rService.updateReply(reply);
			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			// TODO: handle exception
			return e.getMessage();
		}
    }
    
    // 댓글 목록
    @ResponseBody
    @RequestMapping(value="/notice/reply/list.ft"
    		, produces="application/json;charset=utf-8"
    		, method=RequestMethod.GET)
    public String showReplyList(@RequestParam("refNoticeNo") Integer refNoticeNo) {
    	List<NoticeReplyVO> rList = rService.selectReplyList(refNoticeNo);
    	Gson gson = new Gson();
    	return gson.toJson(rList);

    }
}
