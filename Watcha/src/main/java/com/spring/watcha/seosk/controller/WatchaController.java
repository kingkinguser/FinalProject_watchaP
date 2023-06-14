package com.spring.watcha.seosk.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.watcha.common.FileManager;
import com.spring.watcha.model.GenreVO;
import com.spring.watcha.model.MovieReviewVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.MemberVO;
import com.spring.watcha.model.MovieDiaryVO;
import com.spring.watcha.model.ReviewCommentVO;
import com.spring.watcha.seosk.service.InterWatchaService;

@Controller
public class WatchaController {

	@Autowired
	private InterWatchaService service;

	// === 마이왓챠 페이지 요청(view단 페이지) === //
	@RequestMapping(value="/myWatcha.action")
	public String myWatcha(HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		if(loginuser != null) {
			String user_id = loginuser.getUser_id();
	
			// *** 1. 마이왓챠 기본정보
			// 최근 평가한 영화 5개(프로필배경)
			List<MovieVO> ratingFiveList = service.ratingFive(user_id);
	
			// 평균 별점, 평가한 영화개수
			Map<String, String> userInfo = service.userInfo(user_id);
			
			// 한줄평 개수
			int reviewCount = service.reviewCount(user_id);
			
			// *** 2. 평가한 영화 - 평가한 영화 전체
			List<Map<String, String>> ratingMoviesList = service.ratingMovies(user_id);
			
			// *** 3. 무비다이어리 - 포토티켓List 가져오기
			List<Map<String, String>> userPhotoTicketList = service.userPhotoTicket(user_id);
			
			// *** 4. 검색하기 - 모든 종류의 장르 가져오기
			List<GenreVO> genreList = service.genreInfo();
	
			// 추후 수정예정
			// 로그인한 회원이 해당 영화에 대해 작성한 한줄평 유무 및 한줄평 정보
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("user_id", user_id);
			paraMap.put("movie_id", "290859"); // 수정예정 - 페이지 합치기 전 movie_id 만 넘겨준 것
			
			Map<String, String> reviewInfo = null;
			if(user_id != null) {
				reviewInfo = service.reviewInfo(paraMap);
			}
	
			request.setAttribute("ratingFiveList", ratingFiveList);
			request.setAttribute("userInfo", userInfo);
			request.setAttribute("reviewCount", reviewCount);
			request.setAttribute("ratingMoviesList", ratingMoviesList);
			request.setAttribute("userPhotoTicketList", userPhotoTicketList);
			request.setAttribute("photoTicketCount", userPhotoTicketList.size());
			request.setAttribute("genreList", genreList);
	
			request.setAttribute("reviewInfo", reviewInfo);
			
			return "myWatcha/myWatcha.tiles";
			// /WEB-INF/views/myWatcha/myWatcha.jsp
		}
		else { // 링크 클릭이 아니라 잘못된 URL 을 입력한 경우
			request.setAttribute("message", "잘못된 접근입니다.");
			request.setAttribute("loc", "javascript:history.back()");
			return "msg"; // /WEB-INF/views/msg.jsp
		}
	}

