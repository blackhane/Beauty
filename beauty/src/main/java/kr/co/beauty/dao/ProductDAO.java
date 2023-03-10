package kr.co.beauty.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.co.beauty.vo.ProdCate2VO;
import kr.co.beauty.vo.ProductVO;

@Mapper
@Repository
public interface ProductDAO {
	
	public List<ProductVO> selectProductNew();
	public List<ProductVO> selectProductBest();
	public List<ProductVO> selectProduct1(int arg0, String arg1);
	public List<ProductVO> selectProduct2(int arg0, String arg1);
	public int selectProduct1Count(int cate);
	public int selectProduct2Count(int cate);
	public List<ProdCate2VO> selectCate(int cate);

}
