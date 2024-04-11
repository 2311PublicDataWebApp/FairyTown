package com.fairytown.ft.ticketing.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String ticketingRegistView(Model model, TicketVO ticketOne) {
		try {
			UserVO user = new UserVO();
			// 임시 아이디 할당
			user.setUserId("khuser01");
			if(ticketOne.getTicketNo() == null) {
				// 임시 티켓 할당 -> 1번티켓 조회해주세요
				ticketOne = new TicketVO("1", "종일권", "티켓 설명", "ING.PNG", 300, 200, 100, 0, null, null, null, 0, null, null);				
			}
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

			model.addAttribute("ticketOne",ticketOne);
			model.addAttribute("tingOne",tingOne);
			model.addAttribute("user", user);
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
	// 결제 값 저장시키는 로직
	@PostMapping("/ticketing/paymentRegist.ft")
	public String ticketingPaymentRegist(@ModelAttribute TicketingVO tingOne,@RequestParam("reservationDateStr") String reservationDateStr, Model model) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        java.util.Date parsedDate = sdf.parse(reservationDateStr);
	        Date reservationDate = new Date(parsedDate.getTime());
			tingOne.setReservationDate(reservationDate);
			tingOne.setPurchaseSuccess("Y");
			int result = tingService.ticktingRegister(tingOne);
			if(result > 0) {
				return "ticketing/list";
			} else {
				return "common/errorPage";
			}
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
	// 결제 내역 리스트 뷰
	@GetMapping("/ticketing/list.ft")
	public String ticketingListView(Model model) {
		try {
			UserVO user = new UserVO();
			// 임시 아이디 할당
			user.setUserId("khuser01");		
			List<TicketingVO> tingList = tingService.ticketingListSelect(user);
			model.addAttribute("tingList", tingList);
			// 티켓 정보 조회 (티켓에 연결)
//			model.addAttribute("tList", tList);
			return "ticketing/list";
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
}
