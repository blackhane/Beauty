/* 
 * 김동근
 * CartVO
 * WishVO
 */
package kr.co.beautyshop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.beautyshop.vo.MyorderVO;
import kr.co.beautyshop.vo.WishVO;

@Mapper
@Repository
public interface MyshopDAO {
	
	//myorder
	public List<MyorderVO> selectOrderList(@Param("uid") String uid);
	
	//wishlist
	public void addWish(WishVO vo);
	public int checkWish(WishVO vo);
	public List<WishVO> selectWishlist(@Param("uid") String uid);
	public void deleteSelectedWish(@Param("wishNo") int wishNo);
	public void deleteAllWish(@Param("uid") String uid);
}
