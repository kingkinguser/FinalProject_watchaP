package com.spring.watcha.mindh.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.ActorVO;
import com.spring.watcha.model.MemberVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.collection_likeVO;
import com.spring.watcha.model.collection_movieVO;

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

	// 로그인 안했을때 또는 로그인 했지만 컬렉션한 것이 없을 경우 나오는 것 체크하기
	@Override
	public List<collection_movieVO> celCheck(Map<String, String> paraMap) {
		List<collection_movieVO> celCheck = sqlsession_1.selectList("watchamin.celCheck", paraMap);			
		return celCheck;
	}

	// 가장 많은 컬렉션(영화수)을 가지고 있는 다른 유저의 컬렉션 가져오기
	@Override
	public List<MovieVO> celCheckFinal() {
		List<MovieVO> celCheckFinal = sqlsession_1.selectList("watchamin.celCheckFinal");	
		
		return celCheckFinal;
	}

	// 컬렉션 있는 user 가져오기 
	@Override
	public List<collection_movieVO> finduser() {
		List<collection_movieVO> finduser = sqlsession_1.selectList("watchamin.finduser");	
		
		return finduser;
	}

	// 각자의 컬렉션 가져오기 
	@Override
	public List<MovieVO> findCollectionFinal(String user_id) {
		List<MovieVO> findCollectionFinal = sqlsession_1.selectList("watchamin.findCollectionFinal", user_id);	
		
		return findCollectionFinal;
	}

	// 검색한 영화 정보 모두 가져오기 
	@Override
	public List<MovieVO> showMovieAll(Map<String, String> paraMap) {
		List<MovieVO> showMovieAll = sqlsession_1.selectList("watchamin.showMovieAll", paraMap);	
		
		return showMovieAll;
	}

	// 검색한 영화 총 몇개인지 가져오기 
	@Override
	public int total_count(Map<String, String> paraMap) {
		int total_count = sqlsession_1.selectOne("watchamin.total_count", paraMap);	
		
		return total_count;
	}

	// 검색한 인물의 총 개수를 가져오자
	@Override
	public int total_count_people(Map<String, String> paraMap) {
		int total_count_people = sqlsession_1.selectOne("watchamin.total_count_people", paraMap);	
		
		return total_count_people;
	}

	// 검색한 인물 총 몇개인지 가져오기 
	@Override
	public List<ActorVO> showPeopleAll(Map<String, String> paraMap) {
		List<ActorVO> showPeopleAll = sqlsession_1.selectList("watchamin.showPeopleAll", paraMap);	
		
		return showPeopleAll;
	}
	
	// 검색한 유조 총 개수를 가져오자 
	@Override
	public int total_count_User(Map<String, String> paraMap) {
		int total_count_User = sqlsession_1.selectOne("watchamin.total_count_User", paraMap);	
		
		return total_count_User;
	}

	// 검색한 유저 나타내기
	@Override
	public List<MemberVO> showUserAll(Map<String, String> paraMap) {
		List<MemberVO> showUserAll = sqlsession_1.selectList("watchamin.showUserAll", paraMap);	
		
		return showUserAll;
	}

	// 검색한 컬렉션 총 개수인지 가져오기 
	@Override
	public int total_count_Collection(Map<String, String> paraMap) {
		int total_count_Collection = sqlsession_1.selectOne("watchamin.total_count_Collection", paraMap);	
		
		return total_count_Collection;
	}

	// 검색한 컬렉션 나타내기
	@Override
	public List<MemberVO> showCollectionAll(Map<String, String> paraMap) {
		List<MemberVO> showCollectionAll = sqlsession_1.selectList("watchamin.showCollectionAll", paraMap);	
		
		return showCollectionAll;
	}

	// 엑셀로 저장하기 위해 검색한 영화 가져오기 
	@Override
	public List<Map<String, String>> movieexcel(Map<String, String> paraMap) {
		List<Map<String, String>> movieexcel = sqlsession_1.selectList("watchamin.movieexcel", paraMap);	
		
		return movieexcel;
	}

	// 엑셀로 저장하기 위해 검색한 인물 가져오기 
	@Override
	public List<Map<String, String>> actorExcel(Map<String, String> paraMap) {
		List<Map<String, String>> actorExcel = sqlsession_1.selectList("watchamin.actorExcel", paraMap);	
		
		return actorExcel;
	}


	


}
