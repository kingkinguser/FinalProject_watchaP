package com.spring.watcha.mindh.service;

import java.util.List;

import com.spring.watcha.model.MovieVO;

public interface InterWatchaService {

	// 평점순 순위 30개 나타내기(평점 평가가 기본적으로 10개 이상일때  ) 
	List<MovieVO> starRank();

	// 보고싶어요 순위 30개 나타내기 
	List<MovieVO> seeRank();

	// 한줄평 많은 순위 20개 나타내기 
	List<MovieVO> commentRank();

	 // 좋아하는 배우 영화 
	List<MovieVO> actorRank();

}
