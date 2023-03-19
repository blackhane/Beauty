package kr.co.beautyshop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.co.beautyshop.vo.CartVO;
import kr.co.beautyshop.vo.ProdCate2VO;
import kr.co.beautyshop.vo.ProductVO;
import kr.co.beautyshop.vo.WishVO;

@Mapper
@Repository
public interface ProductDAO {
	
	//list
	public List<ProductVO> selectProductNew();
	public List<ProductVO> selectProductBest();
	public List<ProductVO> selectProduct1(int arg0, String arg1, int arg2);
	public List<ProductVO> selectProduct2(int arg0, String arg1, int arg2);
	public int selectProduct1Count(int cate);
	public int selectProduct2Count(int cate);
	public List<ProdCate2VO> selectCate(int cate);
	
	//view
	public ProductVO selectProduct(String prodNo);
	public int addWish(WishVO vo);
	public int checkCart(CartVO vo);
	public int updateCart(CartVO vo);
	public int addCart(CartVO vo);
	
}
