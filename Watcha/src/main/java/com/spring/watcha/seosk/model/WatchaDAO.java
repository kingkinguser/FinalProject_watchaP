package com.spring.watcha.seosk.model;

import java.util.*;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.MovieVO;

@Repository
public class WatchaDAO implements InterWatchaDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// 최근 평가한 영화 5개
	@Override
	public List<MovieVO> ratingFive(String user_id) {
		List<MovieVO> ratingFiveList = sqlsession.selectList("watcha.ratingFive", user_id);
		return ratingFiveList;
	}

	// 회원정보, 평균 별점, 평가한 영화개수
	@Override
	public Map<String, String> userInfo(String user_id) {
		Map<String, String> userInfo = sqlsession.selectOne("watcha.userInfo", user_id);
		return userInfo;
	}

	// 한줄평 개수
	@Override
	public String reviewCount(String user_id) {
		String reviewCount = sqlsession.selectOne("watcha.reviewCount", user_id);
		return reviewCount;
	}

	// 컬렉션 개수
	@Override
	public String collectionCount(String user_id) {
		String collectionCount = sqlsession.selectOne("watcha.collectionCount", user_id);
		return collectionCount;
	}

	// 회원이 평가한 영화 전체
	@Override
	public List<Map<String, String>> ratingMovies(String user_id) {
		List<Map<String, String>> ratingMoviesList = sqlsession.selectList("watcha.ratingMovies", user_id);
		return ratingMoviesList;
	}
	
	// 회원의 한줄평 - 한줄평 8개씩 페이징 처리
	@Override
	public List<Map<String, String>> myReviewPaging(Map<String, String> paraMap) {
	    List<Map<String, String>> myReviewList = sqlsession.selectList("watcha.myReviewPaging", paraMap);
		return myReviewList;
	}

	// 회원이 평가한 영화 - 10개씩 페이징 처리
	@Override
	public List<Map<String, String>> rateMoviesPaging(Map<String, String> paraMap) {
	    List<Map<String, String>> rateMoviesList = sqlsession.selectList("watcha.rateMoviesPaging", paraMap);
		return rateMoviesList;
	}

	// 영화별 유저들 한줄평 - 6개씩 페이징 처리
	@Override
	public List<Map<String, String>> movieReviewPaging(Map<String, String> paraMap) {
		List<Map<String, String>> reviewList = sqlsession.selectList("watcha.movieReviewPaging", paraMap);
		return reviewList;
	}

}
