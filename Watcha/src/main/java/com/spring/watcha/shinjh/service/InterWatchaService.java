package com.spring.watcha.shinjh.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface InterWatchaService {

	// 로그인 기능 구현
	ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap);

	// 회원가입시 아이디 중복체크 기능 구현
	int idDuplicateCheck(String user_id);

	// 회원가입 기능 구현
	int signupEnd(ModelAndView mav, Map<String, String> paraMap);

}
