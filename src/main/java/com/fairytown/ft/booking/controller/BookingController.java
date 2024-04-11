package com.fairytown.ft.booking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.fairytown.ft.booking.service.BookingService;

@Controller
public class BookingController {
	
	@Autowired
	private BookingService bService;
	
	// 기본예약 뷰 
	@GetMapping("/booking/basic.ft")
	public String bookingBasicView() {
		return "booking/basic";
	}
	// 기본예약
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
