package com.spring.watcha.mindh.controller;

import java.util.ArrayList;
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

import com.spring.watcha.model.ActorVO;
import com.spring.watcha.model.GenreVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.Star_ratingVO;

@Controller
public class WatchaController {

	// header 검색어 자동완성
	@ResponseBody
	@RequestMapping(value="/searchword.action", method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String searchword(HttpServletRequest request) {

	    String searchWord = request.getParameter("searchWord");

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
	
	
	
	
	
	@Autowired 
	private com.spring.watcha.mindh.service.InterWatchaService service ; 
	
	@ResponseBody
	@RequestMapping(value="/footer/showEvaluationNumber.action",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String showEvaluationNumber(MovieVO vo) {
		
		int n = service.showEvaluationNum(vo);
		return String.valueOf(n);
	}
	
	
	
	
	@RequestMapping(value="/view/main.action")
	public ModelAndView main(ModelAndView mav, HttpServletRequest request) {
		
		Map<String, String> paraMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		
		/*
		 
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		String login_userid = null;
		
		// 로그인 했다면 
		if(loginuser != null) {
			login_userid = loginuser.getUserid();  // 세션에서 유저의 아이디를 가져온다.
		}
		
		paraMap.put("login_userid", login_userid);   // map 에 저장  

		*/
		
		List<MovieVO> starRankvo = service.starRank();   // 평점 순위 
		List<MovieVO> seeRankvo = service.seeRank();   // 보고싶어요  순위 
		List<MovieVO> commentRankvo = service.commentRank();   // 한줄평 많은  순위 
		List<MovieVO> actorvo = service.actorRank();   // 많이 평가한 배우 영화  (로그인한 사람의 아이디 들어가야 함)
		List<MovieVO> genrevo = service.genreRank();   // 많이 평가한 양화 장르  (로그인한 사람의 아이디 들어가야 함)
		List<MovieVO> usercol = service.usercol();     // 유저의 컬렉션             (로그인한 사람의 아이디 들어가야 함)
		
	
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

		mav.addObject("starRankvo", starRankvo);
		mav.addObject("seeRankvo", seeRankvo);
		mav.addObject("commentRankvo", commentRankvo);
		mav.addObject("starRatings", starRatings);
		mav.addObject("actor", actor);
		mav.addObject("starRating22", starRating22);
		mav.addObject("genres", genres);
		mav.addObject("usercol", usercol);
		mav.setViewName("/main.tiles");
		
		
		
		return mav;
		// /WEB-INF/views/tiles1/tiles1/tiles_test
	}	
	
	
	
	
}
