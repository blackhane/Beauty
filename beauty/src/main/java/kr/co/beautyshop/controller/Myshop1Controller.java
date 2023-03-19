/*
날짜 : 2023/03/06
이름 : 김동근
내용 : Beauty SpringBoot myshop Controller 
*/
package kr.co.beautyshop.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.beautyshop.service.MyshopService;
import kr.co.beautyshop.vo.MemberVO;
import kr.co.beautyshop.vo.MyorderVO;
import kr.co.beautyshop.vo.WishVO;

@Controller
public class Myshop1Controller {
	
	@Autowired
	private MyshopService service;
	
	/* 인덱스 */
	@GetMapping(value = {"myshop/", "myshop/index"})
	public String myhome(Principal principal, Model model) {
		//유저 정보 받기
		if (principal != null) {
			MemberVO member = service.selectMember(principal.getName());
			model.addAttribute("member", member);
		}
		
		
		return "myshop/myhome";
	}
	
	
	
	/* 주문내역 */
	@GetMapping("myshop/myorder")
	public String myorder(Principal principal, Model model) {
		if (principal != null) {
			//유저 정보 받기
			MemberVO member = service.selectMember(principal.getName());
			model.addAttribute("member", member);
			//내 주문내역 가져오기
			List<MyorderVO> orderList = service.selectOrderList(principal.getName());
			model.addAttribute("orderList", orderList);
		}		
		
		//카테고리
		model.addAttribute("option", "myorder");
		return "myshop/myorder";
	}
	
	
	
	/* 쿠폰 */
	@GetMapping("myshop/coupon")
	public String coupon(Principal principal, Model model) {
		//유저 정보 받기
		if (principal != null) {
			MemberVO member = service.selectMember(principal.getName());
			model.addAttribute("member", member);
		}
		//내 쿠폰목록 가져오기
		
		//카테고리
		model.addAttribute("option", "coupon");
		return "myshop/coupon";
	}
	
	
	
	/* 적립금 */
	@GetMapping("myshop/point")
	public String point(Principal principal, Model model) {
		//유저 정보 받기
		if (principal != null) {
			MemberVO member = service.selectMember(principal.getName());
			model.addAttribute("member", member);
		}
		//내 적립내역 가져오기
		
		//카테고리
		model.addAttribute("option", "point");
		return "myshop/point";
	}
	
	
	
	/* 1:1문의 */
	@GetMapping("myshop/myqna")
	public String myqna(Principal principal, Model model) {
		//유저 정보 받기
		if (principal != null) {
			MemberVO member = service.selectMember(principal.getName());
			model.addAttribute("member", member);
		}
		//내 문의내역 가져오기
		
		//카테고리
		model.addAttribute("option", "myqna");
		return "myshop/myqna";
	}
	
	
	
	/* 위시 리스트 */
	@GetMapping("myshop/wishlist")
	public String wishlist(Principal principal, Model model) {
		if (principal != null) {
			//유저 정보 받기
			MemberVO member = service.selectMember(principal.getName());
			model.addAttribute("member", member);
			//위시리스트 가져오기
			List<WishVO> wishList = service.selectWishlist(principal.getName());
			model.addAttribute("wishList", wishList);
		}
		//카테고리
		model.addAttribute("option", "wishlist");
		return "myshop/wishlist";
	}
	
	//위시리스트 전체삭제
	@ResponseBody
	@PostMapping("myshop/deleteAllWish")
	public int deleteAllWish(Principal principal) {
		service.deleteAllWish(principal.getName());
		return 1;
	}
	
	//위시리스트 선택삭제(1개씩만 가능)
	@GetMapping("myshop/deleteSelectedWish")
	public String deleteSelectedWish(int wishNo) {
		service.deleteSelectedWish(wishNo);
		return "redirect:/myshop/wishlist";
	}
	
	
	
	/* 나의 프로필 */
	@GetMapping("myshop/profile")
	public String profile(Principal principal, Model model) {
		//유저 정보 받기
		if (principal != null) {
			MemberVO member = service.selectMember(principal.getName());
			model.addAttribute("member", member);
		}
		//카테고리
		model.addAttribute("option", "profile");
		return "myshop/profile";
	}
	
	@ResponseBody
	@PostMapping("myshop/checkPW")
	public int checkPW(Principal principal, @RequestParam("pass") String pass) {
		return service.checkPW(principal.getName(), pass);
	}
	
	@ResponseBody
	@PostMapping("myshop/updateMember")
	public int updateMember(Principal principal, @RequestBody MemberVO vo) {
		vo.setUid(principal.getName());
		System.out.println("hi");
		return service.updateMember(vo);
	}
	
	@ResponseBody
	@PostMapping("myshop/deleteMember")
	public int deleteMember(Principal principal) {
		//return service.deleteMember(principal.getName());
		return 1;
	}
	
}
