package com.fairytown.ft.ticketing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.fairytown.ft.ticket.domain.vo.TicketVO;
import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fairytown.ft.ticketing.service.TicketingService;
import com.fairytown.ft.user.domain.vo.UserVO;

@Controller
public class TicketingController {
	
	@Autowired
	private TicketingService tingService;
	
	// 티켓팅 입력 진행 뷰
	@GetMapping("/ticketing/regist.ft")
	public String ticketingRegistView(Model model) {
		try {
			UserVO user = new UserVO();
			// 임시 아이디 할당
			user.setUserId("testuser01");
			// 임시 티켓 할당
			//에러 나서 임시 변환 2024-04-11 김혜연
			TicketVO ticketOne = new TicketVO(null, null, null, null, 0, 0, 0, 0, null, null, null, 0, null, null);
			model.addAttribute("user", user);
			model.addAttribute("ticketOne", ticketOne);
			return "ticketing/regist";
			
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
	@PostMapping("/ticketing/regist.ft")
	public String ticketingRegist(TicketingVO tingOne, UserVO user, TicketVO ticketOne, Model model) {
		try {
			// 티켓 결제금액 계산
			int adult = tingOne.getAdult();
			int teenager = tingOne.getTeenager();
			int child = tingOne.getChild();
			int tAdult = ticketOne.getTicketAdult();
			int tTeenager = ticketOne.getTicketTeen();
			int tChild = ticketOne.getTicketChild();
			int totalPrice = (adult*tAdult)+(teenager*tTeenager)+(child*tChild);
			tingOne.setPurchasePrice(totalPrice);

//			TicketingVO ticketing = tingService.ticktingSelect(tingOne);
			model.addAttribute("ticketOne",ticketOne);
			model.addAttribute("tingOne",tingOne);
			return "ticketing/confirm";		
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
	// 티켓팅 확인 진행 뷰
	@GetMapping("/ticketing/confirm.ft")
	public String ticketingConfirmView() {
		
		return "ticketing/confirm";
	}
//	@PostMapping("/ticketing/paymentRegist.ft")
//	public String ticketingPaymentRegist() {
//		// 결제 값 저장시키는 로직
//		return null;
//	}
}
