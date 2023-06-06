package com.spring.watcha.mindh.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.watcha.model.MovieVO;
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
	public List<MovieVO> actorRank() {
		List<MovieVO> actorRankvo = dao.actorRank();
		
		return actorRankvo;
	}

	// 많이 평가한 영화 장르 
	@Override
	public List<MovieVO> genreRank() {
		List<MovieVO> genreRankvo = dao.genreRank();
		
		return genreRankvo;
	}

	// 유저의 컬랙션
	@Override
	public List<MovieVO> usercol() {
		List<MovieVO> usercolvo = dao.usercol();
		
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

	






}
