/*
날짜 : 2023/03/08
이름 : 김동근
내용 : Beauty SpringBoot 세션관리
*/
package kr.co.beauty.utils;

import java.util.Arrays;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class SessionManager {
	
	/* 비회원 장바구니 관리 */
	//관리 및 에러방지를 위해 상수로 선언
	public static final String NO_MEMBER_COOKIE = "mySessionId";
	
	//세션 저장소
	//동시 요청에 안전한 ConcurrentHashMap를 사용
	private Map<String, Object> sessionStore = new ConcurrentHashMap<>();
	
	//세션 생성
	public void createSession(Object value, HttpServletResponse response) {
		//세션 ID생성후, 값을 세션에 저장
		String sessionId = UUID.randomUUID().toString();
		sessionStore.put(sessionId, value);
		//쿠키 생성
		Cookie noMemberCookie = new Cookie(NO_MEMBER_COOKIE, sessionId);
		response.addCookie(noMemberCookie);
	}
	
	//세션 조회
	public Object getSession(HttpServletRequest request) {
		Cookie noMemberCookie = findCookie(request, NO_MEMBER_COOKIE);
		if(noMemberCookie == null) {
			return null;
		}
		return sessionStore.get(noMemberCookie.getValue());
	}
	
	//세션 만료
	public void expire(HttpServletRequest request) {
		Cookie noMemberCookie = findCookie(request, NO_MEMBER_COOKIE);
		if(noMemberCookie != null) {
			sessionStore.remove(noMemberCookie.getValue());
		}
	}
	
	
	//쿠키 찾는 로직
	public Cookie findCookie(HttpServletRequest request, String cookieName) {
		if(request.getCookies() == null) {
			return null;
		}
		//쿠키 이름으로 찾아서 반환
		return Arrays.stream(request.getCookies())
				.filter(cookie -> cookie.getName().equals(cookieName))
				.findAny()
				.orElse(null);
	}

	
	
}
