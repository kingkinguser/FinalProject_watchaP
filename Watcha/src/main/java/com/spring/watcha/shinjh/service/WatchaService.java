package com.spring.watcha.shinjh.service;


import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.watcha.common.AES256;
import com.spring.watcha.model.MemberVO;
import com.spring.watcha.shinjh.model.InterWatchaDAO;


@Service
public class WatchaService implements InterWatchaService {
	
   @Autowired
   private InterWatchaDAO dao;

   @Autowired
   private AES256 aes;

@Override
public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request,
		Map<String, String> paraMap) {
	
	MemberVO loginuser = dao.getLoginMember(paraMap);
	
	// aes 의존객체를 사용하여 로그인 되어진 사용자(loginuser)의 이메일 값을 복호화 하도록 한다. === 
    // 또한 암호변경 메시지와 휴면처리 유무 메시지를 띄우도록 업무처리를 하도록 한다.
	if(loginuser != null && loginuser.getPwdchangegap() >= 3) {
		// 마지막으로 암호를 변경한 날짜가 현재 시각으로 부터 3개월이 지났으면,
		loginuser.setRequirePwdChange(true); // 로그인을 시도하면 alert를 띄우도록 한다.
		
	}
	
	/*
	 * idle 추가하면 사용
	if(loginuser != null && loginuser.getIdle() == 0 && loginuser.getLastlogingap() >= 12) {
		// 마지막으로 로그인한 날짜가 현재 시각으로 부터 12개월이 지났으면, 휴면 처리한다.
		loginuser.setIdle(1);
		
		// === tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기 === //
		dao.updateIdle(paraMap.get("userid")); // key갑을 BoardController에서 Map안에 저장해두었다. 현재는 DB에서 idle을 변경해줄 대상을 식별해주는 것이 userid이기 때문에 userid를 가져온다.
	
		
	}
	*/	
	
	if(loginuser != null) {
		try {
			String email = aes.decrypt(loginuser.getEmail()); // email은 암호화 되어있기 때문에 정상적으로 보여지려면 복호화를 해야한다.
			loginuser.setEmail(email); // 복호화 되어진 email이 넘어가야한다.
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
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
	
	else { // 아이디와 암호가 존재하는 경우
		
	/*	idle 추가하면 사용
			if(loginuser.getIdle() == 1) {  // 로그인 한지 1년이 경과한 경우
				
				String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다.\\n관리자에게 문의바랍니다.";
				String loc = request.getContextPath()+"/index.action";
				// 원래는 위와 같이 index.action 이 아니라 휴면이 계정을 풀어주는 페이지로 잡아주어야 한다.
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");					
			}
			else { // 로그인 한지 1년 이내인 경우
		*/		
				HttpSession session = request.getSession();
				// 메모리에 생성되어져있는 세션을 불러온다.
				
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다. 				
				
				if(loginuser.isRequirePwdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월이 경과한 경우
					
					String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n 암호를 변경하시는 것을 추천합니다.";
					String loc = request.getContextPath()+"/index.action";
					// 원래는 위와 같이 index.action 이 아니라 사용자의 암호를 연결해주는 페이지로 잡아주어야 한다.
					
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
							mav.setViewName("redirect:/index.action"); // 시작페이지로
					 }
//				}
				
			}
			
		 }
	
	return mav;
}
		
}
