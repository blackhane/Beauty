package kr.co.beauty.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.beauty.service.ProductService;
import kr.co.beauty.utils.SessionManager;
import kr.co.beauty.vo.CartVO;
import kr.co.beauty.vo.ProdCate2VO;
import kr.co.beauty.vo.ProductVO;
import kr.co.beauty.vo.WishVO;

@Controller
@MapperScan("kr.co.beauty.vo")
public class ProductController {
	
	@Autowired
	private ProductService service;
	private SessionManager manager;
	
	@GetMapping("shop/list")
	public String productList(Model model, int cate,
			@RequestParam(required=false) String sort,
			@RequestParam(required=false) Integer pg) {
		
		if(pg == null) {
			pg = 1;
		}
		int start = (pg - 1) * 20;
		int[] pageArr = new int[4];
		List<ProductVO> vo = new ArrayList<>();
		int count = 0;
		if(cate == 1000) {
			vo = service.selectProductNew();
		}else if(cate == 1001) {
			vo = service.selectProductBest();
		}else if(cate % 100 ==0) {
			vo = service.selectProduct1(cate, sort, start);
			count = service.selectProduct1Count(cate);
			pageArr = service.page(count, pg);
		}else {
			vo = service.selectProduct2(cate, sort, start);
			count = service.selectProduct2Count(cate);
			pageArr = service.page(count, pg);
		}
		List<ProdCate2VO> category = service.selectCate(cate);
		
		model.addAttribute("lists",vo);
		model.addAttribute("count",count);
		model.addAttribute("cate",category);
		model.addAttribute("now",cate);
		model.addAttribute("sort",sort);
		model.addAttribute("page", pageArr);
		return "product/list";
	}
	
	@GetMapping("shop/view")
<<<<<<< HEAD
	public String productView(Model model,@RequestParam("pno") String prodNo, Principal principal) {
		ProductVO prod = service.selectProduct(prodNo);
		String uid = null;
		if(principal != null) {
			uid = principal.getName();
		}
		model.addAttribute("prod", prod);
		model.addAttribute("uid", uid);
		return "product/view";
	}
	
	@PostMapping("addWish")
	@ResponseBody
	public Map<String, Integer> wish(WishVO vo) {
		Map<String, Integer> result = new HashMap<>();
		int rs = service.addWish(vo);
		result.put("result", rs);
		return result;
	}
	
	@PostMapping("addCart")
	@ResponseBody
	public void cart(
			@RequestParam Map data, 
			Principal principal, 
			@CookieValue(required = false) String nomember,
			HttpServletResponse resp) throws Exception {
		System.out.println(nomember);
		if(principal != null) {
			//회원ㅇ 로그인 상태
			System.out.println(principal.getName());
		}else if(nomember == null) {
			//쿠키가 없을 때
			String sessionId = UUID.randomUUID().toString();
			Cookie cookie = new Cookie("nomember", sessionId);
			cookie.setPath("/");
			cookie.setMaxAge(60*60*24*2);
			resp.addCookie(cookie);
			System.out.println(sessionId);
		}else {
			//쿠키가 있을 때
			System.out.println(nomember);
		}
		String json = data.get("jsonArray").toString();
		ObjectMapper mapper = new ObjectMapper();
		List<CartVO> vo = mapper.readValue(json, new TypeReference<ArrayList<CartVO>>() {});
		System.out.println(vo.get(0).getProdNo());
	}
	
	@PostMapping("colorsize")
	@ResponseBody
	public Map<String, List<String>> color(ProductVO vo) {
		Map<String, List<String>> result = new HashMap<>();
		List<String> arr = service.findSize(vo);
		result.put("result", arr);
		return result;
	}
=======
	public String productView(Model model,@RequestParam("pno") String prodNo) {
		
		//��ǰ���
		ProductVO prod = service.selectProduct(prodNo);
		model.addAttribute("prod", prod);
		
		
		return "product/view";
	}
>>>>>>> e6f04367c1e0edc089d2422050edc72a6813ecae
}
