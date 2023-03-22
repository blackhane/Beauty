package kr.co.beauty.controller;

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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.beauty.service.MainService;
import kr.co.beauty.service.ProductService;
import kr.co.beauty.service.UtilService;
import kr.co.beauty.utils.CookieManager;
import kr.co.beauty.vo.CartVO;
import kr.co.beauty.vo.ProdCate2VO;
import kr.co.beauty.vo.ProductVO;
import kr.co.beauty.vo.WishVO;
import lombok.extern.log4j.Log4j2;

/*
 * 작업자 : 박진휘
 * 내용 : 상품리스트 & 상품보기
 */
@Log4j2
@Controller
@MapperScan("kr.co.beauty.vo")
public class ProductController {
	@Autowired
	private ProductService service;
	@Autowired
	private CookieManager cookie;
	@Autowired
	private UtilService util;

	// 상품리스트 출력
	@GetMapping("shop/list")
	public String productList(Model model, int cate, Principal principal,
			@CookieValue(required = false) String nomember, @RequestParam(required = false) String sort,
			@RequestParam(required = false) Integer pg, HttpSession session) {
		if (pg == null) {
			pg = 1;
		}
		int start = (pg - 1) * 20;
		int[] pageArr = new int[4];
		List<ProductVO> vo = new ArrayList<>();
		int count = 0;
		if (cate == 1000) {
			vo = service.selectProductNew();
		} else if (cate == 1001) {
			vo = service.selectProductBest();
		} else if (cate % 100 == 0) {
			vo = service.selectProduct1(cate, sort, start);
			count = service.selectProduct1Count(cate);
			pageArr = service.page(count, pg);
		} else {
			vo = service.selectProduct2(cate, sort, start);
			count = service.selectProduct2Count(cate);
			pageArr = service.page(count, pg);
		}
		List<ProdCate2VO> category = service.selectCate(cate);
		model.addAttribute("lists", vo);
		model.addAttribute("count", count);
		model.addAttribute("cate", category);
		model.addAttribute("now", cate);
		model.addAttribute("sort", sort);
		model.addAttribute("page", pageArr);
		// 베스트상품
		List<ProductVO> best = service.selectBestItem(cate);
		model.addAttribute("best", best);
		// 장바구니 카운터
		Object cartCount = session.getAttribute("cartCount");
		if (cartCount == null) {
			cartCount = util.header(principal, nomember);
			session.setAttribute("cartCount", cartCount);
		}
		model.addAttribute("cartCount", cartCount);
		return "product/list";
	}

	// 상품보기
	@GetMapping("shop/view")
	public String productView(Model model, @RequestParam("pno") String prodNo, Principal principal,
			@CookieValue(required = false) String nomember, HttpServletResponse resp, HttpSession session) {
		ProductVO prod = service.selectProduct(prodNo);
		// 쿠키만들기
		if (nomember == null) {
			cookie.nomemberCookie(resp);
		}
		String uid = null;
		if (principal != null) {
			uid = principal.getName();
		}
		model.addAttribute("prod", prod);
		model.addAttribute("uid", uid);
		// 장바구니 카운터
		Object cartCount = session.getAttribute("cartCount");
		if (cartCount == null) {
			cartCount = util.header(principal, nomember);
			session.setAttribute("cartCount", cartCount);
		}
		model.addAttribute("cartCount", cartCount);
		return "product/view";
	}

	// 위시리스트
	@PostMapping("addWish")
	@ResponseBody
	public Map<String, Integer> wish(WishVO vo) {
		Map<String, Integer> result = new HashMap<>();
		int rs = service.addWish(vo);
		result.put("result", rs);
		return result;
	}

	// 장바구니 등록
	@PostMapping("addCart")
	@ResponseBody
	public Map<String, Integer> cart(@RequestParam Map data, Principal principal,
			@CookieValue(required = false) String nomember, HttpServletResponse resp, HttpSession session)
			throws Exception {
		String uid = null;
		if (principal != null) { // 회원ㅇ 로그인 상태
			uid = principal.getName();
		} else if (nomember == null) { // 쿠키가 없을 때(새 쿠키생성 2일짜리)
			uid = cookie.nomemberCookie(resp);
		} else { // 쿠키가 있을 때(기존 쿠키 값)
			uid = nomember;
		}
		// 배열 AJAX 처리
		String json = data.get("jsonArray").toString();
		ObjectMapper mapper = new ObjectMapper();
		List<CartVO> vo = mapper.readValue(json, new TypeReference<ArrayList<CartVO>>() {
		});
		// 장바구니
		int rs = 0;
		for (int i = 0; i < vo.size(); i++) {
			vo.get(i).setUid(uid);
			int check = service.checkCart(vo.get(i));
			if (check > 0) { // 장바구니에 이미 있음(수량 증가)
				rs = service.updateCart(vo.get(i));
				log.info("장바구니 등록 성공!");
			} else { // 장바구니에 없음(새로 등록)
				rs = service.addCart(vo.get(i));
				log.info("장바구니 업데이트 성공!");
			}
		}
		String cartCount = util.header(principal, nomember);
		session.setAttribute("cartCount", cartCount);
		Map<String, Integer> result = new HashMap<>();
		result.put("result", rs);
		return result;
	}

	// 주문하기
	@PostMapping("addOrder")
	@ResponseBody
	public Map<String, Integer> order(@RequestParam Map data, Principal principal,
			@CookieValue(required = false) String nomember, HttpSession session, HttpServletResponse resp)
			throws Exception {
		String uid = null;
		if (principal != null) { // 회원ㅇ 로그인 상태
			uid = principal.getName();
		} else if (nomember == null) { // 쿠키가 없을 때(새 쿠키생성 2일짜리)
			uid = cookie.nomemberCookie(resp);
		} else { // 쿠키가 있을 때
			uid = nomember;
		}
		// 배열 AJAX 처리
		String json = data.get("jsonArray").toString();
		ObjectMapper mapper = new ObjectMapper();
		List<CartVO> vo = mapper.readValue(json, new TypeReference<ArrayList<CartVO>>() {
		});
		// 데이터를 세션에 저장 > 주문하기에서 세션체크해서 가져오기
		int rs = 0;
		for (int i = 0; i < vo.size(); i++) {
			vo.get(i).setUid(uid);
			rs = 1;
		}
		session.setAttribute("viewOrder", vo);
		session.setAttribute("type", "guest");
		Map<String, Integer> result = new HashMap<>();
		result.put("result", rs);
		return result;
	}
}
