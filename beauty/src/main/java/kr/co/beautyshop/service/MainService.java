package kr.co.beautyshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.beautyshop.dao.MainDAO;
import kr.co.beautyshop.vo.ProductVO;

@Service
public class MainService {

	@Autowired
	private MainDAO dao;
	
	public List<ProductVO> selectNewItem(){
		List<ProductVO> vo = dao.selectNewItem();
		for(ProductVO i : vo) {
			String color = i.getColor();
			if(color != null) {
				String[] arr = color.split(",");
				i.setColorArr(arr);
			}
		}
		return vo;
	}
	public List<ProductVO> selectBestItem(String cate){
		List<ProductVO> vo = dao.selectBestItem(cate);
		for(ProductVO i : vo) {
			String color = i.getColor();
			if(color != null) {
				String[] arr = color.split(",");
				i.setColorArr(arr);
			}
		}
		return vo;
	}
	
	public int countCart(String arg0, String arg1) {
		return dao.countCart(arg0, arg1);
	}
	
}