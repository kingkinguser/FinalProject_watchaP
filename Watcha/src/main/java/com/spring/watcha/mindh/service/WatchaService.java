package com.spring.watcha.mindh.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.collection_movieVO;
import com.spring.watcha.mindh.model.InterWatchaDAO;

@Service
public class WatchaService implements InterWatchaService {
	 
	@Autowired
	private InterWatchaDAO dao;

	
	// header 검색어 자동완성
	@Override
	public List<String> searchword(Map<String, String> paraMap) {
		List<String> wordList = dao.searchword(paraMap);
	    return wordList;
	}
	
	// footer 평점 갯수 나타내기 
	@Override
	public int showEvaluationNum(MovieVO vo) {
		int n = dao.showEvaluationNum(vo);
		return n;
	}
	
	
	// 평점순 으로 30개 나타내기(평점 평가가 기본적으로 10개 이상일때  ) 
	@Override
	public List<MovieVO> starRank() {
		
		List<MovieVO> starRankvo = dao.starRank();
		
		return starRankvo;
	}

	// 보고싶어요 순위 30개 나타내기 
	@Override
	public List<MovieVO> seeRank() {
		List<MovieVO> seeRankvo = dao.seeRank();
		
		return seeRankvo;
	}

	// 한줄평 많은 순위 20개 나타내기 
	@Override
	public List<MovieVO> commentRank() {
		List<MovieVO> commentRankvo = dao.commentRank();
		
		return commentRankvo;
	}

	// 많이 평가한 배우 영화 
	@Override
	public List<MovieVO> actorRank(Map<String, String> paraMap) {
		List<MovieVO> actorRankvo = dao.actorRank(paraMap);
		
		return actorRankvo;
	}

	// 많이 평가한 영화 장르 
	@Override
	public List<MovieVO> genreRank(Map<String, String> paraMap) {
		List<MovieVO> genreRankvo = dao.genreRank(paraMap);
		
		return genreRankvo;
	}

	// 유저의 컬랙션
	@Override
	public List<MovieVO> usercol(Map<String, String> paraMap) {
		List<MovieVO> usercolvo = dao.usercol(paraMap);
		
		return usercolvo;
	}

	// 검색어 세션등록 및 검색 
	@Override
	public String[] goSearch(HttpServletRequest request, Map<String, String> paraMap) {
		
		HttpSession session =  request.getSession();
		// 메모리에 생성되어져 있는 session을 불러오는 것이다. 

		String searchWord = paraMap.get("searchWord");
		
		// 이전에 저장된 검색어 배열을 가져옴
	    String[] searchWords = (String[]) session.getAttribute("searchWords");
	    
	    // 새로운 검색어를 추가하여 새로운 배열을 생성
	    String[] newSearchWords;
	    if (searchWords != null) {
	        newSearchWords = Arrays.copyOf(searchWords, searchWords.length + 1);
	        newSearchWords[searchWords.length] = searchWord;
	    } else {
	        newSearchWords = new String[]{searchWord};
	    }
		
	    session.setAttribute("searchWords", newSearchWords);
	    
	    return newSearchWords;
	
	}

	// 검색후 처음 콘텐츠 일때 영화 보여주기 
	@Override
	public List<MovieVO> showMovie(Map<String, String> paraMap) {
		List<MovieVO> showMovie = dao.showMovie(paraMap);
	    return showMovie;
	}

	// 로그인 안했을때 또는 로그인 했지만 평가하지 않은 경우 나오는 Tom Holland 의 최신 순의 영화 작품 (체크하기)
	@Override
	public List<MovieVO> actorCheck(Map<String, String> paraMap) {
		List<MovieVO> actorCheck = dao.actorCheck(paraMap);
	    return actorCheck;
	}

	// 바로 위의 메소드가 결과가 공백이라면 두번째 쿼리문 실행 
	@Override
	public List<MovieVO> actorCheckFinal() {
		List<MovieVO> actorCheckFinal = dao.actorCheckFinal();
	    return actorCheckFinal;
	}

	// 로그인 안했을때 또는 로그인 했지만 컬렉션한 것이 없을 경우 나오는 것 체크하기
	@Override
	public List<collection_movieVO> celCheck(Map<String, String> paraMap) {
		List<collection_movieVO> celCheck = dao.celCheck(paraMap);
	    return celCheck;
	}

	// 가장 많은 컬렉션(영화수)을 가지고 있는 다른 유저의 컬렉션 가져오기
	@Override
	public List<MovieVO> celCheckFinal() {
		List<MovieVO> celCheckFinal = dao.celCheckFinal();
	    return celCheckFinal;
	}

	// 컬렉션 있는 user 가져오기 
	@Override
	public List<collection_movieVO> finduser() {
		List<collection_movieVO> finduser = dao.finduser();
	    return finduser;
	}
	
	// 각자의 컬렉션 가져오기 
	@Override
	public List<MovieVO> findCollectionFinal(String user_id) {
		List<MovieVO> findCollectionFinal = dao.findCollectionFinal(user_id);
	    return findCollectionFinal;
	}

	// 검색한 영화 정보 모두 가져오기 
	@Override
	public List<MovieVO> showMovieAll(Map<String, String> paraMap) {
		List<MovieVO> showMovieAll = dao.showMovieAll(paraMap);
	    return showMovieAll;
	}

	






}
