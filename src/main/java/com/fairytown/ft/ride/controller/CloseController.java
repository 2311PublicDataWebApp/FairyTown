//package com.fairytown.ft.ride.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.fairytown.ft.ride.domain.vo.RideVO;
//import com.fairytown.ft.ride.service.RideService;
//
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpSession;
//import lombok.RequiredArgsConstructor;
//
//@Controller
//@RequiredArgsConstructor
//public class CloseController {
//
//	@Autowired
//	private RideService rService;
//
////	휴무 페이지로 이동
//// admin/closeregist.ft
//	@GetMapping("/admin/closeregist.ft")
//	public String showCloseRegistPage() {
//		return "admin/closeregist";
//	}
//
////		휴무 등록
//// admin/closeregist.ft
//	@PostMapping("/admin/closeregist.ft")
//	public ModelAndView insertClose(ModelAndView mv, @ModelAttribute RideVO close, HttpServletRequest request,
//			HttpSession session) {
//		try {
////		int closeNo = (int) session.getAttribute("closeNo");
//			close.setCloseNo(1);
////
//			int result = rService.insertClose(close);
//			if (result > 0) {
//				mv.setViewName("redirect:/admin/closelist.ft");
//			} else {
//				mv.addObject("msg", "등록이 완료되지 못했습니다.");
//				mv.setViewName("common/errorPage");
//			}
//		} catch (Exception e) {
//			mv.addObject("msg", e.getMessage());
//			mv.setViewName("common/errorPage");
//		}
//		return mv;
//
//	}
//
////	@GetMapping("/admin/closelist.ft")
////	public String showCloselist() {
////		return "admin/closelist";
////		
////	}
////	휴무 상세
////	admin/closesearch.ft
//
////	휴무 목록
////  admin/closedetail.ft
//
////	휴무 검색
////	admin/closeregist.ft
//
////	휴무 수정/삭제
////	admin/closemodify.ft
////  admin/closedelete.ft
//
//}
