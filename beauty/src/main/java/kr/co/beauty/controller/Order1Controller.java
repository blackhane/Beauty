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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.beauty.service.MyshopService;
import kr.co.beauty.service.Order1Service;
import kr.co.beauty.utils.SessionManager;
import kr.co.beauty.vo.CartVO;
import kr.co.beauty.vo.Member1VO;
import kr.co.beauty.vo.WishVO;

@Controller
public class Order1Controller {
	
	@Autowired
	private Order1Service service;
	@Autowired
	private MyshopService serviceMy;
	
	SessionManager sessionManager = new SessionManager();
	
	/* 비회원 테스트 */
	@GetMapping("order/test")
	public String test(Model model, HttpServletResponse response, HttpServletRequest req) {
		
		if(sessionManager.getSession(req) == null) {
			sessionManager.createSession("check", response);
		}
		return "redirect:/order/cart";
	}
	
	/* 카트 페이지 */
	@GetMapping("order/cart")
	public String cart(Principal principal, Model model, HttpServletRequest req, HttpServletResponse response) {
		if(principal != null){
	 		Member1VO member = service.selectMember(principal.getName());
	 		model.addAttribute("member", member);
	 		//카트리스트 가져오기
			List<CartVO> cartList = service.selectCartList(principal.getName());
			model.addAttribute("cartList", cartList);
			//위시리스트 가져오기
			List<WishVO> wishList = serviceMy.selectWishlist(principal.getName());
			model.addAttribute("wishList", wishList);
	  	}else {
	  		//쿠키 할당
	  		if(sessionManager.getSession(req) == null) {
				sessionManager.createSession("check", response);
			}
	  		//카트리스트 가져오기
			List<CartVO> cartList = service.selectCartList(sessionManager.getNoMemberId(req));
			model.addAttribute("cartList", cartList);
	  	}
		return "order/cart";
	}
	
	//카트 - cartBtns(테이블아래버튼) - 비우기
	@ResponseBody
	@PostMapping("order/deleteAllCart")
	public int deleteAllCart(Principal principal) {
		service.deleteAllCart(principal.getName());
		return 1;
	}
	//카트 - cartBtns(테이블아래버튼) - No-member 비우기
	@ResponseBody
	@PostMapping("order/deleteAllCartNon")
	public int deleteAllCartNon(HttpServletRequest req) {
		service.deleteAllCart(sessionManager.getNoMemberId(req));
		return 1;
	}
	
	//카트 - cartBtns(테이블아래버튼) - 선택상품 삭제
	@ResponseBody
	@PostMapping("order/deleteSelectedCart")
	public int deleteSelectedCart(@RequestParam("chkList[]") int[] deleteList) {
		for(int cartNo : deleteList) {
			service.deleteSelectedCart(cartNo);
		}
		return 1;
	}
	
	
	
	
	//카트 - tableBtns(테이블내부) - 관심상품등록
	@ResponseBody
	@PostMapping("order/addWishFromCart")
	public int addWishFromCart(Principal principal, WishVO vo) {
		vo.setUid(principal.getName());
		serviceMy.addWish(vo);
		return 1;
	}
	
	//카트 - tableBtns(테이블내부) - 삭제
	@ResponseBody
	@GetMapping("order/deleteSelectedCart")
	public int deleteSelectedCart(int cartNo) {
		service.deleteSelectedCart(cartNo);
		return 1;
	}
	
	//카트 - 수량 변경
	@ResponseBody
	@PostMapping("order/cartIncrease")
	public int cartIncrease(int cartNo) {
		return service.cartIncrease(cartNo);
	}
	@ResponseBody
	@PostMapping("order/cartDecrease")
	public int cartDecrease(int cartNo) {
		//감소시 수량 체크
		return service.cartDecrease(cartNo);
	}
	
	//카트 - 위시리스트 - 삭제 fromCart
	@GetMapping("order/deleteSelectedWishFromCart")
	public String deleteSelectedWishFromCart(int wishNo) {
		serviceMy.deleteSelectedWish(wishNo);
		return "redirect:/order/cart";
	}
	
}
