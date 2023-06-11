package com.spring.watcha.shinjh.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.spring.watcha.common.Sha256;
import com.spring.watcha.shinjh.service.InterWatchaService;

@Component
@Controller
public class WatchaController {
			
		@Autowired 
		private InterWatchaService service; 
			
		
		// 로그인 테스트페이지, 페이지 합치면서 삭제할 예정
		@RequestMapping(value="/login_test.action")
		public String login_test() {
			
			return "member/login_test";
		}
		
		
		// 로그인 기능 구현
		@RequestMapping(value="/loginEnd.action" , method= {RequestMethod.POST})
		public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
			
			String user_id = request.getParameter("user_id");
			
			String password = request.getParameter("password");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("user_id", user_id);
			paraMap.put("password", Sha256.encrypt(password));
			
			mav = service.loginEnd(mav, request, paraMap);
			
			return mav;
		}
		
		
		// 회원가입시 아이디 중복체크 기능 구현 ajax
		@ResponseBody
		@RequestMapping(value="/idDuplicateCheck.action", method= {RequestMethod.POST})
		public String idDuplicateCheck(HttpServletRequest request) {
			
			String user_id = request.getParameter("user_id");
			
			int isExists = service.idDuplicateCheck(user_id);
			
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("isExists", isExists);
			
			return new Gson().toJson(jsonObj);
			
		}
		
		
		// 회원가입 기능 구현
		@RequestMapping(value="/signupEnd.action", method= {RequestMethod.POST})
		public ModelAndView signupEnd(ModelAndView mav, HttpServletRequest request) {
			
			String user_id = request.getParameter("user_id");
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String mobile = request.getParameter("mobile"); 
			String email = request.getParameter("email");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("user_id", user_id);
			paraMap.put("password", Sha256.encrypt(password));
			paraMap.put("name", name);
			paraMap.put("mobile", mobile);
			paraMap.put("email", email);
			
			int n = service.signupEnd(mav, paraMap);
			
		   if(n == 1) { // 회원가입 성공
			   
			   mav.addObject("user_id", user_id);
			   mav.addObject("password", password);
			   
			   mav.setViewName("member/registerAfterAutoLogin");
			   
		   }
		   else { // 회원가입 실패 테스트용 나중에 지울것
			   
				String message = "회원가입 실패";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
		
				mav.setViewName("msg");
		   }
		   
		   return mav;
		}
		

		// 이메일 중복체크 ajax
		@ResponseBody
		@RequestMapping(value="/member/emailDuplicateCheck.action", method = RequestMethod.POST )
		public String emailDuplicateCheck(HttpServletRequest request) {
			
			String email = request.getParameter("email");
			
			int isExists = service.emailDuplicateCheck(email);
			
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("isExists", isExists);
			
			return new Gson().toJson(jsonObj);
		}
		
		
		// 내정보 수정
		@RequestMapping(value="/modifyMyInfo.action", method = RequestMethod.POST )
		public String modifyMyInfo(HttpServletRequest request) {
			
			return "member/modifyMyInfo.tiles";
		}
		
		
		// 회원정보수정 새암호인지 확인 ajax
		@RequestMapping(value="/member/duplicatePwdCheck.action", method = RequestMethod.POST )
		public String duplicatePwdCheck(HttpServletRequest request) {


			String new_pwd = request.getParameter("new_pwd");
			
			String user_id = request.getParameter("user_id");
			
			Map<String, String> paraMap = new HashMap<>();

			paraMap.put("new_pwd", new_pwd);
			paraMap.put("user_id", user_id);
			
			int n = service.duplicatePwdCheck(paraMap);
			
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("n", n);
			
			return new Gson().toJson(jsonObj);
		}
		
		
}
