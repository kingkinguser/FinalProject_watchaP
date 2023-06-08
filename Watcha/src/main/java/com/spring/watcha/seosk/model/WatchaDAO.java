package com.spring.watcha.seosk.model;

import java.util.*;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.GenreVO;
import com.spring.watcha.model.MovieReviewVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.ReviewCommentVO;

@Repository
public class WatchaDAO implements InterWatchaDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// 최근 평가한 영화 5개
	@Override
	public List<MovieVO> ratingFive(String user_id) {
		List<MovieVO> ratingFiveList = sqlsession.selectList("watcha.ratingFive", user_id);
		return ratingFiveList;
	}

	// 회원정보, 평균 별점, 평가한 영화개수
	@Override
	public Map<String, String> userInfo(String user_id) {
		Map<String, String> userInfo = sqlsession.selectOne("watcha.userInfo", user_id);
		return userInfo;
	}

	// 한줄평 개수
	@Override
	public int reviewCount(String user_id) {
		int reviewCount = sqlsession.selectOne("watcha.reviewCount", user_id);
		return reviewCount;
	}

	// 검색하기 - 모든 종류의 장르 가져오기
	@Override
	public List<GenreVO> genreInfo() {
		List<GenreVO> genreList = sqlsession.selectList("watcha.genreInfo");
		return genreList;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 회원이 평가한 영화 전체
	@Override
	public List<Map<String, String>> ratingMovies(String user_id) {
		List<Map<String, String>> ratingMoviesList = sqlsession.selectList("watcha.ratingMovies", user_id);
		return ratingMoviesList;
	}
	
	// 회원의 한줄평 - 한줄평 8개씩 페이징 처리
	@Override
	public List<Map<String, String>> myReviewPaging(Map<String, String> paraMap) {
	    List<Map<String, String>> myReviewList = sqlsession.selectList("watcha.myReviewPaging", paraMap);
		return myReviewList;
	}

	// 회원이 평가한 영화 - 10개씩 페이징 처리
	@Override
	public List<Map<String, String>> rateMoviesPaging(Map<String, String> paraMap) {
	    List<Map<String, String>> rateMoviesList = sqlsession.selectList("watcha.rateMoviesPaging", paraMap);
		return rateMoviesList;
	}

	// 영화별 유저들 한줄평 - 6개씩 페이징 처리
	@Override
	public List<Map<String, String>> movieReviewPaging(Map<String, String> paraMap) {
		List<Map<String, String>> reviewList = sqlsession.selectList("watcha.movieReviewPaging", paraMap);
		return reviewList;
	}

	// 한줄평 - 영화에 대한 정보(별점개수, 별점평균 포함)
	@Override
	public MovieVO movieInfo(String movie_id) {
		MovieVO movieInfo = sqlsession.selectOne("watcha.movieInfo", movie_id);
		return movieInfo;
	}

	// 한줄평 개수(영화별 유저들의 한줄평)
	@Override
	public int userReviewCount(String movie_id) {
		int totalCount = sqlsession.selectOne("watcha.userReviewCount", movie_id);
		return totalCount;
	}

	// 한줄평 - 해당 한줄평에 달린 댓글List 가져오기
	@Override
	public List<Map<String, String>> commentList(String review_id) {
		List<Map<String, String>> commentList = sqlsession.selectList("watcha.commentList", review_id);
		return commentList;
	}

	// 한줄평 - 로그인한 회원이 해당 영화에 대해 작성한 한줄평 유무 및 한줄평 정보
	@Override
	public MovieReviewVO reviewInfo(Map<String, String> paraMap) {
		MovieReviewVO reviewInfo = sqlsession.selectOne("watcha.reviewInfo", paraMap);
		return reviewInfo;
	}
	
	// 한줄평 추가
	@Override
	public int addReview(MovieReviewVO mrvo) {
		int n = sqlsession.insert("watcha.addReview", mrvo);
		return n;
	}
	
	// 한줄평 삭제
	@Override
	public int deleteReview(String review_id) {
		int n = sqlsession.delete("watcha.deleteReview", review_id);
		return n;
	}

	// 한줄평 수정
	@Override
	public int updateReview(MovieReviewVO mrvo) {
		int n = sqlsession.update("watcha.updateReview", mrvo);
		return n;
	}

	// 한줄평 - 좋아요 체크
	@Override
	public int addReviewLike(Map<String, String> paraMap) {
		int n = sqlsession.insert("watcha.addReviewLike", paraMap);
		return n;
	}

	// 한줄평 - 좋아요 체크해제
	@Override
	public int delReviewLike(Map<String, String> paraMap) {
		int n = sqlsession.delete("watcha.delReviewLike", paraMap);
		return n;
	}

	// 한줄평 - 좋아요개수 업데이트
	@Override
	public int updateLikeCount(Map<String, String> map) {
		int n = sqlsession.update("watcha.updateLikeCount", map);
		return n;
	}

	// 한줄평 - 댓글달기
	@Override
	public int addComment(ReviewCommentVO rcvo) {
		int n = sqlsession.insert("watcha.addComment", rcvo);
		return n;
	}

	// 한줄평 - 댓글 수정
	@Override
	public int updateComment(ReviewCommentVO rcvo) {
		int n = sqlsession.update("watcha.updateComment", rcvo);
		return n;
	}

	// 한줄평 - 댓글 삭제
	@Override
	public int deleteComment(ReviewCommentVO rcvo) {
		int n = sqlsession.delete("watcha.deleteComment", rcvo);
		return n;
	}

	// 한줄평 - 댓글개수 업데이트
	@Override
	public int updateCommentCount(Map<String, String> paraMap) {
		int n = sqlsession.update("watcha.updateCommentCount", paraMap);
		return n;
	}

	// 검색하기 - 검색조건에 해당하는 검색결과List 가져오기
	@Override
	public List<Map<String, String>> searchResult(Map<String, Object> paraMap) {
		
		List<Map<String, String>> searchList = sqlsession.selectList("watcha.searchResult", paraMap);
		
	    if(searchList != null && searchList.size() > 0) {
	    	
    		for(Map<String, String> search : searchList) {
    			
    			// 영화에 따른 장르 이름 알아오기
    			List<GenreVO> genre_name_List = sqlsession.selectList("watcha.genre_name_List", search.get("movie_id"));
    			
    			String genre_name = "";
    			for(int i=0; i<genre_name_List.size(); i++) {
    				genre_name += genre_name_List.get(i).getGenre_name();
    				if(i != genre_name_List.size()-1) {
        				genre_name += ", ";
    				}
    			} // end of for
    			
    			search.put("genre_name", genre_name);
    			
	    	} // end of for
	    }
		return searchList;
	}

	// 검색상세 - 영화정보(장르포함), 무비다이어리 가져오기
	@Override
	public Map<String, String> searchDetail(Map<String, String> paraMap) {
		
		Map<String, String> searchDetail = sqlsession.selectOne("watcha.searchDetail", paraMap);

		// 영화에 따른 장르 이름 알아오기
		List<GenreVO> genre_name_List = sqlsession.selectList("watcha.genre_name_List", searchDetail.get("movie_id"));
		
		String genre_name = "";
		for(int i=0; i<genre_name_List.size(); i++) {
			genre_name += genre_name_List.get(i).getGenre_name();
			if(i != genre_name_List.size()-1) {
				genre_name += ", ";
			}
		} // end of for
		
		searchDetail.put("genre_name", genre_name);
		
		return searchDetail;
	}

	// 검색상세 - 해당 영화의 한줄평 가져오기
	@Override
	public MovieReviewVO searchReview(Map<String, String> paraMap) {
		MovieReviewVO searchReview = sqlsession.selectOne("watcha.searchReview", paraMap);
		return searchReview;
	}
	
	// 별점평가 수정하기
	public int updateRating(Map<String, String> paraMap) {
		int n = sqlsession.update("watcha.updateRating", paraMap);
		return n;
	}

}
