package com.spring.watcha.KING.service;

import java.util.List;
import java.util.Map;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.collection_likeVO;
import com.spring.watcha.model.user_collection_commentVO;

public interface InterWatchaService {

	// 영화 및 드라마 등 정보 가져오기 
	 MovieVO getMovieDetail(Map<String, String> paraMap);

	// 유저의 컬랙션 카드
	List<Map<String, String>> getCollection_view(Map<String, String> paraMap);

	
	//더보기
	Map<String, String> totalCount(Map<String, String> paraMap);
	List<Map<String, String>> cardSeeMore(Map<String, String> paraMap);
	
	// 댓글 insert
	int addUserComment(user_collection_commentVO uccvo);

	// 페이징 처리하기
	List<Map<String, String>> getuccListPaging(Map<String, String> paraMap);

	// 페이지바 토탈 페이지 알아보기
	String getUserCommentTotalPage(Map<String, String> paraMap);

	// 좋아요
	int getLikeSelect(Map<String, Object> paraMap);
	String getLikeInsertCollection(Map<String, Object> paraMap);
	String getLikeDeleteCollection(Map<String, Object> paraMap);

	// 컬렉션 영화 추가
	int getCollectionSelect(Map<String, Object> paraMap);
	String getCollectionAddDelete(Map<String, Object> paraMap);
	String getCollectionAddInsert(Map<String, Object> paraMap);

	// 컬렉션 값 유지
	int getMoviecollectionSelect(Map<String, String> paraMap);

	// groupno 최댓값 알기 
	int getGroupno_max();

	
	

}
