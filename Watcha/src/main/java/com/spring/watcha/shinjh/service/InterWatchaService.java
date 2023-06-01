package com.spring.watcha.shinjh.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface InterWatchaService {

	// 로그인 기능 구현
	ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap);
	


}
