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
		
		
}
