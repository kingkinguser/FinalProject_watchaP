package com.spring.watcha.seosk.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.watcha.model.GenreVO;
import com.spring.watcha.model.MovieDiaryVO;
import com.spring.watcha.model.MovieReviewVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.ReviewCommentVO;
import com.spring.watcha.seosk.model.InterWatchaDAO;

@Service
public class WatchaService implements InterWatchaService {

	@Autowired
	private InterWatchaDAO dao;

	// 마이왓챠 기본정보 - 최근 평가한 영화 5개(프로필 배경에 사용)
	@Override
	public List<MovieVO> ratingFive(String user_id) {
		List<MovieVO> ratingFiveList = dao.ratingFive(user_id);
		if(ratingFiveList.size() < 5) { // 최근 평가한 영화가 5개 미만인 경우, 기본 프로필 배경을 사용한다.
			ratingFiveList = null;
		}
		return ratingFiveList;
	}

	// 마이왓챠 기본정보 - 평균 별점, 평가한 영화개수
	@Override
	public Map<String, String> userInfo(String user_id) {
		Map<String, String> userInfo = dao.userInfo(user_id);
		return userInfo;
	}
	
	// 한줄평 개수(로그인한 회원의 한줄평)
	@Override
	public int reviewCount(String user_id) {
		int reviewCount = dao.reviewCount(user_id);
		return reviewCount;
	}
	
	// 무비다이어리 - 포토티켓List 가져오기
	@Override
	public List<Map<String, String>> userPhotoTicket(String user_id) {
		List<Map<String, String>> userPhotoTicketList = dao.userPhotoTicket(user_id);
		return userPhotoTicketList;
	}

	// 검색하기 - 모든 종류의 장르 가져오기
	@Override
	public List<GenreVO> genreInfo() {
		List<GenreVO> genreList = dao.genreInfo();
		return genreList;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 회원이 평가한 영화 전체
	@Override
	public List<Map<String, String>> ratingMovies(String user_id) {
		List<Map<String, String>> ratingMoviesList = dao.ratingMovies(user_id);
		return ratingMoviesList;
	}
	
	// 회원의 한줄평 - 한줄평 8개씩 페이징 처리
	@Override
	public List<Map<String, String>> myReviewPaging(Map<String, String> paraMap) {
	    List<Map<String, String>> myReviewList = dao.myReviewPaging(paraMap);
		return myReviewList;
	}

	// 한줄평 페이지바 만들기(로그인한 회원의 한줄평)
	@Override
	public String makeReviewPageBar(Map<String, String> paraMap) {
		
		String user_id = paraMap.get("user_id");
		int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
		int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
		
		int totalCount = dao.reviewCount(user_id);
		int totalPage = (int)Math.ceil((double)totalCount/sizePerPage);

		int blockSize = 5; 
		int loop = 1; 
		int pageNo = ((currentShowPageNo - 1)/blockSize)*blockSize + 1;
		// 공식 pageNo = ((currentShowPageNo - 1)/blockSize)*blockSize + 1 을 이용하여 구한다.
		
		String pageBar = "<ul style='list-style: none;'>";
		  
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li><button type='button' onclick='myReviewPaging(1)'>[처음]</button></li>";
			pageBar += "<li><button type='button' onclick='myReviewPaging("+(pageNo-1)+")'>"+(pageNo-1)+"</button></li>";
		}
		  
		while(!(loop > blockSize || pageNo > totalPage)) {
		   if(pageNo == currentShowPageNo) {
		      pageBar += "<li style='color: #ff0558;'><button type='button' onclick='myReviewPaging("+pageNo+")'>"+pageNo+"</button></li>";
		   }
		   else {
			  pageBar += "<li><button type='button' onclick='myReviewPaging("+pageNo+")'>"+pageNo+"</button></li>";
		   }
		   loop++;
		   pageNo++;
		} // end of while
		  
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
		  pageBar += "<li><button type='button' onclick='myReviewPaging("+(pageNo+1)+")'>next</button></li>";
		  pageBar += "<li><button type='button' onclick='myReviewPaging("+totalPage+")'>[마지막]</button></li>"; 
		}
		pageBar += "</ul>";

