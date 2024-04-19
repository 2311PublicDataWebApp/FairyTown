package com.fairytown.ft.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	//04/08 아주 만약 대쉬보드를 적용할 경우 혹은 어드민 공통 컨트롤러가 필요할 시 사용하게 될 컨트롤러 입니다.
	// 각 어드민 영역에 대한 컨트롤러는 각 영역 컨트롤러 사용하시면 됩니다. (예시 놀이기구 어드민 등록 -> RideController)
	@GetMapping("/admin.ft")
	public String adminPage() {
		
		return "common/adminMain";
	}
	@GetMapping("/adminTableSample.ft")
	public String adminTableSamplePage() {
		
		return "common/adminTableSample";
	}
}
