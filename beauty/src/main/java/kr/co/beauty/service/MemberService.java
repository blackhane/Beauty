package kr.co.beauty.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.beauty.dao.MemberDAO;
import kr.co.beauty.repository.MemberRepo;
import kr.co.beauty.vo.MemberVO;

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
	
	public MemberVO findId(String name, String phone) {
		return dao.findId(name, phone);
	}
	
}
