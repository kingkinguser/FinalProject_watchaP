package com.spring.watcha.seosk.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.watcha.common.MovieVO;
import com.spring.watcha.seosk.model.InterWatchaDAO;

@Service
public class WatchaService implements InterWatchaService {

	@Autowired
	private InterWatchaDAO dao;

	// 마이왓챠 기본정보 - 최근 평가한 영화 5개(프로필 배경에 사용)
	@Override
	public List<MovieVO> ratingFive(String user_id) {
		List<MovieVO> ratingFiveList = dao.ratingFive(user_id);
		if(ratingFiveList.size() < 5) { // 최근 평가한 영화가 5개 미만인 경우, 기본 프로필 배경을 사용한다.
			ratingFiveList = null;
		}
		return ratingFiveList;
	}

	// 마이왓챠 기본정보 - 최근 평가한 영화 5개, 회원정보, 평균 별점, 평가한 영화개수, 한줄평 개수, 컬렉션 개수
	@Override
	public Map<String, String> userInfo(String user_id) {

		// 회원정보, 평균 별점, 평가한 영화개수
		Map<String, String> userInfo = dao.userInfo(user_id);
		
		// 한줄평 개수
		String reviewCount = dao.reviewCount(user_id);
		userInfo.put("reviewCount", reviewCount);
		
		// 컬렉션 개수
		String collectionCount = dao.collectionCount(user_id);
		userInfo.put("collectionCount", collectionCount);
		
		return userInfo;
	}

	// 회원이 평가한 영화 전체
	@Override
	public List<Map<String, String>> ratingMovies(String user_id) {
		List<Map<String, String>> ratingMoviesList = dao.ratingMovies(user_id);
		return ratingMoviesList;
	}
	
	// 회원의 한줄평 - 한줄평 8개씩 페이징 처리
	@Override
	public List<Map<String, String>> myReviewPaging(Map<String, String> paraMap) {
	    List<Map<String, String>> myReviewList = dao.myReviewPaging(paraMap);
		return myReviewList;
	}

	// 한줄평 페이지바 만들기
	@Override
	public String makeReviewPageBar(Map<String, String> paraMap) {
		
		String user_id = paraMap.get("user_id");
		int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
		int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
		
		int totalCount = Integer.parseInt(dao.reviewCount(user_id));
		int totalPage = (int)Math.ceil((double)totalCount/sizePerPage);

		int blockSize = 5; 
		int loop = 1; 
		int pageNo = ((currentShowPageNo - 1)/blockSize)*blockSize + 1;
		// 공식 pageNo = ((currentShowPageNo - 1)/blockSize)*blockSize + 1 을 이용하여 구한다.
		
		String pageBar = "<ul style='list-style: none;'>";
		  
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li><button type='button' onclick='myReviewPaging(1)'>[처음]</button></li>";
			pageBar += "<li><button type='button' onclick='myReviewPaging("+(pageNo-1)+")'>"+(pageNo-1)+"</button></li>";
		}
		  
		while(!(loop > blockSize || pageNo > totalPage)) {
		   if(pageNo == currentShowPageNo) {
		      pageBar += "<li style='color: #ff0558;'><button type='button' onclick='myReviewPaging("+pageNo+")'>"+pageNo+"</button></li>";
		   }
		   else {
			  pageBar += "<li><button type='button' onclick='myReviewPaging("+pageNo+")'>"+pageNo+"</button></li>";
		   }
		   loop++;
		   pageNo++;
		} // end of while
		  
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
		  pageBar += "<li><button type='button' onclick='myReviewPaging("+(pageNo+1)+")'>next</button></li>";
		  pageBar += "<li><button type='button' onclick='myReviewPaging("+totalPage+")'>[마지막]</button></li>"; 
		}
		pageBar += "</ul>";

		return pageBar;
	}

	// 회원이 평가한 영화 - 10개씩 페이징 처리
	@Override
	public List<Map<String, String>> rateMoviesPaging(Map<String, String> paraMap) {
	    List<Map<String, String>> rateMoviesList = dao.rateMoviesPaging(paraMap);
		return rateMoviesList;
	}

	// 영화별 유저들 한줄평 - 6개씩 페이징 처리
	@Override
	public List<Map<String, String>> movieReviewPaging(Map<String, String> paraMap) {
		List<Map<String, String>> reviewList = dao.movieReviewPaging(paraMap);
		return reviewList;
	}

	
}
