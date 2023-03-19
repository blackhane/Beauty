package kr.co.beautyshop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.beautyshop.dao.MemberDAO;
import kr.co.beautyshop.repository.MemberRepo;
import kr.co.beautyshop.vo.MemberVO;

@Service
public class MemberService {
	
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private MemberRepo repo;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	// terms
	public MemberVO selectTerms() {
		return dao.selectTerms();
	}
	
	// 회원가입
	public int insertMember(MemberVO vo) {
		vo.setPass(passwordEncoder.encode(vo.getPass2()));
		int result = dao.insertMember(vo);
		return result;
	}
	
	// JPA
	public int countMember(String uid) {
		return repo.countByUid(uid);
	}
	
	// 아이디 찾기
	public String findId(String name, String phone) {
		return dao.findId(name, phone);
	}
	
	// 비밀번호 찾기
	public String findPw(String name, String uid, String phone) {
		return dao.findPw(name, uid, phone);
	}
	
	
	// 자동로그인
	public int countByNameAndUid(String name, String uid) {
		return repo.countByNameAndUid(name, uid);
	}
}
