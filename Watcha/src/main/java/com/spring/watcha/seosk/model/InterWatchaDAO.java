package com.spring.watcha.seosk.model;

import java.util.*;

import com.spring.watcha.model.GenreVO;
import com.spring.watcha.model.MovieDiaryVO;
import com.spring.watcha.model.MovieReviewVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.ReviewCommentVO;

public interface InterWatchaDAO {

	// === 마이왓챠 기본정보 == //
	
	// 최근 평가한 영화 5개
	List<MovieVO> ratingFive(String user_id);

	// 평균 별점, 평가한 영화개수
	Map<String, String> userInfo(String user_id);

	// 한줄평 개수(로그인한 회원의 한줄평)
	int reviewCount(String user_id);

	// 무비다이어리 - 포토티켓List 가져오기
	List<Map<String, String>> userPhotoTicket(String user_id);

	// 검색하기 - 모든 종류의 장르 가져오기
	List<GenreVO> genreInfo();

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 회원이 평가한 영화 전체
	List<Map<String, String>> ratingMovies(String user_id);
	
	// 내 한줄평 - 한줄평 8개씩 페이징 처리
	List<Map<String, String>> myReviewPaging(Map<String, String> paraMap);

	// 회원이 평가한 영화 - 10개씩 페이징 처리
	List<Map<String, String>> rateMoviesPaging(Map<String, String> paraMap);
	
	// 영화별 유저들 한줄평 - 6개씩 페이징 처리
	List<Map<String, String>> movieReviewPaging(Map<String, String> paraMap);

	// 한줄평 - 영화에 대한 정보(별점개수, 별점평균 포함)
	MovieVO movieInfo(String movie_id);

	// 한줄평 개수(영화별 유저들의 한줄평)
	int userReviewCount(String movie_id);

	// 한줄평 - 해당 한줄평에 달린 댓글List 가져오기
	List<Map<String, String>> commentList(String review_id);

	// 한줄평 - 로그인한 회원이 해당 영화에 대해 작성한 한줄평 유무 및 한줄평 정보
	Map<String, String> reviewInfo(Map<String, String> paraMap);

	// 한줄평 추가
	int addReview(MovieReviewVO mrvo);

	// 한줄평 삭제
	int deleteReview(String review_id);

	// 한줄평 수정
	int updateReview(MovieReviewVO mrvo);

	// 한줄평 - 좋아요 체크
	int addReviewLike(Map<String, String> paraMap);

	// 한줄평 - 좋아요 체크해제
	int delReviewLike(Map<String, String> paraMap);

	// 한줄평 - 좋아요개수 업데이트
	int updateLikeCount(Map<String, String> map);

	// 한줄평 - 댓글달기
	int addComment(ReviewCommentVO rcvo);
	
	// 한줄평 - 댓글 수정
	int updateReviewComment(ReviewCommentVO rcvo);

	// 한줄평 - 댓글 삭제
	int deleteComment(ReviewCommentVO rcvo);

	// 한줄평 - 댓글개수 업데이트
	int updateCommentCount(Map<String, String> paraMap);

	// 검색하기 - 검색조건에 해당하는 검색결과List 가져오기
	List<Map<String, String>> searchResult(Map<String, Object> paraMap);

	// 검색상세 - 영화정보(장르포함), 무비다이어리 가져오기
	Map<String, String> searchDetail(Map<String, String> paraMap);

	// 검색상세 - 해당 영화의 한줄평 가져오기
	MovieReviewVO searchReview(Map<String, String> paraMap);

	// 별점평가 등록하기
	int registerRating(Map<String, String> paraMap);

	// 별점평가 수정하기
	int updateRating(Map<String, String> paraMap);
	
	// 해당 영화에 대한 평균별점, 별점개수 값 읽어오기
	Map<String, String> getAvgRating(String movie_id);

	// 변경된 평균별점 값 update(movie 테이블에서 update)
	int updateAvgRating(Map<String, String> paraMap);
	
	// 포토티켓 등록하기
	int registerPhoto(MovieDiaryVO diaryvo);
	
	// 무비다이어리List 가져오기
	List<Map<String, String>> showMovieDiary(String user_id);

	// 무비다이어리(관람일자) 등록하기
	int registerDiary(MovieDiaryVO diaryvo);

	// 무비다이어리(관람일자) 수정하기
	int updateDiary(MovieDiaryVO diaryvo);

	// 선호장르 데이터 가져오기
	List<Map<String, String>> preference(String user_id);
	
	// 장르별 영화개수 알아오기
	int movieCountByGenre(String genre_id);

	// 장르별 영화 - 10개씩 페이징 처리
	List<Map<String, String>> moviesByGenrePaging(Map<String, String> paraMap);

	// 유저들의 별점평가 차트 데이터 가져오기
	Map<String, String> userRating(String movie_id);

}
