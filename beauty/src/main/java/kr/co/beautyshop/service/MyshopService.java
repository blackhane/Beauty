package kr.co.beautyshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.beautyshop.dao.Member1DAO;
import kr.co.beautyshop.dao.MyshopDAO;
import kr.co.beautyshop.vo.MemberVO;
import kr.co.beautyshop.vo.MyorderVO;
import kr.co.beautyshop.vo.WishVO;

@Service
public class MyshopService {

	//JPA
	@Autowired
	private Member1DAO daoMem;
	@Autowired
	private MyshopDAO daoMy;
	
	//public
	public MemberVO selectMember(String uid) {
		return daoMem.selectMember(uid);
	}
	
	
	//myorder
	public List<MyorderVO> selectOrderList(String uid) {
		return daoMy.selectOrderList(uid);
	}
	
	
	
	
	
	//wishlist
	public int addWish(WishVO vo) {
		//중복체크
		if(daoMy.checkWish(vo) > 0) {
			return 0;
		}else {
			daoMy.addWish(vo);
			return 1;
		}
	}

	public List<WishVO> selectWishlist(String uid) {
		return daoMy.selectWishlist(uid);
	}
	
	public void deleteSelectedWish(int wishNo) {
		daoMy.deleteSelectedWish(wishNo);
	}
	
	public void deleteAllWish(String uid) {
		daoMy.deleteAllWish(uid);
	}
	
	//profile
	public int checkPW(String uid, String pass) {
		MemberVO vo = daoMem.selectMember(uid);
		if (new BCryptPasswordEncoder().matches(pass, vo.getPass())) {
			return 1;
		}else {return 0;}
	}
	
	public int updateMember(MemberVO vo) {
		return daoMem.updateMember(vo);
	}
	
	public int deleteMember(String uid) {
		return daoMem.deleteMember(uid);
	}
	
	
}
