package com.spring.watcha.KING.model;

import java.util.List;
import java.util.Map;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.user_collection_commentVO;

public interface InterWatchaDAO {

	// 영화 및 드라마 등 정보 가져오기 
  	MovieVO getMovieDetail(String movie_id);

    // 유저의 컬랙션 카드
	List<Map<String, String>> getCollection_view(Map<String, String> paraMap);

	// 더보기
	Map<String, String> totalCount(Map<String, String> paraMap);
	List<Map<String, String>> cardSeeMore(Map<String, String> paraMap);

	// 댓글쓰기 insert
	int addUserComment(user_collection_commentVO uccvo);

	// 페이징 처리하기
	List<user_collection_commentVO> uccListNoSearch(Map<String, String> paraMap);

	// 페이지바 토탈 페이지 알아보기
	int getUserCommentTotalPage(Map<String, String> paraMap);
		
		
}
