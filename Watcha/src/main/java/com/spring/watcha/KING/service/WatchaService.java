package com.spring.watcha.KING.service;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.watcha.KING.model.InterWatchaDAO;
import com.spring.watcha.common.AES256;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.collection_likeVO;
import com.spring.watcha.model.user_collection_commentVO;


@Service
public class WatchaService implements InterWatchaService {
	
   @Autowired
   private InterWatchaDAO dao;

   @Autowired 
   private AES256 aes;

    // 영화 및 드라마 등 정보 가져오기 
	@Override
	public MovieVO getMovieDetail(Map<String, String> paraMap) {

		MovieVO projectInfo = dao.getMovieDetail(paraMap);
		
		return projectInfo;
	}

	// 유저의 컬랙션 카드
	@Override
	public List<Map<String, String>> getCollection_view(Map<String, String> paraMap) {

		List<Map<String, String>> collection_viewList = dao.getCollection_view(paraMap);
		
		return collection_viewList;
	}
	
	// 더보기
	@Override
	public Map<String, String> totalCount(Map<String, String> paraMap) {

		Map<String, String> totalCount = dao.totalCount(paraMap);
		
		return totalCount;
	}
	@Override
	public List<Map<String, String>> cardSeeMore(Map<String, String> paraMap) {
		
		List<Map<String, String>> cardSeeMore = dao.cardSeeMore(paraMap);
		
		return cardSeeMore;
	}
	
	// 댓글쓰기
	@Override
	public int addUserComment(user_collection_commentVO uccvo) {

		int n = dao.addUserComment(uccvo); // 댓글쓰기(tbl_comment 테이블에 insert)
		
		return n;
	}

	// 페이징 처리하기
	@Override
	public List<Map<String, String>> getuccListPaging(Map<String, String> paraMap) {
		List<Map<String, String>> uccList = dao.uccListNoSearch(paraMap);
		return uccList;
	}

	// 페이징 토탈구하기
	@Override
	public int getUserCommentTotalPage(Map<String, String> paraMap) {
		
		int totalPage = dao.getUserCommentTotalPage(paraMap);
		
		return totalPage; 
	}

	// 좋아요
	@Override
	public int getLikeSelect(Map<String, Object> paraMap) {
		int n = dao.getLikeSelect(paraMap);
		
		return n;
	}
	@Override
	public String getLikeInsertCollection(Map<String, Object> paraMap) {
		
		String likeCollection = dao.getLikeInsertCollection(paraMap);
		
		return likeCollection;
	}
	@Override
	public String getLikeDeleteCollection(Map<String, Object> paraMap) {
		String likeCollection = dao.getLikeDeleteCollection(paraMap);
		
		return likeCollection;
	}

	// 컬렉션 영화 추가
	@Override
	public int getCollectionSelect(Map<String, Object> paraMap) {
		int n = dao.getCollectionSelect(paraMap);
		return n;
	}
	@Override
	public String getCollectionAddDelete(Map<String, Object> paraMap) {
		String collectionAdd = dao.getCollectionAddDelete(paraMap);
		
		return collectionAdd;
	}
	@Override
	public String getCollectionAddInsert(Map<String, Object> paraMap) {
		String collectionAdd = dao.getCollectionAddInsert(paraMap);
		
		return collectionAdd;
	}

	// 컬렉션 값 유지
	@Override
	public int getMoviecollectionSelect(Map<String, String> paraMap) {
		int n = dao.getMoviecollectionSelect(paraMap);
		return n;
	}


	// 좋아요 총수
	@Override
	public int getLikeTotal(Map<String, Object> paraMap) {
		int n = dao.getLikeTotal(paraMap);
		
		return n;
	}

	// 좋아요 유지
	@Override
	public int getLikeMaintain(Map<String, String> paraMap) {
		int n = dao.getLikeMaintain(paraMap);
		return n;
	}
	
	// 차트 1
	@Override
	public List<Map<String, String>> getWordcloud(Map<String, Object> paraMap) {
		List<Map<String, String>> wordcloud = dao.getWordcloud(paraMap);
		return wordcloud;
	}
	
	// 차트 2
	@Override
	public List<Map<String, String>> getPieBasic(Map<String, Object> paraMap) {
		List<Map<String, String>> pieBasic = dao.getPieBasic(paraMap);
		return pieBasic;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 한줄평 - 로그인한 회원이 해당 영화에 대해 작성한 한줄평 유무 및 한줄평 정보
	@Override
	public Map<String, String> reviewInfo(Map<String, String> paraMap) {
		Map<String, String> reviewInfo = dao.reviewInfo(paraMap);
		return reviewInfo;
	}		
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

