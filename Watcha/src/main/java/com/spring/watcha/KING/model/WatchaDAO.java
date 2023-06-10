package com.spring.watcha.KING.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.collection_likeVO;
import com.spring.watcha.model.user_collection_commentVO;


@Component
@Repository
public class WatchaDAO implements InterWatchaDAO {
	
		@Resource
		private SqlSessionTemplate sqlsession ;

	   // 영화 정보 가져오기 	
	   @Override
	   public MovieVO getMovieDetail(String movieId) {
	      MovieVO movie = sqlsession.selectOne("watcha.getMovieDetails", movieId); 
	      
	      return movie;
	   }
	
	    // 유저의 컬랙션 카드
		@Override
		public List<Map<String, String>> getCollection_view(Map<String, String> paraMap) {

			List<Map<String, String>> collection_viewList = sqlsession.selectList("watcha.getCollection_view", paraMap); 
			
			return collection_viewList;
			
		}

		
		// 더보기
		@Override
		public Map<String, String> totalCount(Map<String, String> paraMap) {
			
			Map<String, String> totalCount = sqlsession.selectOne("watcha.totalCount", paraMap); 
			
			return totalCount;
		}
		@Override
		public List<Map<String, String>> cardSeeMore(Map<String, String> paraMap) {
			
			List<Map<String, String>> cardSeeMore = sqlsession.selectList("watcha.cardSeeMore", paraMap); 
			
			return cardSeeMore;
		}

		 
		// 댓글쓰기 insert
		@Override
		public int addUserComment(user_collection_commentVO uccvo) {
			int n = sqlsession.insert("watcha.addUserComment", uccvo);
			return n;
		}

		// 페이징 처리하기
		@Override
		public List<Map<String, String>> uccListNoSearch(Map<String, String> paraMap) {
			List<Map<String, String>> uccList = sqlsession.selectList("watcha.uccListNoSearchWithPaging", paraMap);
			return uccList;
		}

		// 페이지바 토탈 페이지 알아보기
		@Override
		public int getUserCommentTotalPage(Map<String, String> paraMap) {
			
			int totalPage = sqlsession.selectOne("watcha.getUserCommentTotalPage", paraMap);
			return totalPage;
		}
		
		// 좋아요
		@Override
		public int getLikeSelect(Map<String, Object> paraMap) {
			int n = sqlsession.selectOne("watcha.getLikeSelect", paraMap);
			return n;
		}
		@Override
		public String getLikeInsertCollection(Map<String, Object> paraMap) {
			
			String likeCollection = sqlsession.selectOne("watcha.getLikeInsertCollection", paraMap);
			return likeCollection;
		}
		@Override
		public String getLikeDeleteCollection(Map<String, Object> paraMap) {
			String likeCollection = sqlsession.selectOne("watcha.getLikeDeleteCollection", paraMap);
			return likeCollection;
		}

		// 컬렉션 영화 추가
		@Override
		public int getCollectionSelect(Map<String, Object> paraMap) {
			int n = sqlsession.selectOne("watcha.getCollectionSelect", paraMap);
			return n;
		}
		@Override
		public String getCollectionAddDelete(Map<String, Object> paraMap) {
			String collectionAdd = sqlsession.selectOne("watcha.getCollectionAddDelete", paraMap);
			return collectionAdd;
		}
		@Override
		public String getCollectionAddInsert(Map<String, Object> paraMap) {
			String collectionAdd = sqlsession.selectOne("watcha.getCollectionAddInsert", paraMap);
			return collectionAdd;
		}
}
