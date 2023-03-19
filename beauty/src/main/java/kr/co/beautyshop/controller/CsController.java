package kr.co.beautyshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class CsController {
	
	@GetMapping("notice")
	public String notice() {
		return "community/notice";
	}
	
	@GetMapping("qna")
	public String qna() {
		return "community/qna";
	}
	
	@GetMapping("review")
	public String review() {
		return "community/review";
	}
	
	@GetMapping("event")
	public String event() {
		return "community/event";
	}
	
}
