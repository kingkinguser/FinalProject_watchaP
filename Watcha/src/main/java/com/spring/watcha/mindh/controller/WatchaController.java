package com.spring.watcha.mindh.controller;

import java.util.ArrayList;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.common.usermodel.HyperlinkType;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Hyperlink;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.spring.watcha.model.ActorVO;
import com.spring.watcha.model.GenreVO;
import com.spring.watcha.model.MemberVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.Star_ratingVO;
import com.spring.watcha.model.collection_likeVO;
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
		if(searchWord == null) {
			searchWord = request.getParameter("lastSearchWord");	
		}	
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("searchWord",searchWord);
		paraMap.put("lastSearchWord",searchWord);
		
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
	    
	    // 총 개수를 나타내주자 
	    int total_count = service.total_count(paraMap);
	    
	    
		mav.addObject("total_count", total_count);
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
		
		
		
		
		List<MovieVO> usercol = service.usercol(paraMap);     // 유저의 컬렉션    
		
	
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
			String user_id= movie.getUser_id(); 
			
			List<MemberVO> members = movie.getMember();    // 이름값 나타내기 위해 
			
		    List<MovieVO> findCollectionFinal = service.findCollectionFinal(user_id);			
			
			List<MovieVO> currentMergedCollection = new ArrayList<>(findCollectionFinal);
			mergedCollectionFinal.add(currentMergedCollection);
		}
		

		mav.addObject("login_userid",login_userid);
		mav.addObject("login_username",login_username);
		mav.addObject("recentSearchWords", recentSearchWordsString);
		
		mav.addObject("starRankvo", starRankvo);
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
	
	
	// 영화 모든 정보 보기위해 더보기를 눌렀을때 
	@RequestMapping(value = "/goSearchDetail.action")
	public ModelAndView goSearchDetail(HttpServletRequest request) {
	    String novalue = request.getParameter("novalue");
	    String lastSearchWord = request.getParameter("lastSearchWord");
	    
	    if (!novalue.equals("0")) {
	        // Process for Ajax request
	        String start = request.getParameter("start");
	        String lenShow = request.getParameter("lenShow");

	        Map<String, String> paraMap = new HashMap<>();
	        paraMap.put("start", start);
	        paraMap.put("lastSearchWord", lastSearchWord);

	        String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(lenShow) - 1);
	                
	        paraMap.put("end", end);	     
	        
	        int total_count = service.total_count(paraMap);   // 총 개수를 나타내자 
	        List<MovieVO> showMovieAll = service.showMovieAll(paraMap);  // 영화 가져오자 

	        JSONArray jsonArr = new JSONArray();

	        if (showMovieAll.size() > 0) {
	            // DB에서 조회한 결과물이 있을 경우
	            for (MovieVO Showvo : showMovieAll) {
	                JSONObject jsonObj = new JSONObject();
	                jsonObj.put("movie_id", Showvo.getMovie_id());
	                jsonObj.put("movie_title", Showvo.getMovie_title());
	                jsonObj.put("release_date", Showvo.getRelease_date());
	                jsonObj.put("poster_path", Showvo.getPoster_path());
	                jsonObj.put("rating_avg", Showvo.getRating_avg());

	                jsonArr.put(jsonObj);
	            }
	        }

	        JSONObject jsonRes = new JSONObject();
	        jsonRes.put("total_count", total_count);
	        jsonRes.put("movie_list", jsonArr);

	        String json = jsonRes.toString();
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
	
	
	
	// 영화 검색 페이지에서 인물 눌렀을때 
	@RequestMapping(value = "/goSearchPeople.action", method = {RequestMethod.GET} )
	public ModelAndView goSearchPeople(ModelAndView mav, HttpServletRequest request) {

		String lastSearchWord = request.getParameter("lastSearchWord");
		
		mav.addObject("lastSearchWord",lastSearchWord);
		
		mav.setViewName("/search/searchPeople.tiles");
		return mav;
	}
	
	// 영화 검색 페이지에서 인물 눌렀을때 
	@ResponseBody
	@RequestMapping(value = "/goSearchPeople.action", method = {RequestMethod.POST} )
	public ModelAndView goSearchPeople1(HttpServletRequest request) {

		String lastSearchWord = request.getParameter("lastSearchWord");

        // Process for Ajax request
        String start = request.getParameter("start");
        String lenShow = request.getParameter("lenShow");

        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("start", start);
        paraMap.put("lastSearchWord", lastSearchWord);

        String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(lenShow) - 1);
                
        paraMap.put("end", end);	     
        
        int total_count_people = service.total_count_people(paraMap);   // 총 개수를 나타내자 
        List<ActorVO> showPeopleAll = service.showPeopleAll(paraMap);  // 인물 가져오자 

        JSONArray jsonArr = new JSONArray();

        if (showPeopleAll.size() > 0) {
            // DB에서 조회한 결과물이 있을 경우
            for (ActorVO Showvo : showPeopleAll) {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("actor_id", Showvo.getActor_id());
                jsonObj.put("actor_name", Showvo.getActor_name());
                jsonObj.put("gender", Showvo.getGender());
                jsonObj.put("date_of_birth", Showvo.getDate_of_birth());
                jsonObj.put("profile_image_path", Showvo.getProfile_image_path());

                jsonArr.put(jsonObj);
            }
        }

        JSONObject jsonRes = new JSONObject();
        jsonRes.put("totalPeopleCount", total_count_people);
        jsonRes.put("People_list", jsonArr);

        String json = jsonRes.toString();
        return new ModelAndView(new MappingJackson2JsonView(), Collections.singletonMap("jsonResponse", json));
        
	}
	

	// 영화 검색 페이지에서 유저 눌렀을때 
	@RequestMapping(value = "/goSearchUser.action", method = {RequestMethod.GET} )
	public ModelAndView goSearchUser(ModelAndView mav, HttpServletRequest request) {

		String lastSearchWord = request.getParameter("lastSearchWord");
		
		mav.addObject("lastSearchWord",lastSearchWord);
		
		mav.setViewName("/search/searchUser.tiles");
		return mav;
	}
	
	// 영화 검색 페이지에서 유저 눌렀을때 
	@ResponseBody
	@RequestMapping(value = "/goSearchUser.action", method = {RequestMethod.POST} )
	public ModelAndView goSearchUser1(HttpServletRequest request) {

		String lastSearchWord = request.getParameter("lastSearchWord");

        // Process for Ajax request
        String start = request.getParameter("start");
        String lenShow = request.getParameter("lenShow");

        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("start", start);
        paraMap.put("lastSearchWord", lastSearchWord);

        String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(lenShow) - 1);
                
        paraMap.put("end", end);	     
        
        int total_count_User = service.total_count_User(paraMap);   // 총 개수를 나타내자 
        List<MemberVO> showUserAll = service.showUserAll(paraMap);  // 유저 가져오자 

        JSONArray jsonArr = new JSONArray();

        if (showUserAll.size() > 0) {
            // DB에서 조회한 결과물이 있을 경우
            for (MemberVO Showvo : showUserAll) {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("name", Showvo.getName());
                jsonObj.put("profile_image", Showvo.getProfile_image());
                jsonObj.put("total_count", Showvo.getTotal_count());
                

                jsonArr.put(jsonObj);
            }
        }

        JSONObject jsonRes = new JSONObject();
        jsonRes.put("totalUserCount", total_count_User);
        jsonRes.put("User_list", jsonArr);

        String json = jsonRes.toString();
        return new ModelAndView(new MappingJackson2JsonView(), Collections.singletonMap("jsonResponse", json));
        
	}
		
	
	// 영화 검색 페이지에서 컬렉션 눌렀을때 
	@RequestMapping(value = "/goSearchCollection.action", method = {RequestMethod.GET} )
	public ModelAndView goSearchCollection(ModelAndView mav, HttpServletRequest request) {

		String lastSearchWord = request.getParameter("lastSearchWord");
		
		mav.addObject("lastSearchWord",lastSearchWord);
		
		mav.setViewName("/search/searchCollection.tiles");
		return mav;
	}

	
	// 영화 검색 페이지에서 유저 눌렀을때 
	@ResponseBody
	@RequestMapping(value = "/goSearchCollection.action", method = {RequestMethod.POST} )
	public ModelAndView goSearchCollection1(HttpServletRequest request) {

		String lastSearchWord = request.getParameter("lastSearchWord");

        // Process for Ajax request
        String start = request.getParameter("start");
        String lenShow = request.getParameter("lenShow");

        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("start", start);
        paraMap.put("lastSearchWord", lastSearchWord);

        String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(lenShow) - 1);
                
        paraMap.put("end", end);	     
        
        int total_count_Collection = service.total_count_Collection(paraMap);   // 총 개수를 나타내자 
        List<MemberVO> showCollectionAll = service.showCollectionAll(paraMap);  // 컬렉션 가져오자 
        
        JSONArray jsonArr = new JSONArray();
        JSONObject jsonRes = new JSONObject();
        JSONArray posterArr = new JSONArray(); 
        
        if (showCollectionAll.size() > 0) {
            // DB에서 조회한 결과물이 있을 경우
            for (MemberVO Showvo : showCollectionAll) {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("name", Showvo.getName());
                jsonObj.put("profile_image", Showvo.getProfile_image());
                jsonObj.put("count_user_id_like", Showvo.getCount_user_id_like());
                jsonObj.put("count_user_id_collection", Showvo.getCount_user_id_collection());
                jsonObj.put("user_id", Showvo.getUser_id());
      
                posterArr.put(Showvo.getPoster());
                
                jsonArr.put(jsonObj);
            }
        }

        jsonRes.put("poster", posterArr);
        jsonRes.put("totalCollectionCount", total_count_Collection);
        jsonRes.put("Collection_list", jsonArr);

        String json = jsonRes.toString();
        return new ModelAndView(new MappingJackson2JsonView(), Collections.singletonMap("jsonResponse", json));
        
	}
	
	
	
	// excel 영화 정보 다운로드 하기
	@RequestMapping(value = "/excel/download.action", method = {RequestMethod.POST} )
	public String download(HttpServletRequest request, Model model) {
		
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("searchWord", searchWord);
		
		List<Map<String, String>> movieexcel = service.movieexcel(paraMap);
		
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();  // 엑셀을 사용하기 위해 넣는다 (pom.xml 에 이것을 쓰기위한 준비가 있어야 한다 검색 엑셀 하면 나온다.)
		
		SXSSFSheet sheet = workbook.createSheet("검색한 ' " + searchWord + " '의 영화 정보");
		
		sheet.setColumnWidth(0, 2000);   
	    sheet.setColumnWidth(1, 13000);
	    sheet.setColumnWidth(2, 2000);
	    sheet.setColumnWidth(3, 13000);
	    sheet.setColumnWidth(4, 3000);
	    sheet.setColumnWidth(5, 20000);
	    sheet.setColumnWidth(6, 2000);
	    sheet.setColumnWidth(7, 20000);
		
	    int rowLocation = 0;
	    
	    
	    // 엑셀 서식 지정하기 //
	    
		////////////////////////////////////////////////////////////////////////////////////////
		// CellStyle 정렬하기(Alignment)
		// CellStyle 객체를 생성하여 Alignment 세팅하는 메소드를 호출해서 인자값을 넣어준다.
		// 아래는 HorizontalAlignment(가로)와 VerticalAlignment(세로)를 모두 가운데 정렬 시켰다.
		CellStyle mergeRowStyle = workbook.createCellStyle();          //workbook 은 excel 이라고 생각해도 된다. // mergeRowStyle 는 병합하겠다라는 것을 임의로 이름을 준것임
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);        // HorizontalAlignment 은 가운데 정렬을 뜻한다.
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);  // VerticalAlignment 세로 줄 간격 중앙을 말한다.
		
		CellStyle headerStyle = workbook.createCellStyle();            // header 스타일 결과물에서 부서번호 등등을 나타내는 노란색 부분 
		headerStyle.setAlignment(HorizontalAlignment.CENTER);          
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
		
		// CellStyle 배경색(ForegroundColor)만들기
		// setFillForegroundColor 메소드에 IndexedColors Enum인자를 사용한다.
		// setFillPattern은 해당 색을 어떤 패턴으로 입힐지를 정한다.
		mergeRowStyle.setFillForegroundColor(IndexedColors.PLUM.getIndex());  // IndexedColors.PLUM.getIndex() 는 색상(남색)의 인덱스값을 리턴시켜준다. 
		mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);            // 테두리 모양을 나타낸다. (굵은 상자 테두리 를 하겠다) 
		
		headerStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex()); // IndexedColors.LIGHT_YELLOW.getIndex() 는 연한노랑의 인덱스값을 리턴시켜준다. 
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);              // 테두리 모양을 나타낸다. (굵은 상자 테두리 를 하겠다) 
		

		// Cell 폰트(Font) 설정하기
		// 폰트 적용을 위해 POI 라이브러리의 Font 객체를 생성해준다.
		// 해당 객체의 세터를 사용해 폰트를 설정해준다. 대표적으로 글씨체, 크기, 색상, 굵기만 설정한다.
		// 이후 CellStyle의 setFont 메소드를 사용해 인자로 폰트를 넣어준다.
		Font mergeRowFont = workbook.createFont(); // import org.apache.poi.ss.usermodel.Font; 으로 한다.
		mergeRowFont.setFontName("나눔고딕");                       // font 는 나눔고딕
		mergeRowFont.setFontHeight((short)500);                   // 글자크기 500
		mergeRowFont.setColor(IndexedColors.WHITE.getIndex());    // 글자색상 흰색
		mergeRowFont.setBold(true);								  // 글자 굵기 한다.
		
		mergeRowStyle.setFont(mergeRowFont);                      
		
		
		// CellStyle 테두리 Border
		// 테두리는 각 셀마다 상하좌우 모두 설정해준다.
		// setBorderTop, Bottom, Left, Right 메소드와 인자로 POI라이브러리의 BorderStyle 인자를 넣어서 적용한다.
		headerStyle.setBorderTop(BorderStyle.THICK);			  // 테두리마다 다르게 설정 위, 아래만 굵게, 나머지는 가늘게 
		headerStyle.setBorderBottom(BorderStyle.THICK);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		
		
		// Cell Merge 셀 병합시키기
		/* 셀병합은 시트의 addMergeRegion 메소드에 CellRangeAddress 객체를 인자로 하여 병합시킨다.
		CellRangeAddress 생성자의 인자로(시작 행, 끝 행, 시작 열, 끝 열) 순서대로 넣어서 병합시킬 범위를 정한다. 배열처럼 시작은 0부터이다.  
		*/
		// 병합할 행 만들기
		Row mergeRow = sheet.createRow(rowLocation);   // 0값이 들어가는데 엑셀에서 행의 시작은 0부터 시작하기 때문에 1번째 행이 병합된다. 
		
		
		// 병합할 행에 "우리회사 사원정보" 로 셀을 만들어 셀에 스타일 주기 
		for(int i=0; i < 8; i++) {
			Cell cell = mergeRow.createCell(i);   // 셀을 만들어라 
			cell.setCellStyle(mergeRowStyle);     // 셀에 스타일을 준다.
			cell.setCellValue("검색한 ' " + searchWord + " '의 영화 정보");    // 셀에 글자를 넣어준다
		}// end of for
	    
		
		
		// 셀 병합하기 
		sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 7));  // 시작 행, 끝 행, 시작 열, 끝 열
		// 처음 행 부분만 병합한다. 
		//////////////////////////제목 끝 ////////////////////////////////////////////////////////
		
		////////////// header 부분 /////////////////
		// header행 생성 
		
		Row headerRow = sheet.createRow(++rowLocation);    // 0값이 들어가는데 엑셀에서 행의 시작은 0부터 시작함
										   // ++rowLocation는 전위 행위자로 1행에 만들겠다 
		
		// 해당 행의 첫번째 열 셀 생성
        Cell headerCell = headerRow.createCell(0); // 엑셀에서 열의 시작은 0 부터 시작한다.
        headerCell.setCellValue("영화 id");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 두번째 열 셀 생성
        headerCell = headerRow.createCell(1);
        headerCell.setCellValue("영화 제목");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 세번째 열 셀 생성
        headerCell = headerRow.createCell(2);
        headerCell.setCellValue("원본 언어");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 네번째 열 셀 생성
        headerCell = headerRow.createCell(3);
        headerCell.setCellValue("원본 제목");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 다섯번째 열 셀 생성
        headerCell = headerRow.createCell(4);
        headerCell.setCellValue("개봉 일자");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 여섯번째 열 셀 생성
        headerCell = headerRow.createCell(5);
        headerCell.setCellValue("TAGLINE");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 일곱번째 열 셀 생성
        headerCell = headerRow.createCell(6);
        headerCell.setCellValue("상영시간");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 여덟번째 열 셀 생성
        headerCell = headerRow.createCell(7);
        headerCell.setCellValue("포스터 경로");
        headerCell.setCellStyle(headerStyle);

        
        Row bodyRow = null;
        Cell bodyCell = null;
        
          
        for(int i=0; i<movieexcel.size(); i++) {
           
           Map<String, String> empMap = movieexcel.get(i);   //get(i)는 리스트 값에서 한개의 행을 가져오는 것 
           
           // 행생성
           bodyRow = sheet.createRow(i + (rowLocation+1));  // 처음에는 2로 시작한다. rowLocation은 처음에 1
           
           
           bodyCell = bodyRow.createCell(0);
           bodyCell.setCellValue(empMap.get("movie_id")); //xml의 key 값을 준다.<HashMap> 에 있는 키값  
           
           
           bodyCell = bodyRow.createCell(1);
           bodyCell.setCellValue(empMap.get("movie_title")); 
                      
           
           bodyCell = bodyRow.createCell(2);
           bodyCell.setCellValue(empMap.get("original_language")); 
           
          
           bodyCell = bodyRow.createCell(3);
           bodyCell.setCellValue(empMap.get("original_title")); 
           
          
           bodyCell = bodyRow.createCell(4);
           bodyCell.setCellValue(empMap.get("release_date")); 
           
           
           bodyCell = bodyRow.createCell(5);
           bodyCell.setCellValue(empMap.get("tagline"));    
           
           
           bodyCell = bodyRow.createCell(6);
           bodyCell.setCellValue(empMap.get("runtime")); 
           
           
           bodyCell = bodyRow.createCell(7);
           bodyCell.setCellValue(empMap.get("poster_path")); 
           
           CreationHelper creationHelper = workbook.getCreationHelper();

	        // Create a Hyperlink
	        Hyperlink hyperlink = creationHelper.createHyperlink(HyperlinkType.URL);
	        hyperlink.setAddress(empMap.get("poster_path"));
	
	        // Set the Hyperlink to the cell
	        bodyCell.setHyperlink(hyperlink);
           
           
        }// end of for------------------------------
        
        model.addAttribute("locale",Locale.KOREA);   //model은 저장소 역할만 한다.  한글 안깨지게 하는것 
	    model.addAttribute("workbook",workbook);     // workbook 은 엑셀을 뜻한다. 
	    model.addAttribute("workbookName","검색어 '"+ searchWord + "'의 영화 정보");
	    
	    return "excelDownloadView";  
		
		
	}
	
	
	
	// excel 인물 정보 다운로드 하기
	@RequestMapping(value = "/actor/excel/download.action", method = {RequestMethod.POST} )
	public String actorExcel(HttpServletRequest request, Model model) {
		
		String lastSearchWord = request.getParameter("lastSearchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("lastSearchWord", lastSearchWord);
		
		List<Map<String, String>> actorExcel = service.actorExcel(paraMap);
		
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();  // 엑셀을 사용하기 위해 넣는다 (pom.xml 에 이것을 쓰기위한 준비가 있어야 한다 검색 엑셀 하면 나온다.)
		
		SXSSFSheet sheet = workbook.createSheet("검색한 ' " + lastSearchWord + " '의 인물 정보");
		
		sheet.setColumnWidth(0, 2000);   
	    sheet.setColumnWidth(1, 5000);
	    sheet.setColumnWidth(2, 5000);
	    sheet.setColumnWidth(3, 7000);
	    sheet.setColumnWidth(4, 13000);
	    sheet.setColumnWidth(5, 20000);

		
	    int rowLocation = 0;
	    
	    
	    // 엑셀 서식 지정하기 //
	    
		////////////////////////////////////////////////////////////////////////////////////////
		// CellStyle 정렬하기(Alignment)
		// CellStyle 객체를 생성하여 Alignment 세팅하는 메소드를 호출해서 인자값을 넣어준다.
		// 아래는 HorizontalAlignment(가로)와 VerticalAlignment(세로)를 모두 가운데 정렬 시켰다.
		CellStyle mergeRowStyle = workbook.createCellStyle();          //workbook 은 excel 이라고 생각해도 된다. // mergeRowStyle 는 병합하겠다라는 것을 임의로 이름을 준것임
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);        // HorizontalAlignment 은 가운데 정렬을 뜻한다.
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);  // VerticalAlignment 세로 줄 간격 중앙을 말한다.
		
		CellStyle headerStyle = workbook.createCellStyle();            // header 스타일 결과물에서 부서번호 등등을 나타내는 노란색 부분 
		headerStyle.setAlignment(HorizontalAlignment.CENTER);          
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
		
		// CellStyle 배경색(ForegroundColor)만들기
		// setFillForegroundColor 메소드에 IndexedColors Enum인자를 사용한다.
		// setFillPattern은 해당 색을 어떤 패턴으로 입힐지를 정한다.
		mergeRowStyle.setFillForegroundColor(IndexedColors.PLUM.getIndex());  // IndexedColors.PLUM.getIndex() 는 색상(남색)의 인덱스값을 리턴시켜준다. 
		mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);            // 테두리 모양을 나타낸다. (굵은 상자 테두리 를 하겠다) 
		
		headerStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex()); // IndexedColors.LIGHT_YELLOW.getIndex() 는 연한노랑의 인덱스값을 리턴시켜준다. 
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);              // 테두리 모양을 나타낸다. (굵은 상자 테두리 를 하겠다) 
		

		// Cell 폰트(Font) 설정하기
		// 폰트 적용을 위해 POI 라이브러리의 Font 객체를 생성해준다.
		// 해당 객체의 세터를 사용해 폰트를 설정해준다. 대표적으로 글씨체, 크기, 색상, 굵기만 설정한다.
		// 이후 CellStyle의 setFont 메소드를 사용해 인자로 폰트를 넣어준다.
		Font mergeRowFont = workbook.createFont(); // import org.apache.poi.ss.usermodel.Font; 으로 한다.
		mergeRowFont.setFontName("나눔고딕");                       // font 는 나눔고딕
		mergeRowFont.setFontHeight((short)500);                   // 글자크기 500
		mergeRowFont.setColor(IndexedColors.WHITE.getIndex());    // 글자색상 흰색
		mergeRowFont.setBold(true);								  // 글자 굵기 한다.
		
		mergeRowStyle.setFont(mergeRowFont);                      
		
		
		// CellStyle 테두리 Border
		// 테두리는 각 셀마다 상하좌우 모두 설정해준다.
		// setBorderTop, Bottom, Left, Right 메소드와 인자로 POI라이브러리의 BorderStyle 인자를 넣어서 적용한다.
		headerStyle.setBorderTop(BorderStyle.THICK);			  // 테두리마다 다르게 설정 위, 아래만 굵게, 나머지는 가늘게 
		headerStyle.setBorderBottom(BorderStyle.THICK);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		
		
		// Cell Merge 셀 병합시키기
		/* 셀병합은 시트의 addMergeRegion 메소드에 CellRangeAddress 객체를 인자로 하여 병합시킨다.
		CellRangeAddress 생성자의 인자로(시작 행, 끝 행, 시작 열, 끝 열) 순서대로 넣어서 병합시킬 범위를 정한다. 배열처럼 시작은 0부터이다.  
		*/
		// 병합할 행 만들기
		Row mergeRow = sheet.createRow(rowLocation);   // 0값이 들어가는데 엑셀에서 행의 시작은 0부터 시작하기 때문에 1번째 행이 병합된다. 
		
		
		// 병합할 행에 "우리회사 사원정보" 로 셀을 만들어 셀에 스타일 주기 
		for(int i=0; i < 8; i++) {
			Cell cell = mergeRow.createCell(i);   // 셀을 만들어라 
			cell.setCellStyle(mergeRowStyle);     // 셀에 스타일을 준다.
			cell.setCellValue("검색한 ' " + lastSearchWord + " '의 영화 정보");    // 셀에 글자를 넣어준다
		}// end of for
	    
		
		
		// 셀 병합하기 
		sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 5));  // 시작 행, 끝 행, 시작 열, 끝 열
		// 처음 행 부분만 병합한다. 
		//////////////////////////제목 끝 ////////////////////////////////////////////////////////
		
		////////////// header 부분 /////////////////
		// header행 생성 
		
		Row headerRow = sheet.createRow(++rowLocation);    // 0값이 들어가는데 엑셀에서 행의 시작은 0부터 시작함
										   // ++rowLocation는 전위 행위자로 1행에 만들겠다 
		
		// 해당 행의 첫번째 열 셀 생성
        Cell headerCell = headerRow.createCell(0); // 엑셀에서 열의 시작은 0 부터 시작한다.
        headerCell.setCellValue("배우 id");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 두번째 열 셀 생성
        headerCell = headerRow.createCell(1);
        headerCell.setCellValue("배우 이름");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 세번째 열 셀 생성
        headerCell = headerRow.createCell(2);
        headerCell.setCellValue("성별");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 네번째 열 셀 생성
        headerCell = headerRow.createCell(3);
        headerCell.setCellValue("생년월일");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 다섯번째 열 셀 생성
        headerCell = headerRow.createCell(4);
        headerCell.setCellValue("고향");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 여섯번째 열 셀 생성
        headerCell = headerRow.createCell(5);
        headerCell.setCellValue("프로필 경로");
        headerCell.setCellStyle(headerStyle);
        
 
        Row bodyRow = null;
        Cell bodyCell = null;
        
          
        for(int i=0; i<actorExcel.size(); i++) {
           
           Map<String, String> empMap = actorExcel.get(i);   //get(i)는 리스트 값에서 한개의 행을 가져오는 것 
           
           // 행생성
           bodyRow = sheet.createRow(i + (rowLocation+1));  // 처음에는 2로 시작한다. rowLocation은 처음에 1
           
           
           bodyCell = bodyRow.createCell(0);
           bodyCell.setCellValue(empMap.get("actor_id")); //xml의 key 값을 준다.<HashMap> 에 있는 키값  
           
           
           bodyCell = bodyRow.createCell(1);
           bodyCell.setCellValue(empMap.get("actor_name")); 
                      
           
           bodyCell = bodyRow.createCell(2);
           bodyCell.setCellValue(empMap.get("gender")); 
           
          
           bodyCell = bodyRow.createCell(3);
           bodyCell.setCellValue(empMap.get("date_of_birth")); 
           
          
           bodyCell = bodyRow.createCell(4);
           bodyCell.setCellValue(empMap.get("place_of_birth")); 
           
           
           bodyCell = bodyRow.createCell(5);
           bodyCell.setCellValue("https://image.tmdb.org/t/p/w500" + empMap.get("profile_image_path"));    
           
         
           CreationHelper creationHelper = workbook.getCreationHelper();

	        // Create a Hyperlink
	        Hyperlink hyperlink = creationHelper.createHyperlink(HyperlinkType.URL);
	        hyperlink.setAddress("https://image.tmdb.org/t/p/w500" + empMap.get("profile_image_path"));
	
	        // Set the Hyperlink to the cell
	        bodyCell.setHyperlink(hyperlink);
           
           
        }// end of for------------------------------
        
        model.addAttribute("locale",Locale.KOREA);   //model은 저장소 역할만 한다.  한글 안깨지게 하는것 
	    model.addAttribute("workbook",workbook);     // workbook 은 엑셀을 뜻한다. 
	    model.addAttribute("workbookName","검색어 '"+ lastSearchWord + "'의 인물 정보");
	    
	    return "excelDownloadView";  
		
		
	}
	
	
	
}
