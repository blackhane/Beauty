package kr.co.beauty.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.ui.Model;
import kr.co.beauty.service.MemberService;
import kr.co.beauty.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	
	@GetMapping("member/login")
	public String login() {
		return "member/login";
	}
	
	@GetMapping("member/register")
	public String register(Model model) {
		MemberVO vo = service.selectTerms();
//		log.info("vo : " + vo);
		model.addAttribute("memberVO", vo);
		return "member/register";
	}
	
	
}