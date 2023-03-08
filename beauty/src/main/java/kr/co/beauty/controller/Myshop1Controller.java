/*
날짜 : 2023/03/06
이름 : 김동근
내용 : Beauty SpringBoot myshop Controller 
*/
package kr.co.beauty.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.beauty.service.MyshopService;
import kr.co.beauty.vo.Member1VO;
import kr.co.beauty.vo.WishVO;

@Controller
public class Myshop1Controller {
	
	@Autowired
	private MyshopService service;
	
	/* 위시 페이지 */
	@GetMapping("myshop/wishlist")
	public String wishlist(Principal principal, Model model) {
		//유저 정보 받기
		Member1VO member = service.selectMember("gpaj123ehdm@gmail.com");
		model.addAttribute("member", member);
		//위시리스트 가져오기
		List<WishVO> wishList = service.selectWishlist("gpaj123ehdm@gmail.com");
		model.addAttribute("wishList", wishList);
		
		return "myshop/wishlist";
	}
	
	//위시리스트 전체삭제
	@ResponseBody
	@PostMapping("myshop/deleteAllWish")
	public int deleteAllWish(Principal principal) {
		//deleteAllWish(principal.getName());
		service.deleteAllWish("gpaj123ehdm@gmail.com");
		return 1;
	}
	
	//위시리스트 선택삭제(1개씩만 가능)
	@GetMapping("myshop/deleteSelectedWish")
	public String deleteSelectedWish(int wishNo) {
		service.deleteSelectedWish(wishNo);
		return "redirect:/myshop/wishlist";
	}	
}
