package kr.co.beautyshop.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.beautyshop.service.EmailService;
import kr.co.beautyshop.service.MemberService;
import kr.co.beautyshop.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {

	@Autowired
	private MemberService service;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private EmailService emailService;
	

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

	@PostMapping("member/register")
	public String register(MemberVO vo, HttpServletRequest req) {
		String regip = req.getRemoteAddr();
		vo.setRegip(regip);
		int result = service.insertMember(vo);
		return "redirect:/member/login?seccess=" + result;
	}

	// 아이디 중복체크
	@ResponseBody
	@GetMapping("member/checkUid")
	public Map<String, Integer> checkUid(String uid) {
		int result = service.countMember(uid);
		Map<String, Integer> map = new HashMap<>();
		map.put("result", result);

		return map;
	}

	// 아이디 찾기
	@GetMapping("member/find")
	public String find() {
		return "member/find";
	}

	@ResponseBody
	@PostMapping("member/find1")
	public Map<String, String> find(Model model, String name, String phone, HttpSession session) {
		String rs = service.findId(name, phone);
		session.setAttribute("rs", rs);
		Map<String, String> result = new HashMap<>();
		result.put("result", rs);
		return result;
	}

	@ResponseBody
	@PostMapping("member/find2")
	public Map<String, Integer> findPw(String name, String uid, String phone, HttpSession session) {

		// System.out.println("name : " + name);
		String rs = service.findPw(name, uid, phone);
		session.setAttribute("rs", rs);
		Map<String, Integer> result = new HashMap<>();
		result.put("result", 1);

		return result;
	}

	// 아이디 찾기
	@GetMapping("member/findIdResult")
	public String findIdResult(Model model, HttpSession session) {
		String uid = (String) session.getAttribute("rs");
		model.addAttribute("uid", uid);

		// MemberVO vo = service.selectUid(uid);
		// model.addAttribute("vo", vo);
		return "member/findIdResult";
	}

	@GetMapping("member/findPwResult")
	public String findPwResult(Model model, HttpSession session) {
		String uid = (String) session.getAttribute("rs");
		model.addAttribute("uid", uid);
		return "member/findPwResult";
	}

	// 이메일
	@ResponseBody
	@PostMapping("member/emailAuth")
	public Map<String, Integer> checkEmail(@RequestParam("email") String email) throws Exception {
		Map<String, Integer> data = new HashMap<>();
		int code = emailService.sendSimpleMessage(email);
		log.info("인증코드 : " + code);
		data.put("status", 1);
		data.put("code", code);
		return data;
	}

	// 아이디 찾기
//	@GetMapping("member/findId")
//	public String findId() {
//		return "member/findId";
//	}

	// 아이디 찾기
//	@ResponseBody
//	@PostMapping("member/findId")
//	public Map<String, String> findId(Model model, String name, String phone, HttpSession session) {
//		String rs = service.findId(name, phone);
//		session.setAttribute("rs", rs);
//		Map<String, String> result = new HashMap<>();
//		result.put("result", rs);
//		return result;
//	}

	// 비밀번호 찾기
//	@GetMapping("member/findPw")
//	public String findPw(HttpSession sess) {
//		sess.removeAttribute("member");
//		return "member/findPw";
//	}

//	@ResponseBody
//	@PostMapping("member/findPw")
//	public Map<String, Integer> findPw(String name, String uid, String phone, HttpSession session) {
//				
//		//System.out.println("name : " + name);
//		String rs = service.findPw(name, uid, phone);
//		session.setAttribute("rs", rs);
//		Map<String, Integer> result = new HashMap<>();
//		result.put("result", 1);
//		
//		return result;
//	}

	// @ResponseBody
//	@PostMapping("member/findPwChange")
//	public Map<String, Integer> findPwChange(@RequestParam("uid") String uid, @RequestParam("pass") String pass) {
//		pass = PasswordEncoder.encode(pass);
//		int result = service.findPwChange(uid, pass);
//		Map<String, Integer> map = new HashMap<>();
//		map.put("result", result);
//		return map;
//	}

}
