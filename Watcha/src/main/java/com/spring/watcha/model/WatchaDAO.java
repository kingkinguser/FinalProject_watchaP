package com.spring.watcha.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
@Repository
public class WatchaDAO implements InterWatchaDAO {

		@Resource
		private SqlSessionTemplate sqlsession ;
		
		
}
