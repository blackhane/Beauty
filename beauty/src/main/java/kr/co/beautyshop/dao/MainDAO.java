package kr.co.beautyshop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.co.beautyshop.vo.ProductVO;

@Mapper
@Repository
public interface MainDAO {
	
	public List<ProductVO> selectNewItem();
	public List<ProductVO> selectBestItem(String cate);
	public int countCart(String arg0, String arg1);
	
}
