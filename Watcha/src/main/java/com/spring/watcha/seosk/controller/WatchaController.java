package com.spring.watcha.seosk.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.watcha.common.MovieVO;
import com.spring.watcha.seosk.service.InterWatchaService;

@Controller
public class WatchaController {

	@Autowired
	private InterWatchaService service;

	// === 마이왓챠 페이지 요청(view단 페이지) === //
	@RequestMapping(value="/myWatcha.action")
	public String myWatcha(HttpServletRequest request) {
		
	/*
		=== 추후 수정 예정 === 
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	*/
		String user_id = "qwer1234";

		// *** 1. 마이왓챠 기본정보
		// 최근 평가한 영화 5개(프로필배경)
		List<MovieVO> ratingFiveList = service.ratingFive(user_id);

		// 회원정보, 평균 별점, 평가한 영화개수, 한줄평 개수, 컬렉션 개수
		Map<String, String> userInfo = service.userInfo(user_id);
		
		// *** 2. 평가한 영화 - 평가한 영화 전체
		List<Map<String, String>> ratingMoviesList = service.ratingMovies(user_id);
		
		request.setAttribute("ratingFiveList", ratingFiveList);
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("ratingMoviesList", ratingMoviesList);
		
		return "myWatcha/myWatcha.tiles";
		// /WEB-INF/views/myWatcha/myWatcha.jsp
	}

	// === 내 한줄평 - 한줄평 8개씩 페이징 처리(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/myReviewPaging.action", produces="text/plain;charset=UTF-8")
	public String myReviewPaging(HttpServletRequest request) {
		
	/*
		=== 추후 수정 예정 === 
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	*/
		String user_id = "qwer1234";
		
		// *** 현재 페이지에 해당하는 한줄평List 가져오기
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		int currentShowPageNo = 0;
		try {
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

			if(str_currentShowPageNo == null || currentShowPageNo <= 0) {
				currentShowPageNo = 1;
			}
		} catch (NumberFormatException e) {
			currentShowPageNo = 1;
		}
		
		int sizePerPage = 8; // 한번에 보여주는 한줄평 개수(8개)
		
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // currentShowPageNo 의 시작 행번호
	    int endRno = startRno + sizePerPage - 1;					// currentShowPageNo 의 끝 행번호
		
	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("user_id", user_id);
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    		
	    List<Map<String, String>> myReviewList = service.myReviewPaging(paraMap);

	    JSONArray jsonArr = new JSONArray();
	    if(myReviewList != null) {
	    	for(Map<String, String> myReview : myReviewList) {
	    		JSONObject jsonObj = new JSONObject();
	    		jsonObj.put("review_id", myReview.get("review_id"));
	    		jsonObj.put("movie_id", myReview.get("movie_id"));
	    		jsonObj.put("movie_title", myReview.get("movie_title"));
	    		jsonObj.put("poster_path", myReview.get("poster_path"));
	    		jsonObj.put("review_content", myReview.get("review_content"));
	    		jsonObj.put("review_date", myReview.get("review_date"));
	    		jsonObj.put("spoiler_status", myReview.get("spoiler_status"));
	    		jsonObj.put("number_of_likes", myReview.get("number_of_likes"));
	    		jsonObj.put("number_of_comments", myReview.get("number_of_comments"));
	    		
	    		jsonArr.put(jsonObj);
	    	} // end of for
	    }

		return jsonArr.toString();
	}


	// === 내 한줄평 - 한줄평 페이지바 만들기 === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/showReviewPageBar.action", produces="text/plain;charset=UTF-8")
	public String showReviewPageBar(HttpServletRequest request) {
		
	/*
		=== 추후 수정 예정 === 
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	*/
		String user_id = "qwer1234";

		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		int currentShowPageNo = 0;
		try {
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

			if(str_currentShowPageNo == null || currentShowPageNo <= 0) {
				currentShowPageNo = 1;
			}
		} catch (NumberFormatException e) {
			currentShowPageNo = 1;
		}
		
		int sizePerPage = 8; // 한번에 보여주는 한줄평 개수(8개)

		// *** 한줄평 페이지바 만들기
	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("user_id", user_id);
	    paraMap.put("sizePerPage", String.valueOf(sizePerPage));
	    paraMap.put("currentShowPageNo", String.valueOf(currentShowPageNo));
	    
		JSONObject jsonObj = new JSONObject();
	    String pageBar = service.makeReviewPageBar(paraMap);
	    jsonObj.put("pageBar", pageBar);
	    
		return jsonObj.toString();
	}	
	
