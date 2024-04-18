package com.fairytown.ft.ticketing.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.fairytown.ft.ticket.domain.vo.TicketVO;
import com.fairytown.ft.ticket.service.TicketService;
import com.fairytown.ft.ticketing.domain.vo.TicketingVO;
import com.fairytown.ft.ticketing.service.TicketingService;
import com.fairytown.ft.user.domain.vo.UserVO;
import com.fairytown.ft.user.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
public class TicketingController {
	
	@Autowired
	private TicketingService tingService;
	@Autowired
	private UserService uService;
	@Autowired
	private TicketService tService;
	
	// 티켓팅 입력 진행 뷰
	@GetMapping("/ticketing/regist.ft")
	public String ticketingRegistView(Model model, @RequestParam(name = "ticketNo", required = false) Integer ticketNo, HttpServletRequest request) {
		// 페이지 진입시 로그인이 되어있어야 합니다
		try {
			HttpSession session = request.getSession();
			UserVO uOne = (UserVO) session.getAttribute("user");
			UserVO user = uService.selectUser(uOne.getUserId());
			TicketVO ticketOne = new TicketVO();
			if(ticketNo == null || ticketNo == 0) {
			    ticketNo = 1;
			}
			ticketOne = tingService.selectByTicketNo(ticketNo);
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
	public String ticketingListView(Model model, HttpServletRequest request) {
		// 페이지 진입시 로그인이 되어있어야 합니다.
		try {
			HttpSession session = request.getSession();
			UserVO uOne = (UserVO) session.getAttribute("user");
			UserVO user = uService.selectUser(uOne.getUserId());	
			List<TicketingVO> tingList = tingService.ticketingListSelect(user);
			model.addAttribute("user", user);
			model.addAttribute("tingList", tingList);
			return "ticketing/list";
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
	}
	// 놀이기구 예약할 티켓 변경 로직
	@PostMapping("/ticketing/sendCode.ft")
	public ResponseEntity<String> sendTicketingCode(@RequestParam("ticketingCode") String ticketingCode, HttpSession session) {
		TicketingVO tingOne = tingService.sendTicketingCode(ticketingCode);
		session.setAttribute("tingOne", tingOne);
		return ResponseEntity.ok(ticketingCode + "티켓 변경\n해당 날짜로 예약하실 수 있습니다!");
	}
	// 티켓 결제 취소
	@PostMapping("/ticketing/cancle.ft")
	public ResponseEntity<String> ticketingCancle(@RequestParam("ticketingCode") String ticketingCode) {
		try {
			int result = tingService.ticketingCancle(ticketingCode);
			if(result > 0) {
				return ResponseEntity.ok(ticketingCode + "티켓 취소 성공\n환불은 4일 이내로 처리됩니다.");
			}
			return ResponseEntity.ok("취소 실패\n관리자에게 문의하세요");
		} catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("예외 발생: " + e.getMessage());
		}
	}
}
