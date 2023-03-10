package kr.co.beauty.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.beauty.vo.Product1VO;

@Repository
public interface AdminDAO {
	public int insertProduct(Product1VO vo);
	public List<Product1VO> selectProducts(String param1,String arg1, int param3);
	public List<Product1VO> selectProductByCheckBox(List<String> collection);
	public int deleteProduct(String prodNo);
	public List<Product1VO> searchProduct(String param1,String arg1,String param2,String arg2);
	public int selectCountTotal();
}
