package com.spring.watcha.shinjh.model;

import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.MemberVO;

@Component
@Repository
public class WatchaDAO implements InterWatchaDAO {

		@Resource
		private SqlSessionTemplate sqlsession ;

		
		// 로그인 기능 구현
		@Override
		public MemberVO getLoginMember(Map<String, String> paraMap) {
			MemberVO loginuser = sqlsession.selectOne("watcha.getLoginMember", paraMap);
			
			return loginuser;
		}


		// 회원가입시 아이디 중복체크 기능 구현 ajax
		@Override
		public int idDuplicateCheck(String user_id) {
			int n = sqlsession.selectOne("watcha.idDuplicateCheck", user_id);
			return n;
		}


		// 회원가입 기능 구현
		@Override
		public int signupEnd(Map<String, String> paraMap) {
			int n = sqlsession.insert("watcha.signupEnd", paraMap);
			return n;
		}


		// 이메일 중복체크 ajax
		@Override
		public int emailDuplicateCheck(String email) {
			int n = sqlsession.selectOne("watcha.emailDuplicateCheck", email);
			return n;
		}


		// 회원정보수정 새암호인지 확인 ajax
		@Override
		public int duplicatePwdCheck(Map<String, String> paraMap) {
			int n = sqlsession.selectOne("watcha.duplicatePwdCheck", paraMap);
			return n;
		}
}
