package com.fairytown.ft.common;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fairytown.ft.goods.service.OrderService;
import com.fairytown.ft.user.service.UserService;

@Controller
public class AdminController {

	@Autowired
	private UserService uService;
	@Autowired
	private OrderService oService;
	
	@GetMapping("/admin.ft")
	public String adminPage(Model model) {
		try {
			int totalUser = uService.getUserTotalCount();
			// 날짜를 발표당일로 고정해놓음
			String dateString = "2024-04-30";
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date utilDate = dateFormat.parse(dateString);
			java.sql.Date today = new java.sql.Date(utilDate.getTime());
			// 유저
			List<Map<String,Object>> listUser = uService.adminUserBoard(today);
			List<Integer> countList = new ArrayList<>();
			for (Map<String, Object> map : listUser) {
			    int count = ((Number) map.get("COUNT(*)")).intValue();
			    countList.add(count);
			}
			int totalSumU = countList.stream().mapToInt(Integer::intValue).sum();
			int difference = countList.get(6) - countList.get(5);
			model.addAttribute("totalUser", totalUser);
			model.addAttribute("listUser", countList);
			model.addAttribute("difference", difference);
			model.addAttribute("totalSumU", totalSumU);
			// 굿즈판매
			List<Map<String,Object>> listGoodsOrder = oService.adminOrderBoard(today);
			List<Integer> sumList = new ArrayList<>();
			for (Map<String, Object> map : listGoodsOrder) {
			    BigDecimal totalSum = (BigDecimal) map.get("TOTAL_SUM");
			    int intValue = totalSum.intValue(); // BigDecimal 값을 Integer로 변환
			    sumList.add(intValue);
			}
			int totalSum = sumList.stream().mapToInt(Integer::intValue).sum();
			int lastIndex = sumList.size() - 1;
			int lastNumber = sumList.get(lastIndex);

			model.addAttribute("sumList", sumList);
			model.addAttribute("totalSum", totalSum);
			model.addAttribute("lastNumber", lastNumber);
			// qna 갯수
			// 티켓 발매 수
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "common/errorPage";
		}
		return "common/adminMain";
	}
	@GetMapping("/adminTableSample.ft")
	public String adminTableSamplePage() {
		
		return "common/adminTableSample";
	}
}
