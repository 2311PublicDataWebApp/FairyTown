package com.fairytown.ft.booking.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.fairytown.ft.booking.service.BookingService;
import com.fairytown.ft.ride.domain.vo.RideVO;
import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;

@Controller
public class BookingController {
	
	@Autowired
	private BookingService bService;
	
	// 기본예약 뷰 
	@GetMapping("/booking/basic.ft")
	public String bookingBasicView(Model model, HttpSession session) {
		try {
			TicketingVO tingOne = (TicketingVO) session.getAttribute("tingOne");
			model.addAttribute("tingOne", tingOne);
			// rideVO값을 가져와 세션에 저장하도록 변경해야함
			List<RideVO> rideList = new ArrayList<>();
			rideList.add(new RideVO(1, "아트란티스", "설명충", 8, null, null, null, null, null, null, null, null, 1));
			rideList.add(new RideVO(2, "자이로드롭", "설명충", 8, null, null, null, null, null, null, null, null, 2));
			model.addAttribute("rideList", rideList);
			session.setAttribute("rideList", rideList);
			return "booking/basic";
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
	// 기본예약 삭제
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
	
	// 기본예약 예약
	@PostMapping("/booking/basic.ft")
	public String bookingBasic() {
		return "booking/basic";
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
	// 예약내역 뷰 
	@GetMapping("/booking/list.ft")
	public String bookingListView() {
		return "booking/list";
	}
}
