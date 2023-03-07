/*
 * 날짜 : 2023-03-07
 * 이름 : 강중현
 * 내용 : memberVO
 */
package kr.co.beauty.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MemberVO {
	private String email;
	private String password;
	private String name;
	private String level;
	private int point;
	private String phone;
	private String zip;
	private String addr1;
	private String addr2;
	private String regip;
	private String rdate;
	private String height;
	private String weight;
	
	// terms 추가
	private String terms;
	private String privacy;
	private String location;
	
}