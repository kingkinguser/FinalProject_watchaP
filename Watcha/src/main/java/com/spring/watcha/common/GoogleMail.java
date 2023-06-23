package com.spring.watcha.common;

import java.util.Map;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;


@Component
public class GoogleMail {

	public void sendmail(Map<String, String> paraMap) throws Exception {
		// 1. 정보를 담기 위한 객체
        Properties prop = new Properties(); 
        
        // 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
        //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
        prop.put("mail.smtp.user", "shichae11@gmail.com");
		
        // 3. SMTP 서버 정보 설정
        //    Google Gmail 인 경우  smtp.gmail.com
        prop.put("mail.smtp.host", "smtp.gmail.com");
             
        
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.debug", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        prop.put("mail.smtp.socketFactory.fallback", "false");
        
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
          
        
        Authenticator smtpAuth = new MySMTPAuthenticator();
        Session ses = Session.getInstance(prop, smtpAuth);
           
        // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
        ses.setDebug(true);
                
        // 메일의 내용을 담기 위한 객체생성
        MimeMessage msg = new MimeMessage(ses);

        // 제목 설정
        String subject = "[왓챠피디아] 임시 비밀번호입니다.";
        msg.setSubject(subject);
                
        // 보내는 사람의 메일주소
        String sender = "shichae11@gmail.com";
        Address fromAddr = new InternetAddress(sender);
        msg.setFrom(fromAddr);
                
        // 받는 사람의 메일주소
        Address toAddr = new InternetAddress(paraMap.get("email"));
        msg.addRecipient(Message.RecipientType.TO, toAddr);
                
        // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
        msg.setContent("<div><div><div><div><u></u> " + 
        		"    <div lang=\"ko\" style=\"font-family:sans-serif;margin:0;padding:0;background:#f6f6f6\" bgcolor=\"#f6f6f6\"> " + 
        		"        <div style=\"background-color:#fff;max-width:520px;box-sizing:border-box;margin:0 auto;padding:24px 20px 31px\"> " + 
        		"        <img src=\"https://ci6.googleusercontent.com/proxy/M9w2lKFNjf2DtVf0SF2XKq25m-CT6O8Z0XwQzgCCsQL3k--RtA-jg88-x-ySHzV5zug0TJrMILbN1ofWgDgnHVb3YgxUFdyghTmA-Rs_TOp3rXOGqozSB-cYAcanWAn5bDFdbs6DV2nkKFYj9VXUHd6GdHs6MHUyBceZ8ZMfTVvguCqc9i0eTyc2ilZcCeLa0WS6wDOsJ2xEaV1klFdYU7V5oP2aboWsVJcpBRWn5gxX_5lvynoBYxoCVGzjeDAb0zdsKHfb9gzDoRImn6PeTejSnKpIyVGT3VxmTP_b3mBgTiLUhw_2cQmaQLEcW98B_RyjU48vdlrPZ_NuQrnQaQZ3vudESVD83LiM6Mq00g=s0-d-e1-ft#https://an2-img.amz.wtchn.net/image/v2/9d36e6f0084a696cadb1469dde94b2ea.png?jwt=ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKd1lYUm9Jam9pTDNZeUwzTjBiM0psTDNWcGJXRm5aUzh4TmpFeE1EazFNVFUyTnpZNU5ERXlNalkySW4wLjlqYUh1S01Yb1ZONDFIUXlNRnA2azhmXzlYdHBhYk1ZUEFmYmcxUDhTSVk\"" +
        		" 			style=\"height:35px;margin-bottom:29px;vertical-align:top\" class=\"CToWUd\" data-bit=\"iit\"> " + 
        		"      <h1 style=\"line-height:23px;letter-spacing:-0.7px;color:#000;font-size:19px;margin:0\">임시 비밀번호</h1> " + 
        		"  <hr style=\"background-color:#a1a1a1;width:24px;height:1px;margin:19px 0 10px;padding:0;border-width:0\"> " + 
        		"  <div style=\"line-height:24px;color:#4a4a4a;font-size:16px\"> " + 
        		"    <p style=\"margin:11px 0 0\"> " + 
        		"      안녕하세요, 왓챠피디아입니다.<br> " + 
        		"      귀하의 계정의 비밀번호가 임시 비밀번호로 변경되었습니다. <br>" +
        		"      임시 비밀번호 : " + paraMap.get("password") +
        		"    </p> " + 
        		"  </div> " + 
        		"      </div> " + 
        		"      <div style=\"color:#9b9b9b;background-color:#f6f6f6;line-height:18px;font-size:13px;padding-top:20px;padding-bottom:38px\" align=\"center\"> " + 
        		"          <p style=\"margin:8px 0\">© 2023. <a style=\"color:#fc426a\" >Watcha, Inc.</a> All rights reserved.</p> " + 
        		"          <p style=\"margin:8px 0\"> " + 
        		"            본 메일은 발신 전용입니다. " + 
        		"          </p> " + 
        		"      </div> " + 
        		"    <img src=\"https://ci4.googleusercontent.com/proxy/7VomezLqmlMUmpS9HO4b6Yja2o_6jnxBvPlXB5oxciz2SOpFksvJzJLxZzzj1cTiceaJFiW0JNVQf3C9vcWHfY-e1Ex3Ih3iHQ9f2IQQoAN3UQdC5t2u1lvlSDIzDWhOJNlMDPkkNvQ=s0-d-e1-ft#https://mandrillapp.com/track/open.php?u=30020511&amp;id=d68313f073cf4ff58c56eaf3e27df412\" height=\"1\" width=\"1\" alt=\"\" class=\"CToWUd\" data-bit=\"iit\"></div> " + 
        		"  </div></div></div></div>", "text/html;charset=UTF-8");
                
        // 메일 발송하기
        Transport.send(msg);
		
	}// END OF 	PUBLIC VOID SENDMAIL(STRING EMAIL, STRING CERTIFICATIONCODE) {

	
	
}
