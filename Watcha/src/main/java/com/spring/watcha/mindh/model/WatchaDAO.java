package com.spring.watcha.mindh.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.MovieVO;

@Component
@Repository
public class WatchaDAO implements InterWatchaDAO {

	
	// header 검색어 자동완성
	@Override
	public List<String> searchword(Map<String, String> paraMap) {
		List<String> wordList = sqlsession_1.selectList("watchamin.searchword", paraMap);
	    return wordList;
	}
	
	// footer 평점 갯수 나타내기 
	@Override
	public int showEvaluationNum(MovieVO vo) {
		int n = sqlsession_1.selectOne("watchamin.showEvaluationNum", vo);
		
		return n; 
	} 
	
	@Resource
	private SqlSessionTemplate sqlsession_1;

	// 평점순 으로 30개 나타내기(평점 평가가 기본적으로 10개 이상일때  ) 
	@Override
	public List<MovieVO> starRank() {
				
		List<MovieVO> starRankList = sqlsession_1.selectList("watchamin.starRank");	
		
		return starRankList;
	}

	// 보고싶어요 순위 30개 나타내기 
	@Override
	public List<MovieVO> seeRank() {
		List<MovieVO> seeRankList = sqlsession_1.selectList("watchamin.seeRank");	
		
		return seeRankList;
	}

	// 한줄평 많은 순위 20개 나타내기 
	@Override
	public List<MovieVO> commentRank() {
		List<MovieVO> commentRankList = sqlsession_1.selectList("watchamin.commentRank");	
		
		return commentRankList;
	}

	// 많이 평가한 배우 영화 
	@Override
	public List<MovieVO> actorRank(Map<String, String> paraMap) {
		List<MovieVO> actorRankList = sqlsession_1.selectList("watchamin.actorRank", paraMap);	
		
		return actorRankList;
	}

	// 많이 평가한 영화 장르 
	@Override
	public List<MovieVO> genreRank(Map<String, String> paraMap) {
		List<MovieVO> genreRankList = sqlsession_1.selectList("watchamin.genreRank", paraMap);	
		
		return genreRankList;
	}

	// 유저의 컬랙션
	@Override
	public List<MovieVO> usercol(Map<String, String> paraMap) {
		List<MovieVO> usercolList = sqlsession_1.selectList("watchamin.usercol", paraMap);	
		
		return usercolList;
	}

	// 검색후 처음 콘텐츠 일때 영화 보여주기 
	@Override
	public List<MovieVO> showMovie(Map<String, String> paraMap) {
		List<MovieVO> showMovie = sqlsession_1.selectList("watchamin.showMovie1", paraMap);	
		
		return showMovie;
	}

	// 로그인 안했을때 또는 로그인 했지만 평가하지 않은 경우 나오는 Tom Holland 의 최신 순의 영화 작품 (체크하기)
	@Override
	public List<MovieVO> actorCheck(Map<String, String> paraMap) {
		List<MovieVO> actorCheck = sqlsession_1.selectList("watchamin.actorCheck", paraMap);	
		
		return actorCheck;
	}

	// 바로 위의 메소드가 결과가 공백이라면 두번째 쿼리문 실행 
	@Override
	public List<MovieVO> actorCheckFinal() {
		List<MovieVO> actorCheckFinal = sqlsession_1.selectList("watchamin.actorCheckFinal");	
		
		return actorCheckFinal;
	}


	


}
