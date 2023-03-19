/* 
 * 김동근
 * Member1VO 
 */
package kr.co.beautyshop.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.beautyshop.vo.MemberVO;

@Mapper
@Repository
public interface Member1DAO {
	public MemberVO selectMember(@Param("uid") String uid);
	//내 프로필
	public int updateMember(MemberVO vo);
	public int deleteMember(@Param("uid") String uid);
}
