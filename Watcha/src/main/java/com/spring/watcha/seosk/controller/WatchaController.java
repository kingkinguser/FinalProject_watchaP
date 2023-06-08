package com.spring.watcha.seosk.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.watcha.model.GenreVO;
import com.spring.watcha.model.MovieReviewVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.MemberVO;
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
		String user_id = loginuser.user_id;

		// *** 1. 마이왓챠 기본정보
		// 최근 평가한 영화 5개(프로필배경)
		List<MovieVO> ratingFiveList = service.ratingFive(user_id);

		// 회원정보, 평균 별점, 평가한 영화개수, 한줄평 개수, 컬렉션 개수
		Map<String, String> userInfo = service.userInfo(user_id);
		
		// *** 2. 평가한 영화 - 평가한 영화 전체
		List<Map<String, String>> ratingMoviesList = service.ratingMovies(user_id);
		
		// *** 3. 컬렉션
		
		// *** 4. 검색하기 - 모든 종류의 장르 가져오기
		List<GenreVO> genreList = service.genreInfo();

		// 추후 수정예정
		// 로그인한 회원이 해당 영화에 대해 작성한 한줄평 유무 및 한줄평 정보
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("user_id", user_id);
		paraMap.put("movie_id", "290859"); // 수정예정 - 페이지 합치기 전 movie_id 만 넘겨준 것
		MovieReviewVO reviewInfo = service.reviewInfo(paraMap);

		request.setAttribute("ratingFiveList", ratingFiveList);
		request.setAttribute("userInfo", userInfo);
		request.setAttribute("ratingMoviesList", ratingMoviesList);
		request.setAttribute("genreList", genreList);

		request.setAttribute("reviewInfo", reviewInfo);
		
		return "myWatcha/myWatcha.tiles";
		// /WEB-INF/views/myWatcha/myWatcha.jsp
	}

	// === 내 한줄평 - 한줄평 8개씩 페이징 처리(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/myReviewPaging.action", produces="text/plain;charset=UTF-8")
	public String myReviewPaging(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.user_id;
		
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
		String user_id = loginuser.user_id;

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
	@RequestMapping(value="/rateMovies.action")
	public String rateMovies(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.user_id;

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
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.user_id;
		
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
		
		int sizePerPage = 10; // 한번에 보여주는 평가영화 개수(10개 - 5개씩 2행)
		
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // currentShowPageNo 의 시작 행번호
	    int endRno = startRno + sizePerPage - 1;					// currentShowPageNo 의 끝 행번호
		
	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("user_id", user_id);
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    		
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
	
	// === 영화별 유저들 한줄평 (카드 캐러셀) 페이지 요청(view단 페이지) === //
	@RequestMapping(value="/view/movieReview.action")
	public String movieReviewPage(HttpServletRequest request) {
		
		/*
			삭제예정 - 페이지 합치기 전 movie_id 만 넘겨준 것
		 */
		request.setAttribute("movie_id", "290859");
		
		return "myWatcha/movieReview.tiles";
		// /WEB-INF/views/myWatcha/movieComment.jsp
	}

	// === 영화별 유저들 한줄평 보여주기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/movieReview.action", produces="text/plain;charset=UTF-8")
	public String movieReview(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = loginuser.user_id;
		
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
	    		jsonObj.put("nickname", review.get("nickname"));
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
	    		jsonObj.put("nickname", comment.get("nickname"));
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
		
		System.out.println(mrvo.getSpoiler_status());
		
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
		String user_id = loginuser.user_id;

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
		String user_id = loginuser.user_id;

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
		String user_id = loginuser.user_id;

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
					List<Map<String, String>> commentList = service.commentList(searchReview.getReview_id());
					mav.addObject("searchReview", searchReview);
					mav.addObject("commentList", commentList);
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
		return mav;
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
}
