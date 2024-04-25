package com.fairytown.ft.booking.controller;

import java.sql.Date;
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
import com.fairytown.ft.ride.service.RideService;
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
	@Autowired
	private RideService rService;
	
	// 기본예약 뷰 
	@SuppressWarnings("unchecked")
	@GetMapping("/booking/basic.ft")
	public String bookingBasicView(Model model, HttpSession session, HttpServletRequest request) {
		try {

			session = request.getSession();
			UserVO uOne = (UserVO) session.getAttribute("user");
			if (uOne == null) {
				return "booking/basic";
			}
			UserVO user = uService.selectUser(uOne.getUserId());
			TicketingVO tingOne = (TicketingVO) session.getAttribute("tingOne");
//		    RideVO ride = (RideVO) session.getAttribute("ride");
			List<RideVO> rideList = (List<RideVO>) session.getAttribute("rideList");


			model.addAttribute("tingOne", tingOne);
			model.addAttribute("user", user);
			model.addAttribute("rideList", rideList);
//			session.setAttribute("rideList", ride);
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
	public String bookingBasic(Model model, HttpSession session, UserVO user,
			@RequestParam("total") int total) {
		try {
			List<RideVO> rideList = (List<RideVO>) session.getAttribute("rideList");			
			TicketingVO tingOne = (TicketingVO) session.getAttribute("tingOne");
			String tingCode = tingOne.getTicketingCode();
			Date tingRevation = tingOne.getReservationDate();
			
			List<BookingVO> bookingList = new ArrayList<>();
			for (RideVO ride : rideList) {
				int rideId = ride.getRideId();
				bookingList.add(new BookingVO(0, user.getUserId(), tingCode, rideId, tingRevation, null, total, null));
			}
			int result = bService.bookingBasic(bookingList);
			if(result > 0) {
				rideList.clear();
			    return "redirect:/booking/list.ft";
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
	public String bookingSingleView(Model model, HttpSession session, HttpServletRequest request,
			@RequestParam("rideId") int rideId) {
		try {
			session = request.getSession();
			UserVO uOne = (UserVO) session.getAttribute("user");
			UserVO user = uService.selectUser(uOne.getUserId());
			TicketingVO tingOne = (TicketingVO) session.getAttribute("tingOne");
			RideVO ride = rService.selectByRideId(rideId);
			model.addAttribute("tingOne", tingOne);
			model.addAttribute("user", user);
			model.addAttribute("ride", ride);
			return "booking/single";
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
	// 개별예약
	@SuppressWarnings("unchecked")
	@PostMapping("/booking/single.ft")
	public String bookingSingle(Model model, HttpSession session, UserVO user,
			@RequestParam("total") int total,
			RideVO ride) {
		TicketingVO tingOne = (TicketingVO) session.getAttribute("tingOne");
		String tingCode = tingOne.getTicketingCode();
		Date tingRevation = tingOne.getReservationDate();
		List<BookingVO> bookingList = new ArrayList<>();
		bookingList.add(new BookingVO(0, user.getUserId(), tingCode, ride.getRideId(), tingRevation, null, total, null));
		int result = bService.bookingBasic(bookingList);
		if(result > 0) {
			List<RideVO> rideList = (List<RideVO>) session.getAttribute("rideList");
		    // rideId와 일치하는 RideVO 객체를 찾아 제거합니다.
		    Iterator<RideVO> iterator = rideList.iterator();
		    while (iterator.hasNext()) {
		        RideVO rider = iterator.next();
		        if (rider.getRideId() == (ride.getRideId())) {
		            iterator.remove();
		            break;
		        }
		    }
		    return "redirect:/booking/basic.ft";
		}else {
			return "common/errorPage";
		}
	}
	// 예약조회 뷰 
	@GetMapping("/booking/list.ft")
	public String bookingListView(Model model, HttpServletRequest request,
			@RequestParam(value="page", required=false, defaultValue="1") Integer currentPage) {
		try {
			HttpSession session = request.getSession();
			UserVO uOne = (UserVO) session.getAttribute("user");
			if (uOne == null) {
				return "booking/list";
			}
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
	// 예약 인원 수정
	@PostMapping("/booking/update.ft")
	public ResponseEntity<String> bookingUpdateOne(@RequestParam("bookingPeople") String bookingPeopleStr,
			@RequestParam("bookingNumber") String bookingNumberStr) {
		try {
	        int bookingNumber = Integer.parseInt(bookingNumberStr);
	        int bookingPeople = Integer.parseInt(bookingPeopleStr);
	        BookingVO bbOne = new BookingVO();
	        bbOne.setBookingNumber(bookingNumber);
	        bbOne.setBookingPeople(bookingPeople);
			int result = bService.bookingUpdateOne(bbOne);
			if(result > 0) {
				return ResponseEntity.ok("해당 예약이 변경되었습니다.");
			}
			return ResponseEntity.ok("수정 실패\n잠시 후 다시 시도해주세요");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("예외 발생: " + e.getMessage());
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
			return ResponseEntity.ok("취소 실패\n잠시 후 다시 시도해주세요");
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
	// 관리자 놀이기구 예약관리 뷰
	@GetMapping("/admin/booking/list.ft")
	public String adminBookingListView(Model model) {
		try {
			List<BookingVO> bList = bService.BookingList();
			model.addAttribute("bList", bList);
			return "admin/bookinglist";
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
	// 관리자 놀이기구 상세 뷰
	@GetMapping("/admin/booking/detail.ft")
	public ResponseEntity<BookingVO> adminBookingDetail(@RequestParam("bookingNumber") String bookingNumber) {
		try {
			BookingVO bOne = bService.BookingDetail(bookingNumber);
	        return ResponseEntity.ok(bOne);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	// 관리자 놀이기구 예약 수정
	@PostMapping("/admin/booking/update.ft")
	public ResponseEntity<BookingVO> adminBookingUpdate(@RequestParam("bookingNumber") String bookingNumberStr,
			@RequestParam("bookingPeople") String bookingPeopleStr) {
	    try {
	        int bookingNumber = Integer.parseInt(bookingNumberStr);
	        int bookingPeople = Integer.parseInt(bookingPeopleStr);
	        BookingVO bbOne = new BookingVO();
	        bbOne.setBookingNumber(bookingNumber);
	        bbOne.setBookingPeople(bookingPeople);
	        BookingVO updatedBooking = bService.adminBookingUpdate(bbOne);
	        return ResponseEntity.ok(updatedBooking); // 업데이트된 예약 정보를 JSON으로 반환
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	    }
	}
	// 관리자 놀이기구 예약 삭제
	@PostMapping("/admin/booking/delete.ft")
	public ResponseEntity<Object> adminBookingDelete(@RequestParam("bookingNumber") String bookingNumberStr) {
		try {
	        int bookingNumber = Integer.parseInt(bookingNumberStr);
	        BookingVO bbOne = new BookingVO();
	        bbOne.setBookingNumber(bookingNumber);
	        int result = bService.adminBookingDelete(bbOne);
	        if (result > 0) {
	            return ResponseEntity.ok().build();
	        }else {
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("없는 예약번호 오류발생");
	        }
		} catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	
	// 페이징
	private PageInfo getPageInfo(Integer currentPage, int totalCount) {
		int boardLimit = 5; // 한 페이지당 보여줄 게시물의 갯수
		PageInfo pi = new PageInfo(currentPage, totalCount, boardLimit);
		return pi;
	}
}
