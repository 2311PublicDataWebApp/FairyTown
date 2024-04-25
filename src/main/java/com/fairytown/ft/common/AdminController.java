package com.fairytown.ft.common;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fairytown.ft.user.service.UserService;

@Controller
public class AdminController {
	//04/08 아주 만약 대쉬보드를 적용할 경우 혹은 어드민 공통 컨트롤러가 필요할 시 사용하게 될 컨트롤러 입니다.
	// 각 어드민 영역에 대한 컨트롤러는 각 영역 컨트롤러 사용하시면 됩니다. (예시 놀이기구 어드민 등록 -> RideController)
	@Autowired
	private UserService uService;
	
	@GetMapping("/admin.ft")
	public String adminPage(Model model) {
		try {
			// 유저
			int totalUser = uService.getUserTotalCount();
			// 날짜를 발표당일로 고정해놓음
			String dateString = "2024-04-30";
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date utilDate = dateFormat.parse(dateString);
			java.sql.Date today = new java.sql.Date(utilDate.getTime());

			List<Map<String,Object>> listUser = uService.adminUserBoard(today);
			List<Integer> countList = new ArrayList<>();
			for (Map<String, Object> map : listUser) {
			    int count = ((Number) map.get("COUNT(*)")).intValue();
			    countList.add(count);
			}
			int difference = countList.get(6) - countList.get(5);
			model.addAttribute("totalUser", totalUser);
			model.addAttribute("listUser", countList);
			model.addAttribute("difference", difference);
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
