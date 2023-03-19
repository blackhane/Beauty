package kr.co.beautyshop.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.beautyshop.dao.ProductDAO;
import kr.co.beautyshop.vo.CartVO;
import kr.co.beautyshop.vo.ProdCate2VO;
import kr.co.beautyshop.vo.ProductVO;
import kr.co.beautyshop.vo.WishVO;

@Service
public class ProductService {
	
	@Autowired
	private ProductDAO dao;
	
	public List<ProductVO> selectProductNew(){
		List<ProductVO> vo = dao.selectProductNew();
		for(ProductVO i : vo) {
			String color = i.getColor();
			if(color != null) {
				String[] arr = color.split(",");
				i.setColorArr(arr);
			}
		}
		return vo;
	}
	public List<ProductVO> selectProductBest(){
		List<ProductVO> vo = dao.selectProductBest();
		for(ProductVO i : vo) {
			String color = i.getColor();
			if(color != null) {
				String[] arr = color.split(",");
				i.setColorArr(arr);
			}
		}
		return vo;
	}
	public List<ProductVO> selectProduct1(int cate, String sort, int start){
		List<ProductVO> vo = dao.selectProduct1(cate, sort, start);
		for(ProductVO i : vo) {
			String color = i.getColor();
			if(color != null) {
				String[] arr = color.split(",");
				i.setColorArr(arr);
			}
		}
		return vo;
	}
	public List<ProductVO> selectProduct2(int cate, String sort, int start){
		List<ProductVO> vo = dao.selectProduct2(cate, sort, start);
		for(ProductVO i : vo) {
			String color = i.getColor();
			if(color != null) {
				String[] arr = color.split(",");
				i.setColorArr(arr);
			}
		}
		return vo;
	}
	public int selectProduct1Count(int cate){return dao.selectProduct1Count(cate);}
	public int selectProduct2Count(int cate){return dao.selectProduct2Count(cate);}
	public List<ProdCate2VO> selectCate(int cate){
		cate = (cate/100) * 100;
		return dao.selectCate(cate);
	}
	
	public int[] page(int count, int pg) {
		int lastPage = 1;
		if(count % 20 == 0) {
			lastPage = count / 20;
		}else {
			lastPage = count / 20 + 1;
		}
		int current = (int) Math.ceil(pg / 20.0);
		int groupStart = (current - 1) * 10 + 1;
		int groupEnd = current * 10;
		if(groupEnd > lastPage) {
			groupEnd = lastPage;
		}
		int[] result = {groupStart, groupEnd, lastPage, pg};
		return result;
	}
	
	//��ǰ view 
	public ProductVO selectProduct(String prodNo) {
		ProductVO vo = dao.selectProduct(prodNo);
		String color = vo.getColorName();
		String size = vo.getSize();
		if(color != null) {
			String[] arr = color.split(",");
			Arrays.sort(arr);
			vo.setColorArr(arr);
		}
		if(size != null) {
			String[] arr = size.split(",");
			vo.setSizeArr(arr);
		}
		return vo;
	}
	public int addWish(WishVO vo) {
		return dao.addWish(vo);
	}
	public int checkCart(CartVO vo) {
		return dao.checkCart(vo);
	}
	public int updateCart(CartVO vo) {
		return dao.updateCart(vo);
	}
	public int addCart(CartVO vo) {
		return dao.addCart(vo);
	}
	
}
