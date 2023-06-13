package com.spring.watcha.mindh.model;

import java.util.List;
import java.util.Map;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.collection_movieVO;

public interface InterWatchaDAO {

	
	// header 검색어 자동완성
	List<String> searchword(Map<String, String> paraMap);
		
		
	// footer 평점 갯수 나타내기 
	int showEvaluationNum(MovieVO vo);
	
	// 평점순 으로 30개 나타내기(평점 평가가 기본적으로 10개 이상일때  ) 
	List<MovieVO> starRank();

	// 보고싶어요 순위 30개 나타내기 
	List<MovieVO> seeRank();

	// 한줄평 많은 순위 20개 나타내기 
	List<MovieVO> commentRank();

	// 많이 평가한 배우 영화 
	List<MovieVO> actorRank(Map<String, String> paraMap);

	// 많이 평가한 영화 장르 
	List<MovieVO> genreRank(Map<String, String> paraMap);

	// 로그인 안했을때 또는 로그인 했지만 컬렉션한 것이 없을 경우 나오는 것 체크하기
	List<collection_movieVO> celCheck(Map<String, String> paraMap);
	
	// 유저의 컬랙션
	List<MovieVO> usercol(Map<String, String> paraMap);

	// 검색후 처음 콘텐츠 일때 영화 보여주기 
	List<MovieVO> showMovie(Map<String, String> paraMap);

	// 로그인 안했을때 또는 로그인 했지만 평가하지 않은 경우 나오는 Tom Holland 의 최신 순의 영화 작품 (체크하기)
	List<MovieVO> actorCheck(Map<String, String> paraMap);

	// 바로 위의 메소드가 결과가 공백이라면 두번째 쿼리문 실행 
	List<MovieVO> actorCheckFinal();

	// 가장 많은 컬렉션(영화수)을 가지고 있는 다른 유저의 컬렉션 가져오기
	List<MovieVO> celCheckFinal();

	// 컬렉션 있는 user 가져오기 
	List<collection_movieVO> finduser();

	// 각자의 컬렉션 가져오기 
	List<MovieVO> findCollectionFinal(String user_id);

	// 검색한 영화 정보 모두 가져오기 
	List<MovieVO> showMovieAll(Map<String, String> paraMap);

	// 검색한 영화 총 몇개인지 가져오기 
	int total_count(Map<String, String> paraMap);




	

}
