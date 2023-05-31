package com.spring.watcha.seosk.service;

import java.util.*;

import com.spring.watcha.common.MovieVO;

public interface InterWatchaService {

	// 마이왓챠 기본정보 - 최근 평가한 영화 5개
	List<MovieVO> ratingFive(String userid);

	// 마이왓챠 기본정보 - 회원정보, 평균 별점, 평가한 영화개수, 한줄평 개수, 컬렉션 개수
	Map<String, String> userInfo(String userid);

	// 회원이 평가한 영화 전체
	List<Map<String, String>> ratingMovies(String user_id);

	// 내 한줄평 - 한줄평 8개씩 페이징 처리
	List<Map<String, String>> myReviewPaging(Map<String, String> paraMap);

	// 한줄평 페이지바 만들기
	String makeReviewPageBar(Map<String, String> paraMap);

	// 회원이 평가한 영화 - 10개씩 페이징 처리
	List<Map<String, String>> rateMoviesPaging(Map<String, String> paraMap);

	// 영화별 유저들 한줄평 - 6개씩 페이징 처리
	List<Map<String, String>> movieReviewPaging(Map<String, String> paraMap);
	
}
