package com.spring.watcha.KING.service;

import com.spring.watcha.model.MovieVO;

public interface InterWatchaService {

	// 영화 및 드라마 등 정보 가져오기 
	 MovieVO getMovieDetail(String movie_id);
   
	
	

}
