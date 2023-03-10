/* 
 * 김동근
 * CartVO
 * WishVO
 */
package kr.co.beauty.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.beauty.vo.WishVO;

@Mapper
@Repository
public interface MyshopDAO {
	//wishlist
	public void addWish(WishVO vo);
	public int checkWish(WishVO vo);
	public List<WishVO> selectWishlist(@Param("uid") String uid);
	public void deleteSelectedWish(@Param("wishNo") int wishNo);
	public void deleteAllWish(@Param("uid") String uid);
}
