package com.spring.watcha.shinjh.model;

import java.util.Map;

import com.spring.watcha.model.MemberVO;

public interface InterWatchaDAO {

	// 로그인 기능 구현
	MemberVO getLoginMember(Map<String, String> paraMap);

	// 회원가입시 아이디 중복체크 기능 구현
	int idDuplicateCheck(String user_id);

	// 회원가입 기능 구현
	int signupEnd(Map<String, String> paraMap);
		
		
}
