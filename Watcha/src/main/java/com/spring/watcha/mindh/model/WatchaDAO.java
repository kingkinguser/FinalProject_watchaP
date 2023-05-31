package com.spring.watcha.mindh.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.MovieVO;

@Component
@Repository
public class WatchaDAO implements InterWatchaDAO {

	
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

	// 좋아하는 배우 영화 
	@Override
	public List<MovieVO> actorRank() {
		List<MovieVO> actorRankList = sqlsession_1.selectList("watchamin.actorRank");	
		
		return actorRankList;
	} 
}
