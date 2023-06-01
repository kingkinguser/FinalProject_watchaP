package com.spring.watcha.shinjh.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.watcha.common.Sha256;
import com.spring.watcha.shinjh.service.InterWatchaService;

@Controller
public class WatchaController {
			
		@Autowired 
		private InterWatchaService service; 
			
		
		// 로그인 테스트페이지, 페이지 합치면서 삭제할 예정
		@RequestMapping(value="/view/login_test.action")
		public String login_test() {
			
			return "login_test";
		}	
		
		
		// 로그인 기능 구현
		@RequestMapping(value="/loginEnd.action" , method= {RequestMethod.POST})
		public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd"); 
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", Sha256.encrypt(pwd));
			
			mav = service.loginEnd(mav, request, paraMap);
			return mav;
		}
		
		
}
