package com.spring.watcha.KING.model;

import com.spring.watcha.model.MovieVO;

public interface InterWatchaDAO {

	// 영화 및 드라마 등 정보 가져오기 
  	MovieVO getMovieDetail(String movie_id);
		
		
}