	// === 평가한 영화들 전체보기 페이지 요청(view단 페이지) === //
	@RequestMapping(value="/rateMovies.action")
	public String rateMovies(HttpServletRequest request) {
		
	/*
		=== 추후 수정 예정 === 
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	*/
		String user_id = "qwer1234";

		// 회원정보, 평균 별점, 평가한 영화개수, 한줄평 개수, 컬렉션 개수
		Map<String, String> userInfo = service.userInfo(user_id);
		request.setAttribute("userInfo", userInfo);
		
		return "myWatcha/rateMovies.tiles";
		// /WEB-INF/views/myWatcha/rateMovies.jsp
	}
	
	// === 평가한 영화 전체 - 10개씩 페이징 처리(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/viewRateMovies.action", produces="text/plain;charset=UTF-8")
	public String viewRateMovies(HttpServletRequest request) {
		
	/*
		=== 추후 수정 예정 === 
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	*/
		String user_id = "qwer1234";
		
		// *** 현재 페이지에 해당하는 평가영화List 가져오기
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		int currentShowPageNo = 0;
		try {
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

			if(str_currentShowPageNo == null || currentShowPageNo <= 0) {
				currentShowPageNo = 1;
			}
		} catch (NumberFormatException e) {
			currentShowPageNo = 1;
		}
		
		int sizePerPage = 10; // 한번에 보여주는 평가영화 개수(10개 - 5개씩 2행)
		
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // currentShowPageNo 의 시작 행번호
	    int endRno = startRno + sizePerPage - 1;					// currentShowPageNo 의 끝 행번호
		
	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("user_id", user_id);
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    		
	    List<Map<String, String>> rateMoviesList = service.rateMoviesPaging(paraMap);

	    JSONArray jsonArr = new JSONArray();
	    if(rateMoviesList != null) {
	    	for(Map<String, String> rateMovie : rateMoviesList) {
	    		JSONObject jsonObj = new JSONObject();
	    		jsonObj.put("movie_id", rateMovie.get("movie_id"));
	    		jsonObj.put("movie_title", rateMovie.get("movie_title"));
	    		jsonObj.put("poster_path", rateMovie.get("poster_path"));
	    		jsonObj.put("rating", rateMovie.get("rating"));
	    		
	    		jsonArr.put(jsonObj);
	    	} // end of for
	    }
		return jsonArr.toString();
	}
	
	// === 영화별 유저들 한줄평 (카드 캐러셀) 페이지 요청(view단 페이지) === //
	@RequestMapping(value="view/movieReview.action")
	public String movieReviewPage(HttpServletRequest request) {
		
		/*
			삭제예정 - 페이지 합치기 전 movie_id 만 넘겨준 것
		 */
		request.setAttribute("movie_id", "290859");
		
		return "myWatcha/movieReview.tiles";
		// /WEB-INF/views/myWatcha/movieComment.jsp
	}

	// === 영화별 유저들 한줄평 (카드 캐러셀) 보여주기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/movieReview.action")
	public String movieReview(HttpServletRequest request) {
		
		String movie_id = request.getParameter("movie_id");
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("movie_id", movie_id);
		
		List<Map<String, String>> reviewList = service.movieReviewPaging(paraMap);
	    
		JSONArray jsonArr = new JSONArray();
	    if(reviewList != null) {
	    	for(Map<String, String> review : reviewList) {
	    		JSONObject jsonObj = new JSONObject();
	    		jsonObj.put("review_id", review.get("review_id"));
	    		jsonObj.put("movie_id", review.get("movie_id"));
	    		jsonObj.put("review_content", review.get("review_content"));
	    		jsonObj.put("review_date", review.get("review_date"));
	    		jsonObj.put("spoiler_status", review.get("spoiler_status"));
	    		jsonObj.put("number_of_likes", review.get("number_of_likes"));
	    		jsonObj.put("number_of_comments", review.get("number_of_comments"));
	    		jsonObj.put("user_id", review.get("user_id"));
	    		jsonObj.put("profile_image", review.get("profile_image"));
	    		jsonObj.put("nickname", review.get("nickname"));
	    		jsonObj.put("rating", review.get("rating"));
	    		
	    		jsonArr.put(jsonObj);
	    	} // end of for
	    }
		return jsonArr.toString();
	}

	// === 영화별 유저들 한줄평 전체보기 페이지 요청(view단 페이지) === //
	@RequestMapping(value="/allReview.action")
	public String allComment() {
		
		return "myWatcha/allReview.tiles";
		// /WEB-INF/views/myWatcha/allReview.jsp
	}

	// === 검색상세 페이지 요청(view단 페이지) === //
	@RequestMapping(value="/searchDetail.action")
	public String searchDetail() {
		
		return "myWatcha/searchDetail.tiles";
		// /WEB-INF/views/myWatcha/searchDetail.jsp
	}

	
}
