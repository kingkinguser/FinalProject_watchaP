package com.spring.watcha.shinjh.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.spring.watcha.model.MemberVO;

public interface InterWatchaService {

	// 로그인 기능 구현
	ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap);

	// 회원가입시 아이디 중복체크 기능 구현 ajax
	int idDuplicateCheck(String user_id);

	// 회원가입 기능 구현
	int signupEnd(ModelAndView mav, Map<String, String> paraMap);

	// 이메일 중복체크 ajax
	int emailDuplicateCheck(String email);

	// 회원정보수정 새암호인지 확인 ajax
	int duplicatePwdCheck(Map<String, String> paraMap);

	// 임시 비밀번호 변경 email ajax
	int findPwd(Map<String, String> paraMap);

	// 내정보 수정하기
	int modifyInfo(MemberVO member);

	// 회원탈퇴
	int deleteMember(MemberVO loginuser);

}
