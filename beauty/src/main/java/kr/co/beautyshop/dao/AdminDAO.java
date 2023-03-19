package kr.co.beautyshop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.co.beautyshop.vo.Product1VO;

@Mapper
@Repository
public interface AdminDAO {
	public int insertProduct(Product1VO vo);
	public List<Product1VO> selectProducts(List<String> collection);
	public int selectCountProducts(List<String> collection);
	public int deleteProduct(String prodNo);
	public List<Product1VO> searchProduct(String[] arg0,String param2,String arg2);
	public int selectCountTotal();
}
