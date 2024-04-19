package com.fairytown.ft.booking.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fairytown.ft.booking.domain.vo.BookingVO;
import com.fairytown.ft.booking.service.BookingService;
import com.fairytown.ft.common.PageInfo;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BookingController {
	
	@Autowired
	private BookingService bService;
	
	@Autowired
	private UserService uService;
	
	// 기본예약 뷰 
	@GetMapping("/booking/basic.ft")
	public String bookingBasicView(Model model, HttpSession session, HttpServletRequest request) {
		// 페이지 진입시 로그인이 되어있어야 합니다.
		try {
			session = request.getSession();
			UserVO uOne = (UserVO) session.getAttribute("user");
			UserVO user = uService.selectUser(uOne.getUserId());
			
			TicketingVO tingOne = (TicketingVO) session.getAttribute("tingOne");
			model.addAttribute("tingOne", tingOne);
			// rideVO값을 가져와 세션에 저장하도록 변경해야함
			List<RideVO> rideList = new ArrayList<>();
//			rideList.add(new RideVO(1, "아트란티스", "설명충", 8, null, null, null, null, null, null, null, null, 1));
//			rideList.add(new RideVO(2, "자이로드롭", "설명충", 8, null, null, null, null, null, null, null, null, 2));
//			rideList.add(new RideVO(3, "자이로드롭", "설명충", 8, null, null, null, null, null, null, null, null, 3));
			model.addAttribute("user", user);
			model.addAttribute("rideList", rideList);
			session.setAttribute("rideList", rideList);
			return "booking/basic";
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
	// 예약하기 개별 삭제
	@SuppressWarnings("unchecked")
	@PostMapping("/booking/basic/delete.ft")
	public String bookingDelete(Model model, @RequestParam("rideId") int rideId, HttpSession session) {
		List<RideVO> rideList = (List<RideVO>) session.getAttribute("rideList");
	    // rideId와 일치하는 RideVO 객체를 찾아 제거합니다.
	    Iterator<RideVO> iterator = rideList.iterator();
	    while (iterator.hasNext()) {
	        RideVO ride = iterator.next();
	        if (ride.getRideId() == (rideId)) {
	            iterator.remove();
	            break;
	        }
	    }
		model.addAttribute("rideList", rideList);
		return "booking/basic";
	}
	// 예약하기 전체 삭제
	@SuppressWarnings("unchecked")
	@PostMapping("/booking/basic/deleteAll.ft")
	public String bookingDelete(Model model, HttpSession session) {
		List<RideVO> rideList = (List<RideVO>) session.getAttribute("rideList");
	    // RideVO 객체를 초기화 합니다.
		rideList.clear();
		model.addAttribute("rideList", rideList);
		return "booking/basic";
	}
	// 기본예약 예약
	@SuppressWarnings("unchecked")
	@PostMapping("/booking/basic.ft")
	public String bookingBasic(Model model, HttpSession session) {
		try {
			List<RideVO> rideList = (List<RideVO>) session.getAttribute("rideList");
			List<BookingVO> bookingList = new ArrayList<>();
			
			bookingList.add(new BookingVO(0, null, null, 0, null, null, 0, null));

			int result = bService.bookingBasic(rideList);
			if(result > 0) {
				return "booking/basic";
			}else {
				return "common/errorPage";
			}		
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
	// 개별예약 뷰  
	@GetMapping("/booking/single.ft")
	public String bookingSingleView() {
		return "booking/single";
	}
	// 개별예약
	@PostMapping("/booking/single.ft")
	public String bookingSingle() {
		return "booking/single";
	}
	// 예약조회 뷰 
	@GetMapping("/booking/list.ft")
	public String bookingListView(Model model, HttpServletRequest request,
			@RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
		// 페이지 진입시 로그인이 되어있어야 합니다
		try {
			HttpSession session = request.getSession();
			UserVO uOne = (UserVO) session.getAttribute("user");
			UserVO user = uService.selectUser(uOne.getUserId());
			List<BookingVO> bList = bService.BookingListSelect(user);
			int totalCount = bList.size();
			PageInfo pInfo = this.getPageInfo(currentPage, totalCount);
			List<BookingVO> bListP = bService.BookingListSelectPage(user, pInfo);
			model.addAttribute("pi", pInfo);
			model.addAttribute("bList", bListP);
			return "booking/list";
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}

	// 예약 개별 삭제
	@PostMapping("/booking/deleteOne.ft")
	public ResponseEntity<String> bookingDeleteOne(@RequestParam("bookingNumber") String bookingNumber) {
		try {
			int result = bService.bookingDeleteOne(bookingNumber);
			if(result > 0) {
				return ResponseEntity.ok("해당 예약이 취소되었습니다.");
			}
			return ResponseEntity.ok("취소 실패\n관리자에게 문의하세요");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("예외 발생: " + e.getMessage());
		}
	}
	// 예약 전체 삭제
	@PostMapping("/booking/delete.ft")
	public ResponseEntity<String> bookingDelete(@RequestParam("userId") String userId) {
		try {
			int result = bService.bookingDelete(userId);
			if(result > 0) {
				return ResponseEntity.ok("모든 예약이 취소되었습니다.");
			}
			return ResponseEntity.ok("취소 실패\n관리자에게 문의하세요");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("예외 발생: " + e.getMessage());
		}
	}
	
	// 페이징
	private PageInfo getPageInfo(Integer currentPage, int totalCount) {
		int boardLimit = 5; // 한 페이지당 보여줄 게시물의 갯수
		PageInfo pi = new PageInfo(currentPage, totalCount, boardLimit);
		return pi;
	}
}
