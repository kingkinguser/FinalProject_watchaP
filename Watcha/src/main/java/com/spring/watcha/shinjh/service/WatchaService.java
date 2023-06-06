package com.spring.watcha.shinjh.service;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.watcha.model.MemberVO;
import com.spring.watcha.shinjh.model.InterWatchaDAO;


@Service
public class WatchaService implements InterWatchaService {
	
   @Autowired
   private InterWatchaDAO dao;

   @Override
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request,
			Map<String, String> paraMap) {
		
		MemberVO loginuser = dao.getLoginMember(paraMap);
		
		
		if(loginuser != null && loginuser.getPwdchangegap() >= 3) {
			// 마지막으로 암호를 변경한 날짜가 현재 시각으로 부터 3개월이 지났으면,
			loginuser.setRequirePwdChange(true); // 로그인을 시도하면 alert를 띄우도록 한다.
			
		}
		
		if(loginuser != null) { // 로그인 성공시
	
			HttpSession session = request.getSession();
			// 메모리에 생성되어져있는 세션을 불러온다.
			
			session.setAttribute("loginuser", loginuser);
			// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다. 				
			
			if(loginuser.isRequirePwdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월이 경과한 경우
				
				String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n 암호를 변경하시는 것을 추천합니다.";
				String loc = request.getContextPath()+"/view/main.action";
				// 원래는 위와 같이 /view/main.action 이 아니라 사용자의 암호를 변경해주는 페이지로 잡아주어야 한다.
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
	
				mav.setViewName("msg");
			}
			
			
			else { // 암호를 변경한지 3개월 이내인 경우
				
				// 로그인을 해야만 접근할 수 있는 페이지에 로그인을 하지 않은 상태에서 접근을 시도한 경우 
	            // "먼저 로그인을 하세요!!" 라는 메시지를 받고서 사용자가 로그인을 성공했다라면
	            // 화면에 보여주는 페이지는 시작페이지로 가는 것이 아니라
	            // 조금전 사용자가 시도하였던 로그인을 해야만 접근할 수 있는 페이지로 가기 위한 것이다.
				 String goBackURL = (String) session.getAttribute("goBackURL");
				
				 if(goBackURL != null) {
					 mav.setViewName("redirect:"+goBackURL);
					 session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다.
				 }
				 else {
						mav.setViewName("redirect:/view/main.action"); // 시작페이지로
				 }
			}
			
		}
		
		if(loginuser == null) { // 로그인 실패시
			String message = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
	
			mav.setViewName("msg");
			//    /WEB-INF/views/msg.jsp   파일을 생성한다.
		}
			
		return mav;
	}


   // 회원가입시 아이디 중복체크 기능 구현
	@Override
	public int idDuplicateCheck(String user_id) {
		
		int n = dao.idDuplicateCheck(user_id);
		
		return n;
	}


   @Override
	public int signupEnd(ModelAndView mav,	Map<String, String> paraMap) {
	   
	   int n = dao.signupEnd(paraMap);
	   
	   return n;
	   
   }
		
}
