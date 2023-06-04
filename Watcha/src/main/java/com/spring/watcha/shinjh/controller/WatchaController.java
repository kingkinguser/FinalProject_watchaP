package com.spring.watcha.shinjh.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.watcha.shinjh.service.InterWatchaService;

@Component
@Controller
public class WatchaController {
			
		@Autowired 
		private InterWatchaService service; 
			
		
		// 로그인 테스트페이지, 페이지 합치면서 삭제할 예정
		@RequestMapping(value="/view/login_test.action")
		public String login_test() {
			System.out.println("value=\'/view/login_test.action\'");
			return "login_test";
		}	
		
		
		// 로그인 기능 구현
		@RequestMapping(value="/loginEnd.action" , method= {RequestMethod.GET})
		public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
			
			System.out.println("value=\'/loginEnd.action\'");
			String userid = request.getParameter("userid");
			System.out.println("userid => " + userid);
			String pwd = request.getParameter("pwd"); 
			System.out.println("pwd => " + pwd);
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
//			paraMap.put("pwd", Sha256.encrypt(pwd));
			paraMap.put("pwd", pwd);
			
			mav = service.loginEnd(mav, request, paraMap);
			
			return mav;
		}
		
		
}
