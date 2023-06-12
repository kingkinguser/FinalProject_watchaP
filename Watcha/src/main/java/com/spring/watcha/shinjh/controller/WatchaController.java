package com.spring.watcha.shinjh.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.spring.watcha.model.MemberVO;
import com.spring.watcha.shinjh.service.InterWatchaService;

@Component
@Controller
public class WatchaController {
			
		@Autowired 
		private InterWatchaService service; 
			
		
		// 로그인 테스트페이지, 페이지 합치면서 삭제할 예정
		@RequestMapping(value="/login_test.action")
		public String login_test(HttpServletRequest request) {
			
			return "member/login_test";
		} 
		
		
		// AOP 테스트페이지, 페이지 합치면서 삭제할 예정
		@RequestMapping(value="/aop_login_test.action")
		public String requiredLogin_login_test(HttpServletRequest request, HttpServletResponse response) {
			
			return "member/login_test";
		}
		
		
		// 로그인 기능 구현
		@RequestMapping(value="/login.action")
		public ModelAndView needLogin(ModelAndView mav, HttpServletRequest request) {
			
			mav.addObject("needLogin", true);
			
			mav.setViewName("/main.tiles");
			
			return mav;
			
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
			   
			   mav.setViewName("/member/registerAfterAutoLogin");
			   
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
		@RequestMapping(value="/emailDuplicateCheck.action", method = RequestMethod.POST )
		public String emailDuplicateCheck(HttpServletRequest request) {
			
			String email = request.getParameter("email");
			
			int isExists = service.emailDuplicateCheck(email);
			
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("isExists", isExists);
			
			return new Gson().toJson(jsonObj);
		}
		
		
		// 내정보 수정
		@RequestMapping(value="/modifyMyInfo.action")
		public ModelAndView modifyMyInfo(ModelAndView mav, HttpServletRequest request) {

			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if(loginuser != null) {
			
				mav.setViewName("member/modifyMyInfo.tiles");
			
			}
			
			else {
				
				mav.addObject("message", "잘못된 접근입니다. (로그인 후 이용 가능합니다.)");
				mav.addObject("loc", "javascript:history.back()");

				mav.setViewName("msg");
			}
			
			return mav;
		}
		
		
		// 회원정보수정 새암호인지 확인 ajax
		@RequestMapping(value="/duplicatePwdCheck.action", method = RequestMethod.POST )
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
		
		
		// 내정보 수정하고 적용하기
		@RequestMapping(value="/modifyInfo.action")
		public ModelAndView modifyInfo(ModelAndView mav, HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String user_id = loginuser.getUser_id();
			
			String password = request.getParameter("password");
			
			if(password == null) {
				password = Sha256.encrypt(request.getParameter("password"));
			}
			else {
				password = "";
			}
			
			String name = request.getParameter("name");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String email = request.getParameter("email");
			String profile_message = request.getParameter("profile_message");
			String profile_image = request.getParameter("profile_image");
			
			String mobile = hp1+hp2+hp3;
			
			MemberVO member = new MemberVO(user_id, password, name, mobile, email
					, profile_message, profile_image);
			
			int n = service.modifyInfo(member);
				
			if(n==1) {

				loginuser.setPassword(password);
				loginuser.setName(name);
				loginuser.setMobile(mobile);
				loginuser.setEmail(email);
				loginuser.setProfile_message(profile_message);
				loginuser.setProfile_image(profile_image);
				
				session.setAttribute("loginuser", loginuser);
				
			}
			
			mav.setViewName("redirect:/myWatcha.action");
			
			return mav;
		}
		
		
		
		// 로그아웃 처리하기
		@RequestMapping(value="/logout.action")
		public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {

			// 로그아웃시 메인페이지로 돌아가는 것임
			HttpSession session = request.getSession();
			
			session.removeAttribute("loginuser");

			mav.setViewName("redirect:/view/main.action");
			
			return mav;
		}
		
		
		// 회원탈퇴
		@RequestMapping(value="/deleteMember.action")
		public ModelAndView deleteMember(ModelAndView mav, HttpServletRequest request) {

			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if(loginuser != null) {
				
				int n = service.deleteMember(loginuser);
				
				if(n==1) {
					// loginuser 세션을 지우기 위해 로그아웃
					mav.setViewName("redirect:/logout.action");
				}
				else {
					mav.addObject("message", "회원탈퇴 실패");
					mav.addObject("loc", "javascript:history.back()");
				}
			}
			
			else {
				
				mav.addObject("message", "잘못된 접근입니다. (로그인 후 이용 가능합니다.)");
				mav.addObject("loc", "javascript:history.back()");

				mav.setViewName("msg");
			}
			
			return mav;
			
		}
		
}
