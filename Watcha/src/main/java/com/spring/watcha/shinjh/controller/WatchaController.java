package com.spring.watcha.shinjh.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.spring.watcha.common.FileManager;
import com.spring.watcha.common.GoogleMail;
import com.spring.watcha.common.Sha256;
import com.spring.watcha.model.MemberVO;
import com.spring.watcha.shinjh.service.InterWatchaService;

@Component
@Controller
public class WatchaController {
			
		@Autowired 
		private InterWatchaService service;
		
		@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
		private FileManager fileManager;
			
		
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
		
		
		@Autowired // Type에 따라 알아서 Bean을 주입해준다.
		private GoogleMail mail;
		// 임시 비밀번호 변경 email ajax
		@ResponseBody
		@RequestMapping(value="/findPwd.action", method= RequestMethod.POST)
		public String findPwd(HttpServletRequest request) {
				
			String email = request.getParameter("email");
			
			String password = getTempPassword();
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("email", email);
			paraMap.put("password", Sha256.encrypt(password));
			int n = service.findPwd(paraMap);
			
			paraMap.put("password", password);
			
			JsonObject jsonObj = new JsonObject();			
			
			if(n==1) {
				
				try {
					mail.sendmail(paraMap);
					jsonObj.addProperty("result", 1);
				} catch (Exception e) {
					e.printStackTrace();
					jsonObj.addProperty("result", 0);
				}
			}
			else {
				jsonObj.addProperty("result", 2);
			}
			
			return new Gson().toJson(jsonObj);
		}
		
		
		// 임시 비밀번호 생성
	    public String getTempPassword(){
	    	char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
	                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
	    	
	    	char[] charSet2 = new char[] { '~', '!', '@', '#', '$', '%', '^', '&', '*'};

	        String str = "";

	        int idx = 0;
	        for (int i = 0; i < 7; i++) {
	            idx = (int) (charSet.length * Math.random());
	            str += charSet[idx];
	        }
	        idx = (int) (charSet2.length * Math.random());
	        str += charSet2[idx];
	        return str;
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

				mav.setViewName("/member/needLogin");
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
		@RequestMapping(value="/modifyInfo.action", method= RequestMethod.POST)
		public ModelAndView modifyInfo(ModelAndView mav, MemberVO member, MultipartHttpServletRequest mrequest) {
			
			HttpSession session = mrequest.getSession();
			
			// 비밀번호 변경 여부 확인
			String password = member.getPassword();
			
			if(!password.isEmpty()) { // 비밀번호 변경을 했으면
				password = Sha256.encrypt(password);
			}
			
			// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드 (시큐어코드) 작성하기 !!!! //
			member.setName(member.getName().replaceAll("<", "&lt;"));
			member.setName(member.getName().replaceAll(">", "&gt;"));
			
			member.setProfile_message(member.getProfile_message().replaceAll("<", "&lt;"));
			member.setProfile_message(member.getProfile_message().replaceAll(">", "&gt;"));
						
			
			MultipartFile attach = member.getAttach();
			
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			String root = session.getServletContext().getRealPath("/"); 
			
			String path = root+"resources"+File.separator+"images";
			// WAS의 webapp/resources/images 라는 폴더로 지정해준다.  
			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			

			
			
			if( !attach.isEmpty() ) { // attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면) 

				// 기존 프로필이미지 소스 지우기
				if(member.getProfile_image() != null) {
					try {
						fileManager.doFileDelete(member.getProfile_image(), path);
					} catch (Exception e1) {
						e1.printStackTrace();
					}
				}
				
				
				String profile_image = "";
				// WAS(톰캣)의 디스크에 저장될 파일명
				   
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 것
				   
//				long fileSize = 0;
				// 첨부파일의 크기
				   
				try {
					bytes = attach.getBytes();
					// 첨부파일의 내용물을 읽어오는 것
						
					String originalFilename = attach.getOriginalFilename();
					// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다. 
						
					profile_image = fileManager.doFileUpload(bytes, originalFilename, path);
					// 첨부되어진 파일을 업로드 하는 것이다.
						
					member.setProfile_image(profile_image);
					// WAS(톰캣)에 저장된 파일명(20230522103642842968758293800.pdf)
						
//					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					// String.valueOf(fileSize)로 if문 만들어서 프로필사진 크기 제한 할 수 있음
					
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			int n = service.modifyInfo(member);
				
			if(n==1) {
				
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

				loginuser.setName(member.getName());
				loginuser.setMobile(member.getMobile());
				loginuser.setEmail(member.getEmail());
				loginuser.setProfile_message(member.getProfile_message());
				loginuser.setProfile_image(member.getProfile_image());
				
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
				mav.addObject("loc", request.getContextPath()+"/main.action");

				mav.setViewName("/member/needLogin");
			}
			
			return mav;
			
		}
		
}
