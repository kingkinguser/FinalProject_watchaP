package com.spring.watcha.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.watcha.common.MyUtil;

@Aspect     // 공통관심사 클래스(Aspect Class)로 등록된다.
@Component  // bean 으로 등록된다.
public class WatchaAOP {
		
		// === Pointcut(주업무) === //
		@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..) )") 
		public void requiredLogin() {}
		
		
		// === Before Advice(공통관심사, 보조업무) === //
		@Before("requiredLogin()")
		public void loginCheck(JoinPoint joinpoint) { 
			
			HttpServletRequest request = (HttpServletRequest) joinpoint.getArgs()[0];    // 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다.
			HttpServletResponse response = (HttpServletResponse) joinpoint.getArgs()[1]; // 주업무 메소드의 두번째 파라미터를 얻어오는 것이다. 
			
			HttpSession session = request.getSession();
			if(session.getAttribute("loginuser") == null) {
				String message = "먼저 로그인 하세요~~~";
				String loc = request.getContextPath()+"/login.action";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				String url = MyUtil.getCurrentURL(request);
				
				session.setAttribute("needLogin", true);
				session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장시켜둔다.
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/member/needLogin.jsp"); 
				try {
					dispatcher.forward(request, response);
				} catch (ServletException | IOException e) {
					e.printStackTrace();
				}
			}
			
		}
		
}
