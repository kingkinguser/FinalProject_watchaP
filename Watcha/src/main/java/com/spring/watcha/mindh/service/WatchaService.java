package com.spring.watcha.mindh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.mindh.model.InterWatchaDAO;

@Service
public class WatchaService implements InterWatchaService {
	 
	@Autowired
	private InterWatchaDAO dao;

	// 평점순 으로 30개 나타내기(평점 평가가 기본적으로 10개 이상일때  ) 
	@Override
	public List<MovieVO> starRank() {
		
		List<MovieVO> starRankvo = dao.starRank();
		
		return starRankvo;
	}

	// 보고싶어요 순위 30개 나타내기 
	@Override
	public List<MovieVO> seeRank() {
		List<MovieVO> seeRankvo = dao.seeRank();
		
		return seeRankvo;
	}

	// 한줄평 많은 순위 20개 나타내기 
	@Override
	public List<MovieVO> commentRank() {
		List<MovieVO> commentRankvo = dao.commentRank();
		
		return commentRankvo;
	}

	// 좋아하는 배우 영화 
	@Override
	public List<MovieVO> actorRank() {
		List<MovieVO> actorRankvo = dao.actorRank();
		
		return actorRankvo;
	}


}