		return pageBar;
	}

	// 회원이 평가한 영화 - 10개씩 페이징 처리
	@Override
	public List<Map<String, String>> rateMoviesPaging(Map<String, String> paraMap) {
	    List<Map<String, String>> rateMoviesList = dao.rateMoviesPaging(paraMap);
		return rateMoviesList;
	}

	// 영화별 유저들 한줄평 - 6개씩 페이징 처리
	@Override
	public List<Map<String, String>> movieReviewPaging(Map<String, String> paraMap) {
		List<Map<String, String>> reviewList = dao.movieReviewPaging(paraMap);
		return reviewList;
	}

	// 한줄평 - 영화에 대한 정보(별점개수, 별점평균 포함)
	@Override
	public MovieVO movieInfo(String movie_id) {
		MovieVO movieInfo = dao.movieInfo(movie_id);
		return movieInfo;
	}

	// 한줄평 개수(영화별 유저들의 한줄평)
	@Override
	public int userReviewCount(String movie_id) {
		int totalCount = dao.userReviewCount(movie_id);
		return totalCount;
	}

	// 한줄평 - 해당 한줄평에 달린 댓글List 가져오기
	@Override
	public List<Map<String, String>> commentList(String review_id) {
		List<Map<String, String>> commentList = dao.commentList(review_id);
		return commentList;
	}

	// 한줄평 - 로그인한 회원이 해당 영화에 대해 작성한 한줄평 유무 및 한줄평 정보
	@Override
	public Map<String, String> reviewInfo(Map<String, String> paraMap) {
		Map<String, String> reviewInfo = dao.reviewInfo(paraMap);
		return reviewInfo;
	}

	// 한줄평 추가
	@Override
	public int addReview(MovieReviewVO mrvo) {
		int n = dao.addReview(mrvo);
		return n;
	}

	// 한줄평 삭제
	@Override
	public int deleteReview(String review_id) {
		int n = dao.deleteReview(review_id);
		return n;
	}

	// 한줄평 수정
	@Override
	public int updateReview(MovieReviewVO mrvo) {
		int n = dao.updateReview(mrvo);
		return n;
	}
	
	// 한줄평 - 좋아요 체크
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	@Override
	public int addReviewLike(Map<String, String> paraMap) {

		int n=0, result=0; 
		n = dao.addReviewLike(paraMap); // 한줄평에 좋아요 체크(review_like 테이블에 insert)
		
		if(n == 1) {
			Map<String, String> map = new HashMap<>();
			map.put("review_id", paraMap.get("review_id"));
			map.put("number_of_likes", "+1");
			
			result = dao.updateLikeCount(map); // 한줄평에 좋아요개수 증가(movie_review 테이블의 데이터 update)
		}
		
		return result;
	}

	// 한줄평 - 좋아요 체크해제
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	@Override
	public int delReviewLike(Map<String, String> paraMap) {

		int n=0, result=0; 
		n = dao.delReviewLike(paraMap); // 한줄평에 좋아요 체크해제(review_like 테이블에 delete)
		
		if(n == 1) {
			Map<String, String> map = new HashMap<>();
			map.put("review_id", paraMap.get("review_id"));
			map.put("number_of_likes", "-1");
			
			result = dao.updateLikeCount(map); // 한줄평에 좋아요개수 감소(movie_review 테이블의 데이터 update)
		}
		
		return result;
	}

	// 한줄평 - 댓글달기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addComment(ReviewCommentVO rcvo) {
		
		int n=0, result=0; 
		n = dao.addComment(rcvo); // 한줄평에 댓글달기(review_comment 테이블에 insert)
		
		if(n == 1) {
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("review_id", rcvo.getReview_id());
			paraMap.put("number_of_comments", "+1");
			
			result = dao.updateCommentCount(paraMap); // 한줄평에 댓글개수 증가(movie_review 테이블의 데이터 update)
		}
		
		return result;
	}

	// 한줄평 - 댓글 수정
	@Override
	public int updateComment(ReviewCommentVO rcvo) {
		int n = dao.updateComment(rcvo);
		return n;
	}

	// 한줄평 - 댓글 삭제
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int deleteComment(ReviewCommentVO rcvo) {
		
		int n=0, result=0; 
		n = dao.deleteComment(rcvo); // 한줄평에 댓글삭제(review_comment 테이블에 delete)
		
		if(n == 1) {
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("review_id", rcvo.getReview_id());
			paraMap.put("number_of_comments", "-1");
			
			result = dao.updateCommentCount(paraMap); // 한줄평에 댓글개수 감소(movie_review 테이블의 데이터 update)
		}
		
		return result;
	}

	// 검색하기 - 검색조건에 해당하는 검색결과List 가져오기
	@Override
	public List<Map<String, String>> searchResult(Map<String, Object> paraMap) {
		List<Map<String, String>> searchList = dao.searchResult(paraMap);
		return searchList;
	}

	// 검색상세 - 영화정보(장르포함), 무비다이어리 가져오기
	@Override
	public Map<String, String> searchDetail(Map<String, String> paraMap) {
		Map<String, String> searchDetail = dao.searchDetail(paraMap);
		return searchDetail;
	}

	// 검색상세 - 해당 영화의 한줄평 가져오기
	@Override
	public MovieReviewVO searchReview(Map<String, String> paraMap) {
		MovieReviewVO searchReview = dao.searchReview(paraMap);
		return searchReview;
	}

	// 별점평가 등록하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int registerRating(Map<String, String> paraMap) {

		int n=0, result=0; 
		n = dao.registerRating(paraMap); // 회원의 별점평가 등록(star_rating 테이블에서 insert)
		
		Map<String, String> ratingInfo = null;
		if(n == 1) {
			ratingInfo = dao.getAvgRating(paraMap.get("movie_id")); // 해당 영화에 대한 평균별점, 별점개수 값 읽어오기
		}
		if(ratingInfo != null) {
			paraMap.put("rating_avg", ratingInfo.get("rating_avg"));
			paraMap.put("rating_count", ratingInfo.get("rating_count"));
			result = dao.updateAvgRating(paraMap); // 변경된 평균별점 값 update(movie 테이블에서 update)
		}
		
		return result;
	}
	
	// 별점평가 수정하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int updateRating(Map<String, String> paraMap) {

		int n=0, result=0; 
		n = dao.updateRating(paraMap); // 회원의 별점평가 수정(star_rating 테이블에서 update)
		
		Map<String, String> ratingInfo = null;
		if(n == 1) {
			ratingInfo = dao.getAvgRating(paraMap.get("movie_id")); // 해당 영화에 대한 평균별점, 별점개수 값 읽어오기
		}
		if(ratingInfo != null) {
			paraMap.put("rating_avg", ratingInfo.get("rating_avg"));
			paraMap.put("rating_count", ratingInfo.get("rating_count"));
			result = dao.updateAvgRating(paraMap); // 변경된 평균별점 값 update(movie 테이블에서 update)
		}
		
		return result;
	}

	// 포토티켓 등록하기
	@Override
	public int registerPhoto(MovieDiaryVO diaryvo) {
		int n = dao.registerPhoto(diaryvo);
		return n;
	}

	// 무비다이어리List 가져오기
	@Override
	public List<Map<String, String>> showMovieDiary(String user_id) {
		List<Map<String, String>> movieDiaryList = dao.showMovieDiary(user_id);
		return movieDiaryList;
	}

	// 무비다이어리(관람일자) 등록하기
	@Override
	public int registerDiary(MovieDiaryVO diaryvo) {
		int n = dao.registerDiary(diaryvo);
		return n;
	}

	// 무비다이어리(관람일자) 수정하기
	@Override
	public int updateDiary(MovieDiaryVO diaryvo) {
		int n = dao.updateDiary(diaryvo);
		return n;
	}

}
