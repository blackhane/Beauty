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

import kr.co.beauty.vo.CartVO;

@Mapper
@Repository
public interface Order1DAO {
	
	//cart
	public List<CartVO> selectCartList(@Param("email") String email);
	public void deleteSelectedCart(@Param("cartNo") int cartNo);
	public void deleteAllCart(@Param("email") String email);
	
	//cart - change count
	public int checkCountForUpdate(@Param("cartNo") int cartNo);
	public int cartIncrease(@Param("cartNo") int cartNo);
	public int cartDecrease(@Param("cartNo") int cartNo);

}
