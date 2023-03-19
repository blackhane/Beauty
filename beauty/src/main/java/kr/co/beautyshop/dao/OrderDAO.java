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

import kr.co.beautyshop.vo.CartVO;
import kr.co.beautyshop.vo.OrderVO;
import kr.co.beautyshop.vo.OrdercompleteVO;
import kr.co.beautyshop.vo.TermsVO;

@Mapper
@Repository
public interface OrderDAO {
	/* 김동근 */
	//cart
	public List<CartVO> selectCartList(String arg0, String arg1);
	public void deleteSelectedCart(@Param("cartNo") int cartNo);
	public void deleteAllCart(@Param("uid") String uid);
	
	//cart - change count
	public int checkCountForUpdate(@Param("cartNo") int cartNo);
	public int cartIncrease(@Param("cartNo") int cartNo);
	public int cartDecrease(@Param("cartNo") int cartNo);

	
	/* 박진휘 */
	//주문완료
	public OrdercompleteVO selectOrdercomplete(int ordNo);
	public List<OrderVO> selectOrder(int ordNo);
	
	//주문완료전 주문테이블삽입
	public void insertOrder(OrderVO vo);
	//주문완료전 장바구니삭제
	public void deleteCart(int CartNo);
	
	//주문결제 페이지
	public CartVO selectProdut(int prodNo);
	public CartVO selectCart(int cartNo);
	
	//구매약관
	public TermsVO orderTerms();
	
	//주문(회원)
	public void completeInsert(OrdercompleteVO vo);
	
	//포인트 사용
	public void updateMemberPoint(OrdercompleteVO vo);
}
