package kr.co.beautyshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import kr.co.beautyshop.dao.Member1DAO;
import kr.co.beautyshop.dao.OrderDAO;
import kr.co.beautyshop.vo.CartVO;
import kr.co.beautyshop.vo.MemberVO;
import kr.co.beautyshop.vo.OrderVO;
import kr.co.beautyshop.vo.OrdercompleteVO;
import kr.co.beautyshop.vo.TermsVO;

@Service
public class OrderService {

	@Autowired
	private Member1DAO daoMem;
	@Autowired
	private OrderDAO daoOrd;
	
	/* 김동근 */
	//public
	public MemberVO selectMember(String uid) {
		MemberVO vo = daoMem.selectMember(uid);
		String phone = vo.getPhone();
		String[] ph = phone.split("-");
		vo.setPhone1(ph[0]);
		vo.setPhone2(ph[1]);
		vo.setPhone3(ph[2]);
		
		String email = vo.getUid();
		String[] em = email.split("@");
		vo.setEmail1(em[0]);
		vo.setEmail2(em[1]);
		
		return vo;
	}
	
	//cart
	public List<CartVO> selectCartList(String uid, String nomember) {
		return daoOrd.selectCartList(uid, nomember);
	}
	public void deleteSelectedCart(int cartNo) {
		daoOrd.deleteSelectedCart(cartNo);
	}
	public void deleteAllCart(String uid) {
		daoOrd.deleteAllCart(uid);
	}
	
	public int cartIncrease(int cartNo) {
		return daoOrd.cartIncrease(cartNo);
	}
	public int cartDecrease(int cartNo) {
		if(daoOrd.checkCountForUpdate(cartNo) < 2) {
			return 0;
		}else {
			return daoOrd.cartDecrease(cartNo);
		}
	}
	
	
	/* 박진휘 */
	//주문완료
	public OrdercompleteVO selectOrdercomplete(int ordNo) {
		return daoOrd.selectOrdercomplete(ordNo);
	}
	public List<OrderVO> selectOrder(int ordNo){
		return daoOrd.selectOrder(ordNo);
	}
	
	//주문결제 페이지
	public CartVO selectProdut(int prodNo) {
		return daoOrd.selectProdut(prodNo);
	}
	public CartVO selectCart(int cartNo) {
		return daoOrd.selectCart(cartNo);
	}
	
	//구매약관
	public TermsVO orderTerms() {
		return daoOrd.orderTerms();
	}
	
	@Transactional
	public void complete(OrdercompleteVO vo, List<CartVO> item) {
		//주문완료 테이블
		daoOrd.completeInsert(vo);
		
		//유저 포인트 차감,적립
		daoOrd.updateMemberPoint(vo);
		
		//상품판매기록 & 장바구니삭제
		for(int i=0; i<item.size(); i++) {
			insertOrder(vo.getOrdNo(), item.get(i));
			deleteCart(item.get(i).getCartNo());
		}
	}
	
	//주문완료전 주문테이블삽입
	public void insertOrder(int ordNo, CartVO vo) {
		OrderVO result = new OrderVO();
		result.setOrdNo(ordNo);
		result.setProdNo(vo.getProdNo());
		result.setCount(vo.getCount());
		result.setPrice(vo.getPrice());
		result.setDiscount(vo.getDiscount());
		result.setDisPrice(vo.getDisPrice());
		result.setPoint(vo.getPoint());
		result.setColor(vo.getColor());
		result.setSize(vo.getSize());
		result.setTotal(vo.getTotalPrice());
		daoOrd.insertOrder(result);
	}
	//주문완료전 장바구니삭제
	public void deleteCart(int cartNo) {
		daoOrd.deleteCart(cartNo);
	}
	//주문(회원)
	public void completeInsert(OrdercompleteVO vo) {
		daoOrd.completeInsert(vo);
	}
	
}
