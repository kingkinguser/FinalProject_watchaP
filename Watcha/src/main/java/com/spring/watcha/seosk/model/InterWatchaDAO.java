package com.spring.watcha.seosk.model;

import java.util.*;

import com.spring.watcha.model.MovieVO;

public interface InterWatchaDAO {

	// === 마이왓챠 기본정보 == //
	
	// 최근 평가한 영화 5개
	List<MovieVO> ratingFive(String user_id);

	// 회원정보, 평균 별점, 평가한 영화개수
	Map<String, String> userInfo(String user_id);

	// 한줄평 개수
	String reviewCount(String user_id);

	// 컬렉션 개수
	String collectionCount(String user_id);

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 회원이 평가한 영화 전체
	List<Map<String, String>> ratingMovies(String user_id);
	
	// 내 한줄평 - 한줄평 8개씩 페이징 처리
	List<Map<String, String>> myReviewPaging(Map<String, String> paraMap);

	// 회원이 평가한 영화 - 10개씩 페이징 처리
	List<Map<String, String>> rateMoviesPaging(Map<String, String> paraMap);
	
	// 영화별 유저들 한줄평 - 6개씩 페이징 처리
	List<Map<String, String>> movieReviewPaging(Map<String, String> paraMap);



}
