package com.spring.watcha.mindh.controller;

import java.util.ArrayList;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.spring.watcha.model.ActorVO;
import com.spring.watcha.model.GenreVO;
import com.spring.watcha.model.MemberVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.Star_ratingVO;
import com.spring.watcha.model.collection_movieVO;

@Controller
public class WatchaController {

	@Autowired 
	private com.spring.watcha.mindh.service.InterWatchaService service ; 
	
	
	// header 검색어 자동완성
	@ResponseBody
	@RequestMapping(value="/searchword.action", method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String searchword(HttpServletRequest request) {

	    String searchWord = request.getParameter("searchWord");
	    String switchValues = request.getParameter("switchValue");
	    int switchValue = Integer.parseInt(switchValues);
	    
	    HttpSession session = request.getSession();
	    //System.out.println(switchValue+"호호호");
	    //System.out.println("Received searchWord: " + searchWord);
	    
	    if (switchValue == 1){
	    	
		    // ajax 를 사용했으므로 
	    	JSONObject jsonObj = new JSONObject();
	    	jsonObj.put("switchValue", switchValue);

	        return jsonObj.toString();
	    }
	    else {
	    	//System.out.println("여기야!!");
	    	Map<String, String> paraMap = new HashMap<>();

		    paraMap.put("searchWord", searchWord);

		    List<String> wordList = service.searchword(paraMap);

		    
		    // ajax 를 사용했으므로 
		    JSONArray jsonArr = new JSONArray();

		    // 리스트가 존재한다면 실행 
		    if(wordList != null) {
		        for(String word : wordList) {
		            JSONObject jsonObj = new JSONObject();
		            jsonObj.put("word", word);

		            jsonArr.put(jsonObj);
		        }// end of for 믄 
		    }
		    return jsonArr.toString();
	    }
	    
	}
	
	

	
	// header 검색어 부분 
	@RequestMapping(value="/goSearch.action")
	public ModelAndView goSearch(ModelAndView mav, HttpServletRequest request) {
		
		String searchWord = request.getParameter("searchWord");
		//System.out.println(searchWord);
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("searchWord",searchWord);
		
		String[] searchWords = service.goSearch(request, paraMap);
		 
		String lastSearchWord = searchWords[searchWords.length - 1];
		//System.out.println(lastSearchWord);
		
		
	    List<String> recentSearchWords = new ArrayList<>();

	    if (searchWords != null) {
	        int startIndex = Math.max(0, searchWords.length - 5);
	        int endIndex = searchWords.length;

	        for (int i = startIndex; i < endIndex; i++) {
	            recentSearchWords.add(searchWords[i]);
	        }
	        Collections.reverse(recentSearchWords); // 최근 검색어를 내림차순으로 정렬
	    }

	    String recentSearchWordsString = String.join(",", recentSearchWords);
	    recentSearchWordsString = recentSearchWordsString.replaceAll("\\[|\\]", "");
	 	    
	    // 처음에 콘텐츠를 검색하는 것이므로 영화를 보여준다.
	    List<MovieVO> showMovie = service.showMovie(paraMap);
	    
	    
	    
		
		mav.addObject("recentSearchWords", recentSearchWordsString);
		mav.addObject("lastSearchWord", lastSearchWord);
		mav.addObject("showMovie", showMovie);
		mav.setViewName("/searchWord.tiles");    // 검색했을때 넘어가는 페이지 
		
		return mav;
		
	}
	
	

	// header 검색어 자동완성
	@ResponseBody
	@RequestMapping(value="/deleteRecentSearch.action", method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String deleteRecentSearch(HttpServletRequest request) {

		HttpSession session = request.getSession();
		String switchValue = request.getParameter("switchValue");
		
		//System.out.println(switchValue+"삭제하자");
		 
	    if ("1".equals(switchValue)){
	    	
	    	//System.out.println("gkgkgkgk");
		    String[] searchWordsArray = (String[]) session.getAttribute("searchWords");
			  
	    	session.removeAttribute("searchWords");
	    	searchWordsArray = null;
	    	
	    }
	    // AJAX 요청을 호출한 URL 가져오기
	    String referer = request.getHeader("Referer");
	    
	    // URL을 기반으로 보기 이름 설정
	    String viewName = referer != null ? "redirect:" + referer : "redirect:/";  // Referer 헤더가 존재하면 해당 URL로 리다이렉트. 그렇지 않으면 루트 URL로 리다이렉트.
	    
	    return viewName;
	}
	
	
	

	@RequestMapping(value="/view/main.action")
	public ModelAndView main(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
	    
	    String[] searchWordsArray = (String[]) session.getAttribute("searchWords");
 	    

		Map<String, String> paraMap = new HashMap<>();
		
		// 최근 검색어를 저장할 리스트 생성
		List<String> recentSearchWords = new ArrayList<>();
		
		// 검색어 배열을 쉼표로 구분된 문자열로 변환
		if (searchWordsArray != null) {
		    // 검색어 배열을 쉼표로 구분된 문자열로 변환
		    //searchWordsString = String.join(",", searchWordsArray);
		    //System.out.println(searchWordsString);
			
			
			// 최근에 검색된 5개의 항목만 가져오기
			int startIndex = Math.max(0, searchWordsArray.length - 5); // 검색어 배열에서 가져올 시작 인덱스
			int endIndex = searchWordsArray.length; // 검색어 배열에서 가져올 끝 인덱스

			

			// 검색어 배열에서 최근 5개 항목 가져오기
			for (int i = startIndex; i < endIndex; i++) {
			    recentSearchWords.add(searchWordsArray[i]);
			}
			
			Collections.reverse(recentSearchWords); // 최근 검색어를 내림차순으로 정렬


		}
		String recentSearchWordsString = String.join(",", recentSearchWords);
		recentSearchWordsString = recentSearchWordsString.replaceAll("\\[|\\]", "");

		
		
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		String login_userid = null;
		String login_username = null;
		
		// 로그인 했다면 
		if(loginuser != null) {
			login_userid = loginuser.getUser_id();  // 세션에서 유저의 아이디를 가져온다.
			login_username = loginuser.getName();  // 세션에서 유저의 이름을 가져온다.
		}
		//System.out.println(login_userid);
		
		paraMap.put("login_userid", login_userid);   // map 에 저장  

		
		List<MovieVO> actorCheckFinal;  // 로그인 안했을때 또는 로그인 했지만 평가하지 않은 경우 나오는 Tom Holland 의 최신 순의 영화 작품 (체크하기) 위해 설정함
		List<MovieVO> genreCheckFinal;  // 로그인 안했을때 또는 로그인 했지만 평가하지 않은 경우 나오는 가장 많이 평가한 장르의 작품 (체크하기) 위해 설정함
		
		List<MovieVO> starRankvo = service.starRank();   // 평점 순위 
		List<MovieVO> seeRankvo = service.seeRank();   // 보고싶어요  순위 
		List<MovieVO> commentRankvo = service.commentRank();   // 한줄평 많은  순위 
		List<MovieVO> actorvo = service.actorRank(paraMap);   // 많이 평가한 배우 영화  (로그인한 사람의 아이디 들어가야 함)
		List<MovieVO> actorCheck = service.actorCheck(paraMap);   // 로그인 안했을때 또는 로그인 했지만 평가하지 않은 경우 나오는 Tom Holland 의 최신 순의 영화 작품 (체크하기)
		
		
		if (actorCheck.isEmpty()) {								 // 바로 위의 메소드가 결과가 공백이라면 두번째 쿼리문 실행 
			paraMap.put("actorCheck", null);
			actorCheckFinal = service.actorCheckFinal();     // 공백을경우 Tom Holland 의 작품을 보여주자 
		}
		else {
			paraMap.put("actorCheck", "1");
			actorCheckFinal = actorCheck;   // 결과값 없게 만들기 
		}
		
		List<MovieVO> genrevo = service.genreRank(paraMap);   // 많이 평가한 양화 장르  (로그인안하거나 actorCheck 가 1 이면은 전체 평가중 가장많은 장르를 가져오고 로그인 하고 평가를 1개라도 했으면 평가한 영화 장르에 대해 나타냄)
		
		List<collection_movieVO> celCheck = service.celCheck(paraMap);   // 로그인 안했을때 또는 로그인 했지만 컬렉션한 것이 없을 경우 나오는 것 체크하기
		
		//System.out.println(celCheck);
		
		List<MovieVO> celCheckFinal;  // 로그인 안했을때 또는 로그인 했지만 컬력션이 없는 경우 나오는 가장 많은 컬렉션 (영화수) 를 가지고 있는 다른 유저의 컬렉션 가져오기 
		
		List<collection_movieVO> collection = new ArrayList<>();    // 컬렉션 하기 위해 
		
		if (celCheck.isEmpty()) {								 // 바로 위의 메소드가 결과가 공백이라면 두번째 쿼리문 실행 
			
			celCheckFinal = service.celCheckFinal();     // 공백을경우 가장 많은 컬렉션(영화수)을 가지고 있는 다른 유저의 컬렉션 가져오기
			
			for (MovieVO movie : celCheckFinal) {
		        List<collection_movieVO> collectionMovie = movie.getCollection();
		        if (collectionMovie != null && !collectionMovie.isEmpty()) {   // 결과값이 존재한다면 
		        	collection.addAll(collectionMovie);               
		        }
			}
		}
		else {
			
			celCheckFinal = actorCheck;   // 결과값 없게 만들기 
		}
		
		
		
		
		List<MovieVO> usercol = service.usercol(paraMap);     // 유저의 컬렉션             (로그인한 사람의 아이디 들어가야 함)
		
	
		List<ActorVO> actor = new ArrayList<>();    // 좋아하는 배우의 이름 
		List<Star_ratingVO> starRatings = new ArrayList<>();    // 좋아하는 배우의 영화를 나열하기 위해 설정 
		
		for (MovieVO vo : actorvo) {
		    List<Star_ratingVO> ratings = vo.getStarRating();    // rating에 결과값 저장하기 위헤
		    // System.out.println(ratings);
		    if (ratings != null && !ratings.isEmpty()) {   // 결과값이 존재한다면 
	            starRatings.addAll(ratings);                // rating 을 모두 starRatings에 추가한다.
	        }
		    List<ActorVO> actors = vo.getActor();      // 배우이름을 나타내기 위해 
		    if (actors != null && !actors.isEmpty()) {   // 결과값이 존재한다면 
		    	actor.addAll(actors);
	        }
		}
		
		
		List<GenreVO> genres = new ArrayList<>();    
		List<Star_ratingVO> starRating22 = new ArrayList<>();   
		
		for (MovieVO vo : genrevo) {
		    List<Star_ratingVO> rating22 = vo.getStarRating();    // rating22 에 결과값 저장하기 위헤
		    // System.out.println(ratings);
		    if (rating22 != null && !rating22.isEmpty()) {   // 결과값이 존재한다면 
		    	starRating22.addAll(rating22);                // rating22 을 모두 starRatings에 추가한다.
	        }
		    List<GenreVO> genre = vo.getGenres();      // 배우이름을 나타내기 위해 
		    if (genre != null && !genre.isEmpty()) {   // 결과값이 존재한다면
		        genres.addAll(genre);                // genre를 모두 genres에 추가한다.
		    }
		}
			
		// user의 컬렉견을 하나하나 보여주는 곳 
			
		List<MovieVO> mergedCollection = new ArrayList<>();
		List<List<MovieVO>> mergedCollectionFinal = new ArrayList<>();
		
		
		List<collection_movieVO> finduser = service.finduser();		
		

		for (collection_movieVO movie : finduser) {
			List<MemberVO> members = movie.getMember();    // 이름값 나타내기 위해 
			
			String user_id= movie.getUser_id(); 
		    
			List<MovieVO> findCollectionFinal = service.findCollectionFinal(user_id);
			
			//System.out.println(mergedCollection);
			List<MovieVO> currentMergedCollection = new ArrayList<>(findCollectionFinal);
			mergedCollectionFinal.add(currentMergedCollection);
	
		}
		

		mav.addObject("login_userid",login_userid);
		mav.addObject("login_username",login_username);
		mav.addObject("recentSearchWords", recentSearchWordsString);
		
		mav.addObject("starRankvo", starRankvo);
		mav.addObject("seeRankvo", seeRankvo);
		mav.addObject("commentRankvo", commentRankvo);
		mav.addObject("starRatings", starRatings);
		mav.addObject("actor", actor);
		
		mav.addObject("actorCheck",actorCheck);
		mav.addObject("actorCheckFinal",actorCheckFinal);
		
		
		mav.addObject("starRating22", starRating22);
		mav.addObject("genres", genres);
		mav.addObject("usercol", usercol);
		mav.addObject("celCheck",celCheck);
		mav.addObject("collection",collection);
		mav.addObject("mergedCollectionFinal",mergedCollectionFinal);
		mav.addObject("finduser",finduser);
		
		mav.setViewName("/main.tiles");
		
		
		
		return mav;
		// /WEB-INF/views/tiles1/tiles1/tiles_test
    
	}	
	
	
	
	@ResponseBody
	@RequestMapping(value="/footer/showEvaluationNumber.action",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String showEvaluationNumber(MovieVO vo) {
		
		int n = service.showEvaluationNum(vo);
		return String.valueOf(n);
	}
	
	
	
	/*
	 * // 검색하고 나서 더보기를 누를때
	 * 
	 * @RequestMapping(value="/goSearchDetail.action") public ModelAndView
	 * goSearchDetail(ModelAndView mav, HttpServletRequest request) {
	 * 
	 * String lastSearchWord = request.getParameter("lastSearchWord");
	 * 
	 * Map<String, String> paraMap = new HashMap<>();
	 * 
	 * paraMap.put("searchWord",lastSearchWord);
	 * 
	 * //List<MovieVO> showMovie = service.showMovie(paraMap);
	 * 
	 * mav.addObject("lastSearchWord",lastSearchWord); //mav.addObject("showMovie",
	 * showMovie); mav.setViewName("/search/searchDetail.tiles"); return mav; }
	 */
		
	
	// 더보기 페이지에서 10 개 이후 더보기 버튼을 눌렀을때 
	
	/*
	 * @RequestMapping(value="/goSearchDetail.action") public String
	 * goSearchDetail(HttpServletRequest request) {
	 * 
	 * String novalue = request.getParameter("novalue"); String lastSearchWord =
	 * request.getParameter("lastSearchWord"); System.out.println(novalue);
	 * if(!novalue.equals("0")) { System.out.println("dbsakjf"); String start =
	 * request.getParameter("start"); String lenShow =
	 * request.getParameter("lenShow");
	 * 
	 * 
	 * System.out.println("");
	 * 
	 * Map<String, String> paraMap = new HashMap<>();
	 * 
	 * paraMap.put("start", start); paraMap.put("lastSearchWord", lastSearchWord);
	 * 
	 * String end = String.valueOf(Integer.parseInt(start) +
	 * Integer.parseInt(lenShow) -1);
	 * 
	 * paraMap.put("end", end);
	 * 
	 * List<MovieVO> showMovieAll = service.showMovieAll(paraMap);
	 * 
	 * JSONArray jsonArr = new JSONArray();
	 * 
	 * if(showMovieAll.size() > 0) { // DB 에서 조회해 온 결과물이 있을 경우
	 * 
	 * for(MovieVO Showvo : showMovieAll) {
	 * 
	 * JSONObject jsonObj = new JSONObject(); jsonObj.put("movie_id",
	 * Showvo.getMovie_id()); jsonObj.put("movie_title", Showvo.getMovie_title());
	 * jsonObj.put("original_language", Showvo.getOriginal_language());
	 * jsonObj.put("release_date", Showvo.getRelease_date());
	 * jsonObj.put("poster_path", Showvo.getPoster_path());
	 * jsonObj.put("rating_avg", Showvo.getRating_avg());
	 * 
	 * 
	 * jsonArr.put(jsonObj);
	 * 
	 * 
	 * }// end of for
	 * 
	 * }
	 * 
	 * 
	 * 
	 * String json = jsonArr.toString(); return json; }
	 * 
	 * else { novalue = "1"; return "search/searchDetail.tiles"; }
	 * 
	 * 
	 * }
	 */
	
	@RequestMapping(value = "/goSearchDetail.action")
	public ModelAndView goSearchDetail(HttpServletRequest request) {
	    String novalue = request.getParameter("novalue");
	    String lastSearchWord = request.getParameter("lastSearchWord");
	    
	    if (!novalue.equals("0")) {
	        // Process for Ajax request
	        String start = request.getParameter("start");
	        String lenShow = request.getParameter("lenShow");

	        System.out.println(start);
	        System.out.println(lastSearchWord);
	        Map<String, String> paraMap = new HashMap<>();
	        paraMap.put("start", start);
	        paraMap.put("lastSearchWord", lastSearchWord);

	        String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(lenShow) - 1);
	        paraMap.put("end", end);

	        List<MovieVO> showMovieAll = service.showMovieAll(paraMap);

	        System.out.println(showMovieAll);
	        
	        
	        JSONArray jsonArr = new JSONArray();

	        if (showMovieAll.size() > 0) {
	            // DB에서 조회한 결과물이 있을 경우
	            for (MovieVO Showvo : showMovieAll) {
	                JSONObject jsonObj = new JSONObject();
	                jsonObj.put("movie_id", Showvo.getMovie_id());
	                jsonObj.put("movie_title", Showvo.getMovie_title());
	                jsonObj.put("original_language", Showvo.getOriginal_language());
	                jsonObj.put("release_date", Showvo.getRelease_date());
	                jsonObj.put("poster_path", Showvo.getPoster_path());
	                jsonObj.put("rating_avg", Showvo.getRating_avg());

	                jsonArr.put(jsonObj);
	            }
	        }

	        String json = jsonArr.toString();
	        return new ModelAndView(new MappingJackson2JsonView(), Collections.singletonMap("jsonResponse", json));  
	        /*
	        	이 특정 사례에서 MappingJackson2JsonView는 JSON 응답을 렌더링할 수 있는 Spring MVC에서 제공하는 보기 구현입니다.
	        	 이 보기로 ModelAndView를 생성하면 응답을 JSON으로 렌더링해야 함을 나타냅니다.

				Collections.singletonMap("jsonResponse", json) 부분은 모델에서 단일 항목을 설정하는 데 사용됩니다. 
				"jsonResponse" 키는 응답에 포함하려는 JSON 문자열인 json 값과 연결됩니다.
				
				이 ModelAndView 개체를 반환함으로써 Spring MVC 프레임워크는 
				구성된 MappingJackson2JsonView를 사용하여 지정된 JSON 데이터로 응답을 렌더링합니다.	     
	        */
	    } else {
	    	ModelAndView mav = new ModelAndView("search/searchDetail.tiles");
	        mav.addObject("lastSearchWord", lastSearchWord);
	        return mav;
	    }
	}
	
	
}
