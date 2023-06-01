package com.spring.watcha.shinjh.model;

import java.util.Map;

import com.spring.watcha.model.MemberVO;

public interface InterWatchaDAO {

	// 로그인 기능 구현
	MemberVO getLoginMember(Map<String, String> paraMap);
		
		
}
