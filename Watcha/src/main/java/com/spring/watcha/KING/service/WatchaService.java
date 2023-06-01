package com.spring.watcha.KING.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.watcha.KING.model.InterWatchaDAO;
import com.spring.watcha.common.AES256;
import com.spring.watcha.model.MovieVO;


@Service
public class WatchaService implements InterWatchaService {
	
   @Autowired
   private InterWatchaDAO dao;

   @Autowired 
   private AES256 aes;

	@Override
	public MovieVO getMovieDetail(String movie_id) {

		MovieVO projectInfo = dao.getMovieDetail(movie_id);
		
		return projectInfo;
	}
		
}
