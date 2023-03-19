package kr.co.beautyshop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import kr.co.beautyshop.vo.MemberVO;

@Mapper
@Repository
public interface MemberDAO {
	public int insertMember(MemberVO vo);
	public MemberVO selectMember(String uid);
	public List<MemberVO> selectMembers();
	public void updateMember(MemberVO vo);
	public void deleteMember(String uid);
	public MemberVO selectTerms();

	// 아이디 찾기
	public String findId(String arg0, String arg1);
	
	// 비밀번호 찾기
	public String findPw(String arg0, String arg1, String arg2);
	
	// 자동로그인
	public int countByNameAndUid(String name, String uid);
}
