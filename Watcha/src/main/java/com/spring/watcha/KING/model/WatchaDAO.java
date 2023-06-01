package com.spring.watcha.KING.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.MovieVO;


@Component
@Repository
public class WatchaDAO implements InterWatchaDAO {
	
		@Resource
		private SqlSessionTemplate sqlsession ;

		
		// 영화 정보 가져오기 	
	   @Override
	   public MovieVO getMovieDetail(String movieId) {
	      MovieVO movie = sqlsession.selectOne("watcha.getMovieDetails", movieId); 
	      
	      return movie;
	   }
}