	// === 내 한줄평 - 한줄평 8개씩 페이징 처리(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/myReviewPaging.action", produces="text/plain;charset=UTF-8")
	public String myReviewPaging(HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.getUser_id();

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
	    		
		// *** 현재 페이지에 해당하는 한줄평List 가져오기
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

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.getUser_id();

		// *** 페이징 처리 - 현재 페이지
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
	@RequestMapping(value="/myWatcha/rateMovies.action")
	public String rateMovies(HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		if(loginuser != null) {
			String user_id = loginuser.getUser_id();

			// 회원정보, 평균 별점, 평가한 영화개수, 한줄평 개수, 컬렉션 개수
			Map<String, String> userInfo = service.userInfo(user_id);
			request.setAttribute("userInfo", userInfo);
			
			return "myWatcha/rateMovies.tiles";
			// /WEB-INF/views/myWatcha/rateMovies.jsp
		}
		else { // 링크 클릭이 아니라 잘못된 URL 을 입력한 경우
			request.setAttribute("message", "잘못된 접근입니다.");
			request.setAttribute("loc", "javascript:history.back()");
			return "msg"; // /WEB-INF/views/msg.jsp
		}
	}
	
	// === 평가한 영화 전체 - 10개씩 페이징 처리(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/viewRateMovies.action", produces="text/plain;charset=UTF-8")
	public String viewRateMovies(HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.getUser_id();

		// *** 페이징 처리 - 현재 페이지
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String order = request.getParameter("order");
		
		// 평가한 영화개수 알아오기
		Map<String, String> userInfo = service.userInfo(user_id);
		int totalCount = Integer.parseInt(userInfo.get("rating_count"));
		
		int currentShowPageNo = 0;
		try {
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

			if(str_currentShowPageNo == null || currentShowPageNo <= 0) {
				currentShowPageNo = 1;
			}
			else if(currentShowPageNo > totalCount) {
				currentShowPageNo = totalCount;
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
	    paraMap.put("order", order);
	    		
		// *** 현재 페이지에 해당하는 평가영화List 가져오기
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
	
	// === 영화별 유저들 한줄평 보여주기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/movieReview.action", produces="text/plain;charset=UTF-8")
	public String movieReview(HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		String user_id = "";
		if(loginuser != null) {
			user_id = loginuser.getUser_id();
		}
		
		String movie_id = request.getParameter("movie_id");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("user_id", user_id);
		paraMap.put("movie_id", movie_id);

		// *** 페이징 처리 - 현재 페이지
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(str_currentShowPageNo == null) { // 한줄평(카드 캐러셀)
			paraMap.put("startRno", "");
			paraMap.put("endRno", "");
		}
		else { // 한줄평 전체보기
			int currentShowPageNo = 0;
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

				if(str_currentShowPageNo == null || currentShowPageNo <= 0) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
			
			int sizePerPage = 6; // 한번에 보여주는 한줄평 개수(6개 - 3개씩 2행)
			
			int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // currentShowPageNo 의 시작 행번호
		    int endRno = startRno + sizePerPage - 1;					// currentShowPageNo 의 끝 행번호

		    paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
		}
		
		// *** 현재 페이지에 해당하는 한줄평List 가져오기
		List<Map<String, String>> reviewList = service.movieReviewPaging(paraMap);
	    
		JSONArray jsonArr = new JSONArray();
	    if(reviewList != null && reviewList.size() > 0) {
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
	    		jsonObj.put("name", review.get("name"));
	    		jsonObj.put("rating", review.get("rating"));
	    		jsonObj.put("like_review", review.get("like_review"));
	    		
	    		jsonArr.put(jsonObj);
	    	} // end of for
	    }
		return jsonArr.toString();
	}

	// === 영화별 유저들 한줄평 전체보기 페이지 요청(view단 페이지) === //
	@RequestMapping(value="/allReview.action")
	public ModelAndView allComment(ModelAndView mav, HttpServletRequest request) {
		
		// 한줄평 - 영화에 대한 정보(별점개수, 별점평균 포함)
		String movie_id = request.getParameter("movie_id");
		
		if(movie_id != null) {
			MovieVO movieInfo = service.movieInfo(movie_id);
			
			if(movieInfo != null) {
				mav.addObject("movieInfo", movieInfo);
				mav.setViewName("myWatcha/allReview.tiles"); // /WEB-INF/views/myWatcha/allReview.jsp
			}
			else { // 링크 클릭이 아니라 잘못된 URL 을 입력한 경우
				mav.addObject("message", "잘못된 접근입니다.");
				mav.addObject("loc", "javascript:history.back()");
				mav.setViewName("msg"); // /WEB-INF/views/msg.jsp
			}
		}
		else { // 링크 클릭이 아니라 잘못된 URL 을 입력한 경우
			mav.addObject("message", "잘못된 접근입니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg"); // /WEB-INF/views/msg.jsp
		}
		
		return mav;
	}
	
	
	// === 영화별 유저들 한줄평 페이지바 보여주기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/userReviewCount.action", produces="text/plain;charset=UTF-8")
	public String userReviewCount(HttpServletRequest request) {
		
		// *** 페이징 처리 - 현재 페이지
		String movie_id = request.getParameter("movie_id");
		
		JSONObject jsonObj = new JSONObject();
	    int totalCount = service.userReviewCount(movie_id);
	    jsonObj.put("totalCount", totalCount);
	    
		return jsonObj.toString();
	}
	
	// === 영화별 한줄평 한개의 댓글 보여주기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/reviewComment.action", produces="text/plain;charset=UTF-8")
	public String reviewComment(HttpServletRequest request) {
	
		String review_id = request.getParameter("review_id");
		
		// *** 해당 한줄평에 달린 댓글List 가져오기
		List<Map<String, String>> commentList = service.commentList(review_id);
		
		JSONArray jsonArr = new JSONArray();
	    if(commentList != null && commentList.size() > 0) {
    		for(Map<String, String> comment : commentList) {
	    		JSONObject jsonObj = new JSONObject();
	    		jsonObj.put("comment_id", comment.get("comment_id"));
	    		jsonObj.put("review_id", comment.get("review_id"));
	    		jsonObj.put("user_id", comment.get("user_id"));
	    		jsonObj.put("profile_image", comment.get("profile_image"));
	    		jsonObj.put("name", comment.get("name"));
	    		jsonObj.put("content", comment.get("content"));
	    		jsonObj.put("comment_date", comment.get("comment_date"));
	    		
	    		jsonArr.put(jsonObj);
	    	} // end of for
	    }
		return jsonArr.toString();
	}

	
	// === 한줄평 추가(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/addReview.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String addReview(HttpServletRequest request, MovieReviewVO mrvo) {
		
		if(mrvo.getSpoiler_status() == null) {
			mrvo.setSpoiler_status("0");			
		}
		
		int n = service.addReview(mrvo);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// === 한줄평 삭제(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/deleteReview.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String deleteReview(HttpServletRequest request) {
		
		String review_id = request.getParameter("review_id");
		
		int n = service.deleteReview(review_id);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// === 한줄평 수정(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/updateReview.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String updateReview(HttpServletRequest request, MovieReviewVO mrvo) {

		if(mrvo.getSpoiler_status() == null) {
			mrvo.setSpoiler_status("0");			
		}

		int n = service.updateReview(mrvo);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// === 한줄평에 좋아요 체크 또는 체크해제(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/reviewLike.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String reviewLike(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.getUser_id();

		String review_id = request.getParameter("review_id");
		String like_review = request.getParameter("like_review");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("user_id", user_id);
		paraMap.put("review_id", review_id);
		
		int n = 0;
		if("true".equals(like_review)) { // 좋아요 insert
			n = service.addReviewLike(paraMap);
		}
		else { // 좋아요 delete
			n = service.delReviewLike(paraMap);
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}

	// === 한줄평에 댓글달기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/addComment.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String addComment(HttpServletRequest request, ReviewCommentVO rcvo) {
		
		int n = service.addComment(rcvo);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// === 한줄평에 달린 댓글 수정(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/updateComment.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String updateComment(HttpServletRequest request, ReviewCommentVO rcvo) {
		
		int n = service.updateComment(rcvo);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// === 한줄평에 달린 댓글 삭제(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/deleteComment.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String deleteComment(HttpServletRequest request, ReviewCommentVO rcvo) {
		
		int n = service.deleteComment(rcvo);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// === 검색결과 보여주기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/searchResult.action", produces="text/plain;charset=UTF-8")
	public String viewSearch(HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.getUser_id();

		String searchWord = request.getParameter("searchWord");
		String str_genre_id = request.getParameter("str_genre_id");
		String str_rating = request.getParameter("str_rating");
		String from_watching_date = request.getParameter("from_watching_date");
		String to_watching_date = request.getParameter("to_watching_date");
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("user_id", user_id);
		paraMap.put("from_watching_date", from_watching_date);
		paraMap.put("to_watching_date", to_watching_date);
		
		if(searchWord == null) {
			searchWord = "";
		}
		paraMap.put("searchWord", searchWord);

		if(str_genre_id != null && !"".equals(str_genre_id)) {
			String[] arr_genre_id = str_genre_id.split("\\,");
			paraMap.put("arr_genre_id", arr_genre_id);
		}
		if(str_rating != null && !"".equals(str_rating)) {
			String[] arr_rating = str_rating.split("\\,");
			paraMap.put("arr_rating", arr_rating);
		}
		
		// 검색조건에 해당하는 검색결과List 가져오기
		List<Map<String, String>> searchList = service.searchResult(paraMap);
		
		JSONArray jsonArr = new JSONArray();
	    if(searchList != null && searchList.size() > 0) {
    		for(Map<String, String> search : searchList) {
	    		JSONObject jsonObj = new JSONObject();
	    		jsonObj.put("movie_id", search.get("movie_id"));
	    		jsonObj.put("movie_title", search.get("movie_title"));
	    		jsonObj.put("genre_name", search.get("genre_name"));
	    		jsonObj.put("rating", search.get("rating"));
	    		jsonObj.put("watching_date", search.get("watching_date"));
	    		
	    		jsonArr.put(jsonObj);
	    	} // end of for
	    }
		return jsonArr.toString();
	}
		
	// === 검색상세 페이지 요청(view단 페이지) === //
	@RequestMapping(value="/myWatcha/searchDetail.action")
	public ModelAndView searchDetail(ModelAndView mav, HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
			String user_id = loginuser.getUser_id();
	
			String movie_id = request.getParameter("movie_id");
	
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("user_id", user_id);
			paraMap.put("movie_id", movie_id);
			
			if(movie_id != null) {
				mav.setViewName("myWatcha/searchDetail.tiles"); // /WEB-INF/views/myWatcha/searchDetail.jsp
	
				// 검색상세 - 영화정보(장르포함), 무비다이어리 가져오기
				Map<String, String> searchDetail = service.searchDetail(paraMap);
				
				if(searchDetail != null && searchDetail.size() > 0) {
					
					// 해당 영화의 한줄평 및 한줄평에 달린 댓글 가져오기
					MovieReviewVO searchReview = service.searchReview(paraMap);
					if(searchReview != null) {
						mav.addObject("searchReview", searchReview);
					}
					mav.addObject("searchDetail", searchDetail);
					mav.setViewName("myWatcha/searchDetail.tiles"); // /WEB-INF/views/myWatcha/searchDetail.jsp
				}
				else { // 링크 클릭이 아니라 잘못된 URL 을 입력한 경우
					mav.addObject("message", "잘못된 접근입니다.");
					mav.addObject("loc", "javascript:history.back()");
					mav.setViewName("msg"); // /WEB-INF/views/msg.jsp
				}
			}
			else { // 링크 클릭이 아니라 잘못된 URL 을 입력한 경우
				mav.addObject("message", "잘못된 접근입니다.");
				mav.addObject("loc", "javascript:history.back()");
				mav.setViewName("msg"); // /WEB-INF/views/msg.jsp
			}
		}
		else { // 링크 클릭이 아니라 잘못된 URL 을 입력한 경우
			mav.addObject("message", "잘못된 접근입니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg"); // /WEB-INF/views/msg.jsp
		}
			
		return mav;
	}

	// === 별점평가 등록하기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/registerRating.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String registerRating(HttpServletRequest request) {
	
		String movie_id = request.getParameter("movie_id");
		String user_id = request.getParameter("user_id");
		String rating = request.getParameter("rating");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("movie_id", movie_id);
		paraMap.put("user_id", user_id);
		paraMap.put("rating", rating);
		
		int n = service.registerRating(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// === 별점평가 수정하기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/updateRating.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String updateRating(HttpServletRequest request) {
	
		String movie_id = request.getParameter("movie_id");
		String user_id = request.getParameter("user_id");
		String rating = request.getParameter("rating");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("movie_id", movie_id);
		paraMap.put("user_id", user_id);
		paraMap.put("rating", rating);
		
		int n = service.updateRating(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	@Autowired 
	private FileManager fileManager;

	// === 포토티켓 등록하기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/registerPhoto.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String registerPhoto(MultipartHttpServletRequest mtp_request, MovieDiaryVO diaryvo) {
	
		MultipartFile file_front = mtp_request.getFile("file_front");
		MultipartFile file_back = mtp_request.getFile("file_back");
		
    	// WAS의 webapp 의 절대경로를 알아오기
		HttpSession session = mtp_request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root+"resources"+File.separator+"photoTicket"; // 첨부파일이 업로드될 특정 경로(폴더) 지정하기
		//	/Watcha/src/main/webapp/resources/photoTicket
		
		try { // 첨부파일을 위의 path 경로에 올리기
			String newFileName = ""; 
			byte[] bytes = null; 
			
			bytes = file_front.getBytes(); 
			newFileName = fileManager.doFileUpload(bytes, "photo_front.jpg", path); 
			diaryvo.setPhoto_front(newFileName);

			bytes = file_back.getBytes(); 
			newFileName = fileManager.doFileUpload(bytes, "photo_back.jpg", path); 
			diaryvo.setPhoto_back(newFileName);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		int n = service.registerPhoto(diaryvo);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}

	// === 포토티켓 다운로드하기 === //
	@RequestMapping(value="/myWatcha/downloadPhoto.action", produces="text/plain;charset=UTF-8")
	public void downloadPhoto(HttpServletRequest request, HttpServletResponse response) {
		
		String movie_id = request.getParameter("movie_id"); 
		String user_id = request.getParameter("user_id"); 
		String photo_side = request.getParameter("photo_side"); 
		
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = null; // PrintWriter 객체 out 은 웹브라우저에 기술하는 대상체를 말한다.
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("movie_id", movie_id);
		paraMap.put("user_id", user_id);
		
        try {
			// 무비다이어리에 등록된 포토티켓(앞면, 뒷면) 가져오기
			Map<String, String> searchDetail = service.searchDetail(paraMap);
			
			if(searchDetail != null && searchDetail.get("photo_front") != null) {
				
				String fileName = "";
				String orgFilename = "";
				
				if(photo_side != null && "front".equals(photo_side)) {
					fileName = searchDetail.get("photo_front"); 	  		// WAS(톰캣)에 저장된 파일명
					orgFilename = searchDetail.get("movie_title") + "_앞면.jpg"; // 첨부파일의 파일명
				}
				else if(photo_side != null && "back".equals(photo_side)) {
					fileName = searchDetail.get("photo_back"); 	  			// WAS(톰캣)에 저장된 파일명
					orgFilename = searchDetail.get("movie_title") + "_뒷면.jpg"; // 첨부파일의 파일명
				}
				
				// WAS 의 webapp 의 절대경로를 알아오기
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root+"resources"+File.separator+"photoTicket"; // 첨부파일이 있는 특정 경로(폴더) 지정하기
				//	/Watcha/src/main/webapp/resources/photoTicket
				
				// *** file 다운로드 하기 *** //
				boolean flag = false; // file 다운로드 성공(true), 실패(false)를 알려주는 용도
				flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
				
				if(!flag) {
					out = response.getWriter();
					out.println("<script type='text/javascript'>alert('포토티켓 다운로드에 실패하였습니다.'); history.back();</script>");
				}
			}
			else {
				out = response.getWriter();
				out.println("<script type='text/javascript'>alert('포토티켓 다운로드가 불가합니다.'); history.back();</script>");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// === 무비다이어리 보여주기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/showMovieDiary.action", produces="text/plain;charset=UTF-8")
	public String showMovieDiary(HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.getUser_id();

		// *** 무비다이어리List 가져오기
	    List<Map<String, String>> movieDiaryList = service.showMovieDiary(user_id);

	    JSONArray jsonArr = new JSONArray();
	    if(movieDiaryList != null && movieDiaryList.size() > 0) {
	    	for(Map<String, String> movieDiary : movieDiaryList) {
	    		JSONObject jsonObj = new JSONObject();
	    		jsonObj.put("diary_id", movieDiary.get("diary_id"));
	    		jsonObj.put("movie_id", movieDiary.get("movie_id"));
	    		jsonObj.put("movie_title", movieDiary.get("movie_title"));
	    		jsonObj.put("poster_path", movieDiary.get("poster_path"));
	    		jsonObj.put("watching_date", movieDiary.get("watching_date"));
	    		
	    		jsonArr.put(jsonObj);
	    	} // end of for
	    }
	    
		return jsonArr.toString();
	}
	
	
	// === 무비다이어리(관람일자) 등록하기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/registerDiary.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String registerDiary(HttpServletRequest request, MovieDiaryVO diaryvo) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.getUser_id();
		
		diaryvo.setUser_id(user_id);
		int n = service.registerDiary(diaryvo);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
	    
		return jsonObj.toString();
	}
	
	// === 무비다이어리(관람일자) 수정하기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/updateDiary.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String updateDiary(MovieDiaryVO diaryvo) {
		
		int n = service.updateDiary(diaryvo);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
	    
		return jsonObj.toString();
	}
	
	// === 선호장르 데이터 가져오기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/showPreferenceChart.action", produces="text/plain;charset=UTF-8")
	public String showPreferenceChart(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.getUser_id();
		
		List<Map<String, String>> preferenceList = service.preference(user_id);
		
	    JSONArray jsonArr = new JSONArray();
	    if(preferenceList != null && preferenceList.size() > 0) {
	    	for(Map<String, String> preference : preferenceList) {
	    		JSONObject jsonObj = new JSONObject();
	    		jsonObj.put("rating_genre", preference.get("rating_genre"));
	    		jsonObj.put("genre_id", preference.get("genre_id"));
	    		jsonObj.put("genre_name", preference.get("genre_name"));
	    		
	    		jsonArr.put(jsonObj);
	    	} // end of for
	    }
	    
		return jsonArr.toString();
	}

}
