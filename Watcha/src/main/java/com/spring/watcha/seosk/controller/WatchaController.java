package com.spring.watcha.seosk.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
			request.setAttribute("ratingFiveList", ratingFiveList);
			request.setAttribute("userInfo", userInfo);
			request.setAttribute("reviewCount", reviewCount);
			request.setAttribute("ratingMoviesList", ratingMoviesList);
			request.setAttribute("userPhotoTicketList", userPhotoTicketList);
			request.setAttribute("photoTicketCount", userPhotoTicketList.size());
			request.setAttribute("genreList", genreList);
			
			return "myWatcha/myWatcha.tiles";
			// /WEB-INF/views/myWatcha/myWatcha.jsp
		}
		else { // 링크 클릭이 아니라 잘못된 URL 을 입력한 경우
			request.setAttribute("message", "잘못된 접근입니다.");
			request.setAttribute("loc", "javascript:history.back()");
			return "msg"; // /WEB-INF/views/msg.jsp
		}
	}

	// === 내 한줄평 - 한줄평 4개씩 페이징 처리(Ajax) === //
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
		
		int sizePerPage = 4; // 한번에 보여주는 한줄평 개수(4개)
		
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
		
		int sizePerPage = 4; // 한번에 보여주는 한줄평 개수(4개)

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
	    		jsonObj.put("rating_date", rateMovie.get("rating_date"));
	    		
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
	@RequestMapping(value="/updateReviewComment.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String updateReviewComment(HttpServletRequest request, ReviewCommentVO rcvo) {
		
		int n = service.updateReviewComment(rcvo);

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
	
	// === 검색결과 엑셀파일로 다운받기 === //
	@RequestMapping(value="/myWatcha/downloadExcel.action", method= {RequestMethod.POST})
	public String downloadExcelFile(HttpServletRequest request, Model model) {
		
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
		
		// 먼저 pom.xml 에서 poi-ooxml-schemas, poi-ooxml, poi 를 porting 해줘야 한다.
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		// *** 1. 시트 생성하기
		SXSSFSheet sheet = workbook.createSheet(loginuser.getName()+"님의 검색결과 세부정보");

		sheet.setColumnWidth(0, 6000);
		sheet.setColumnWidth(1, 6000);
		sheet.setColumnWidth(2, 2000);
		sheet.setColumnWidth(3, 4000);
		
		// *** 2. 행 생성하기
		int rowLocation = 0; // 행의 위치를 나타내는 변수
		
		// *** 3. 셀 생성하기
		
		// *** 3-1) 셀 서식(CellStyle) 설정하기
		// *** (1) CellStyle 정렬하기(Alignment)
		// CellStyle 객체를 생성하여 Alignment 세팅하는 메소드를 호출해서 인자값을 넣어준다.
		CellStyle mergeRowStyle = workbook.createCellStyle();
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER); 	  // 가로 가운데정렬
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER); // 세로 가운데정렬
		// import org.apache.poi.ss.usermodel.VerticalAlignment 으로 해야함.
		
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);		// 가로 가운데정렬
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER); // 세로 가운데정렬
		
		// *** (2) CellStyle 배경색(ForegroundColor)만들기
		// setFillForegroundColor 메소드에 IndexedColors Enum인자를 사용한다. IndexedColors.색깔.getIndex() 은 색상의 인덱스값을 리턴한다.
		// setFillPattern은 해당 색을 어떤 패턴으로 입힐지를 정한다.
		headerStyle.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.getIndex()); // 색상(연한회색)
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		// *** (3) CellStyle 천단위 쉼표, 금액
		CellStyle moneyStyle = workbook.createCellStyle();
		moneyStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		
		// *** (4) Cell 폰트(Font) 설정하기
		// 폰트 적용을 위해 POI 라이브러리의 Font 객체를 생성해준다.
		// 해당 객체의 세터를 사용해 폰트의 글씨체, 크기, 색상, 굵기를 설정해준다. 그리고 CellStyle의 setFont 메소드를 사용해 인자로 폰트를 넣어준다.
		Font mergeRowFont = workbook.createFont(); // import org.apache.poi.ss.usermodel.Font; 으로 한다.
		mergeRowFont.setFontName("나눔고딕");
		mergeRowFont.setFontHeight((short)500);
		mergeRowFont.setColor(IndexedColors.CORAL.getIndex());
		mergeRowFont.setBold(true);
		
		mergeRowStyle.setFont(mergeRowFont);

		Font headerFont = workbook.createFont(); // import org.apache.poi.ss.usermodel.Font; 으로 한다.
		headerFont.setFontName("나눔고딕");
		headerFont.setColor(IndexedColors.WHITE.getIndex());
		
		headerStyle.setFont(headerFont);
		
		// *** (5) CellStyle 테두리 Border
		// setBorderTop, Bottom, Left, Right 메소드와 인자로 POI라이브러리의 BorderStyle 인자를 넣어서 테두리(각 셀마다 상하좌우) 적용한다.
		mergeRowStyle.setBorderTop(BorderStyle.THIN);
		mergeRowStyle.setBorderBottom(BorderStyle.THIN);
		mergeRowStyle.setBorderLeft(BorderStyle.THIN);
		mergeRowStyle.setBorderRight(BorderStyle.THIN);
		
		headerStyle.setBorderTop(BorderStyle.THIN);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		
		// *** 3-2) 제목 cell 생성하기 - Cell Merge 셀 병합시키기
		// 셀병합은 시트의 addMergeRegion 메소드에 CellRangeAddress 객체를 인자로 하여 병합시킨다.
		// CellRangeAddress 생성자의 인자로(시작 행, 끝 행, 시작 열, 끝 열) 순서대로 넣어서 병합시킬 범위를 정한다. 배열처럼 시작은 0 부터이다.  
		
		// *** (1) 병합할 행 만들기
		Row mergeRow = sheet.createRow(rowLocation); // 행의 위치를 나타내는 변수 rowLocation (초기값 0, 엑셀에서 행의 시작은 0)을 넣어준다.
		
		// *** (2) 병합할 행에 "검색결과 세부정보" 로 셀(4개)을 만들어 셀에 스타일 주기
		for(int i=0; i<4; i++) {
			Cell cell = mergeRow.createCell(i); // 한 개의 셀 생성하기
			cell.setCellStyle(mergeRowStyle);   // mergeRowStyle 로 설정한 셀 스타일 적용하기
			cell.setCellValue(loginuser.getName()+"님의 검색결과 세부정보");  // 셀에 값 넣어주기
		} // end of for
		
		// *** (3) 셀 병합하기
		sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 3)); 
		// 병합할 셀의 영역(시작 행, 끝 행, 시작 열, 끝 열)을 설정한다. ==> 여기서는 첫번째 행의 0~3열까지를 합친다.
		
		// *** 3-3) 헤더 cell 생성하기
		Row headerRow = sheet.createRow(++rowLocation); // 엑셀에서 행은 1 부터 시작한다. (전위연산자를 사용해야 한다!!!)

		// *** (1) 해당 행의 열 cell 생성하기 (엑셀에서 열은 0 부터 시작한다.)
        Cell headerCell = headerRow.createCell(0); // 해당 행의 첫번째 열 셀 생성
        headerCell.setCellValue("영화제목");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(1); // 해당 행의 두번째 열 셀 생성
        headerCell.setCellValue("장르");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(2); // 해당 행의 세번째 열 셀 생성
        headerCell.setCellValue("별점");
        headerCell.setCellStyle(headerStyle);
        
        headerCell = headerRow.createCell(3); // 해당 행의 네번째 열 셀 생성
        headerCell.setCellValue("관람일자");
        headerCell.setCellStyle(headerStyle);
        
		// *** 4. 검색결과 내용에 해당하는 행 및 셀 생성하기
        Row bodyRow = null;
        Cell bodyCell = null;
        
        for(int i=0; i<searchList.size(); i++) {
        	Map<String, String> searchMap = searchList.get(i); // 검색조건에 맞는 영화의 데이터 행을 하나씩 꺼내어 내용 cell 에 넣어준다.
   
        	bodyRow = sheet.createRow(i + (rowLocation+1)); // 행생성
   
        	bodyCell = bodyRow.createCell(0); // 해당 행의 첫번째 열 셀 생성
        	bodyCell.setCellValue(searchMap.get("movie_title")); // 데이터 영화제목 표시
   
        	bodyCell = bodyRow.createCell(1); // 해당 행의 두번째 열 셀 생성
        	bodyCell.setCellValue(searchMap.get("genre_name")); // 데이터 장르 표시
		              
        	bodyCell = bodyRow.createCell(2); // 해당 행의 세번째 열 셀 생성
        	bodyCell.setCellValue(searchMap.get("rating")); // 데이터 별점 표시
		   
        	bodyCell = bodyRow.createCell(3); // 해당 행의 네번째 열 셀 생성
        	bodyCell.setCellValue(searchMap.get("watching_date")); // 데이터 관람일자 표시
        } // end of for
		
        model.addAttribute("locale", Locale.KOREA); 	// 엑셀에서 한글이 깨지지않도록 방지하는 것이다.
        model.addAttribute("workbook", workbook); 		// 엑셀파일
        model.addAttribute("workbookName", loginuser.getName()+"님의 검색결과 세부정보"); // 엑셀파일명
        
		return "excelDownloadView"; // "excelDownloadView" 은 servlet-context.xml 파일에서 기술된 bean 의 id 값이다.    
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

	// === 장르별 추천영화 전체보기 페이지 요청(view단 페이지) === //
	@RequestMapping(value="/myWatcha/preference.action")
	public ModelAndView preference(ModelAndView mav, HttpServletRequest request) {

		String genre_id = request.getParameter("genre_id");
		String genre_name = "";
		
		List<GenreVO> genreList = service.genreInfo();
    	for(GenreVO genre : genreList) {
    		if(genre_id.equals(genre.getGenre_id())) {
    			genre_name = genre.getGenre_name();
    			break;
    		}
    	} // end of for

    	if(genre_name != "") { // 존재하는 genre_id 를 입력한 경우
			mav.addObject("genre_id", genre_id);
			mav.addObject("genre_name", genre_name);
			mav.setViewName("myWatcha/preference.tiles"); // /WEB-INF/views/myWatcha/preference.jsp
    	}
		else { // 링크 클릭이 아니라 잘못된 URL 을 입력한 경우
			mav.addObject("message", "잘못된 접근입니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg"); // /WEB-INF/views/msg.jsp
		}
		
		return mav;
	}
	
	// === 장르별 영화 전체 - 10개씩 페이징 처리(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/viewMoviesByGenre.action", produces="text/plain;charset=UTF-8")
	public String viewMoviesByGenre(HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String user_id = "";
		if(loginuser != null) {
			user_id = loginuser.getUser_id();
		}

		// *** 페이징 처리 - 현재 페이지
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String genre_id = request.getParameter("genre_id");
		String orderByRating = request.getParameter("orderByRating"); 	// 별점순 정렬(높은순, 낮은순)
		String orderByRelease = request.getParameter("orderByRelease"); // 개봉일자순 정렬(최신순, 오래된순)
		
		// 장르별 영화개수 알아오기
		int totalCount = service.movieCountByGenre(genre_id);
		
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
		
		int sizePerPage = 10; // 한번에 보여주는 장르별 영화 개수(10개 - 5개씩 2행)
		
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // currentShowPageNo 의 시작 행번호
	    int endRno = startRno + sizePerPage - 1;					// currentShowPageNo 의 끝 행번호
		
	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("user_id", user_id);
	    paraMap.put("genre_id", genre_id);
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    paraMap.put("orderByRating", orderByRating);
	    paraMap.put("orderByRelease", orderByRelease);
	    		
		// *** 현재 페이지에 해당하는 장르별 영화List 가져오기
	    List<Map<String, String>> moviesByGenreList = service.moviesByGenrePaging(paraMap);

	    JSONArray jsonArr = new JSONArray();
	    if(moviesByGenreList != null) {
	    	for(Map<String, String> moviesByGenre : moviesByGenreList) {
	    		JSONObject jsonObj = new JSONObject();
	    		jsonObj.put("movie_id", moviesByGenre.get("movie_id"));
	    		jsonObj.put("movie_title", moviesByGenre.get("movie_title"));
	    		jsonObj.put("poster_path", moviesByGenre.get("poster_path"));
	    		jsonObj.put("rating_avg", moviesByGenre.get("rating_avg"));
	    		jsonObj.put("release_date", moviesByGenre.get("release_date"));
	    		
	    		jsonArr.put(jsonObj);
	    	} // end of for
	    }
		return jsonArr.toString();
	}
	
	// === 유저들의 별점평가 차트 데이터 가져오기(Ajax) === //
	@ResponseBody
	@RequestMapping(value="/myWatcha/showRatingChart.action", produces="text/plain;charset=UTF-8")
	public String showRatingChart(HttpServletRequest request) {
		
		String movie_id = request.getParameter("movie_id");
		
		Map<String, String> userRating = service.userRating(movie_id);
		
		JSONObject jsonObj = new JSONObject();
		if(userRating != null && userRating.size() > 0) {
    		jsonObj.put("point05", userRating.get("point05"));
    		jsonObj.put("point10", userRating.get("point10"));
    		jsonObj.put("point15", userRating.get("point15"));
    		jsonObj.put("point20", userRating.get("point20"));
    		jsonObj.put("point25", userRating.get("point25"));
    		jsonObj.put("point30", userRating.get("point30"));
    		jsonObj.put("point35", userRating.get("point35"));
    		jsonObj.put("point40", userRating.get("point40"));
    		jsonObj.put("point45", userRating.get("point45"));
    		jsonObj.put("point50", userRating.get("point50"));
	    }
	    
		return jsonObj.toString();
	}

}
