/*
날짜 : 2023/03/06
이름 : 김동근
내용 : Beauty SpringBoot myshop Controller 
*/
package kr.co.beautyshop.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import kr.co.beautyshop.service.MyshopService;
import kr.co.beautyshop.service.OrderService;
import kr.co.beautyshop.vo.CartVO;
import kr.co.beautyshop.vo.MemberVO;
import kr.co.beautyshop.vo.OrderVO;
import kr.co.beautyshop.vo.OrdercompleteVO;
import kr.co.beautyshop.vo.TermsVO;
import kr.co.beautyshop.vo.WishVO;
import lombok.extern.log4j.Log4j2;
/*
 * 작업자 : 박진휘, 김동근
 * 내용 : 장바구니 > 주문 > 주문완료
 */
@Log4j2
@MapperScan("kr.co.beauty.dao")
@Controller
public class OrderController {
	
	@Autowired
	private OrderService service;
	@Autowired
	private MyshopService serviceMy;
	
	/* 김동근 */
	/* 카트 페이지 */
	@GetMapping("order/cart")
	public String cart(Model model, Principal principal, 
			@CookieValue(required = false) String nomember) {
		
		MemberVO member = new MemberVO();
		List<CartVO> cartList = new ArrayList<>();
		List<WishVO> wishList = new ArrayList<>();

		//로그인 체크 & 회원전용 위시리스트
		String uid = null;
		if(principal != null) {
			uid = principal.getName();
			wishList = serviceMy.selectWishlist(uid);
		}
		
		//로그인 했거나 비회원쿠키가 있거나
		if(uid != null || nomember != null){
	 		//회원 + 비회원 장바구니
			cartList = service.selectCartList(uid, nomember);
	  	}

		model.addAttribute("uid", uid);
		model.addAttribute("cartList", cartList);
		model.addAttribute("wishList", wishList);
		
		return "order/cart";
	}
	
	//카트 - cartBtns(테이블아래버튼) - 비우기
	@ResponseBody
	@PostMapping("order/deleteAllCart")
	public int deleteAllCart(Principal principal,
			@CookieValue(required = false) String nomember) {
		if(principal != null) {
			service.deleteAllCart(principal.getName());
		}
		if(nomember != null) {
			service.deleteAllCart(nomember);
		}
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
		return serviceMy.addWish(vo);
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
	
	
	/* 박진휘 */
	//상세보기 > 주문결제 (회원)
	@GetMapping("order/orderform")
	public String order2type1(Model model, 
			HttpSession session, 
			Principal principal, 
			@CookieValue(required = false) String nomember,
			@RequestParam(required = false, value = "cartNo") int[] cartList) {
		
		List<CartVO> list = new ArrayList<>();
		int count = 0;

		@SuppressWarnings("unchecked")
		List<CartVO> viewOrder = (List<CartVO>) session.getAttribute("viewOrder");
		if(cartList != null && cartList.length > 0) {
			for(int cartNo : cartList) {
				CartVO vo = service.selectCart(cartNo);
				list.add(vo);
				count++;
			}
		}else {
			for(int i=0; i<viewOrder.size(); i++) {
				CartVO vo = service.selectProdut(viewOrder.get(i).getProdNo());
				vo.setCartNo(0);
				vo.setCount(viewOrder.get(i).getCount());
				vo.setColor(viewOrder.get(i).getColor());
				vo.setSize(viewOrder.get(i).getSize());
				list.add(vo);
				count++;
			}
		}
		session.setAttribute("orderItem", list);
		model.addAttribute("list",list);
		model.addAttribute("count",count);
		
		if(principal == null) {
			//로그인X
			TermsVO terms = service.orderTerms();
			model.addAttribute("terms",terms);
			return "order/non-orderform";
		}else {
			//로그인ㅇ
			String uid = principal.getName();
			MemberVO vo = service.selectMember(uid);
			model.addAttribute("member",vo);
			return "order/orderform";
		}
	}
	@ResponseBody
	@PostMapping("order/orderform/type1")
	public Map<String, Integer> order2type1(OrdercompleteVO vo, HttpSession session) {
		log.debug("실행확인");
		List<CartVO> item = (List<CartVO>) session.getAttribute("orderItem");
		service.complete(vo, item);
		session.removeAttribute("orderItem");
		
		Map<String, Integer> result = new HashMap<>();
		result.put("result", vo.getOrdNo());
		return result;
	}
	@ResponseBody
	@PostMapping("order/orderform/type2")
	public Map<String, Integer> order2type2(OrdercompleteVO vo, HttpSession session) {
		log.debug("실행확인");
		List<CartVO> item = (List<CartVO>) session.getAttribute("orderItem");
		service.complete(vo, item);
		session.removeAttribute("orderItem");
		
		Map<String, Integer> result = new HashMap<>();
		result.put("result", vo.getOrdNo());
		return result;
	}
	
	//주문완료
	@GetMapping("order/ordercomplete")
	public String ordercomplete2(Model model, int ordNo,
			Principal principal, @CookieValue(required = false) String nomember) {
		OrdercompleteVO vo = service.selectOrdercomplete(ordNo);
		List<OrderVO> orders = service.selectOrder(ordNo);
		model.addAttribute("vo", vo);
		model.addAttribute("orders", orders);
		
		return "order/ordercomplete";
	}
}
