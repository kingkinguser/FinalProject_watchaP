package com.spring.watcha.mindh.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.spring.watcha.model.MovieVO;

public interface InterWatchaService {

	// header 검색어 자동완성
	List<String> searchword(Map<String, String> paraMap);
	
	// footer 평점 갯수 나타내기 
	int showEvaluationNum(MovieVO vo);
	
	// 평점순 순위 30개 나타내기(평점 평가가 기본적으로 10개 이상일때  ) 
	List<MovieVO> starRank();

	// 보고싶어요 순위 30개 나타내기 
	List<MovieVO> seeRank();

	// 한줄평 많은 순위 20개 나타내기 
	List<MovieVO> commentRank();

	 // 많이 평가한 배우 영화 
	List<MovieVO> actorRank();

	// 많이 평가한 영화 장르 
	List<MovieVO> genreRank();

	// 유저의 컬랙션
	List<MovieVO> usercol();

	// 검색어 세션등록 및 검색 
	String[] goSearch(HttpServletRequest request, Map<String, String> paraMap);

	

	


}
