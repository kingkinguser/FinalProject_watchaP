package com.spring.watcha.chimp.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.spring.watcha.chimp.model.InterCommunityDAO;
import com.spring.watcha.model.InterWatchaDAO;
import com.spring.watcha.model.MemberVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.PostCommentVO;
import com.spring.watcha.model.PostVO;

import info.movito.themoviedbapi.TmdbApi;
import info.movito.themoviedbapi.TmdbPeople;
import info.movito.themoviedbapi.model.Credits;
import info.movito.themoviedbapi.model.MovieDb;
import info.movito.themoviedbapi.model.people.PersonCast;
import info.movito.themoviedbapi.model.people.PersonPeople;

@Component
@Service
public class CommunityService implements InterCommunityService{
	
	
	
	private static final int COMMENT_PAGE_SIZE = 10;
	private static final int POST_PAGE_SIZE = 10;
	private static final int POST_PAGE_BAR_SIZE = 10;
	
	@Autowired
	private InterCommunityDAO dao;

	@Override
	public int insertMovie(List<MovieDb> movieList) {

		
		//영화 detail insert
		//영화의 장르테이블에 영화별 장르 insert
		int n = dao.insertMovie(movieList);
		int m = dao.insertMovieGenres(movieList);
		
		
		String apiKey = System.getenv("TMDB_API_KEY");
		TmdbPeople peoples = new TmdbApi(apiKey).getPeople();
		
		//배역에 해당하는 인물 id가 테이블에 입력되지 않았다면 배우 데이터부터 insert.
		
		
		for(MovieDb movieDetail: movieList) {
			if(movieDetail.getBackdropPath() == null || movieDetail.getPosterPath() == null) {
				continue;
			}
			Credits credits = movieDetail.getCredits();
			if(credits.getCast().size() > 10) {
				credits.setCast(new ArrayList<PersonCast>(credits.getCast().subList(0, 10)));
				movieDetail.setCredits(credits);
				
			}
			List<PersonCast> casts = credits.getCast(); //영화의 캐스팅 테이블에 배역별 역할 insert
			
			
			for(PersonCast person: casts) {

				if(!dao.isExistPerson(person)) { 
					PersonPeople actor = peoples.getPersonInfo(person.getId());
					dao.insertPerson(actor); 
					
				}
				 
			}
			if(casts.size() > 0) {
				dao.insertCasts(movieDetail);
			}
			
		}
		 

		return n;
	}

	
	@Override
	public MovieVO getMovieDetail(String movieId) {
		MovieVO movie = dao.getMovieDetail(movieId);
		return movie;
	}


	@Override
	public List<MovieVO> getMoviesByKeyword(String search) {
		List<MovieVO> movies = dao.getMoviesByKeyword(search);
		return movies;
	}


	@Override
	public MovieVO getMovieByMovieId(String search) {
		MovieVO movie = dao.getMovieByMovieId(search); 
		return movie;
	}


	@Override
	public int insertPost(PostVO post) {
		int n = dao.insertPost(post);
		return n;
	}


	@Override
	public Model getPostsByParam(Map<String, String> paraMap, Model model) {
		int pageNo = Integer.parseInt(paraMap.getOrDefault("page", "1"));
		
		
		int totalPosts = dao.getTotaPosts(paraMap);
		int pageSize = POST_PAGE_SIZE;
		int offSet = (pageNo - 1) * pageSize;
		
		paraMap.put("offset", String.valueOf(offSet));
		paraMap.put("rows", String.valueOf(pageSize));
		
		
		int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
		int pageBarSize = POST_PAGE_BAR_SIZE;
		int startPage = ((pageNo - 1)/pageBarSize) * pageBarSize + 1;
		int endPage = Math.min(totalPages, startPage + pageBarSize - 1);
		
		
		
		List<PostVO> posts = dao.getPostsByParam(paraMap);
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();

//		System.out.println(gson.toJson(posts));
		
		List<Map<String, String>> categories = dao.getPostCategories();
		
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("pageNo", pageNo);
        model.addAttribute("posts", posts);
        model.addAttribute("categories", categories);
		
		return model;
	}


	@Override
	public Model getPostById(String postId, Model model) {
		PostVO post = dao.getPostById(postId);
		model.addAttribute("selectedPost", post);
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();

		System.out.println(gson.toJson(post));
		
		return model;
	}


	@Override
	public String getPostCommentList(Map<String, String> paraMap) {
		
		
		if(!com.spring.watcha.common.ValidationUtils.isValidPageNumber(paraMap.getOrDefault("page", "1"))) {
			throw new IllegalArgumentException("잘못된 페이지 번호 입력");
		}
		
		int totalComments = dao.getToalPostComments(paraMap);
		int pageNo = Integer.parseInt(paraMap.getOrDefault("page", "1"));
		int pageSize = COMMENT_PAGE_SIZE;
		
		int offSet = (pageNo - 1) * pageSize;
		
		paraMap.put("offset", String.valueOf(offSet));
		paraMap.put("rows", String.valueOf(pageSize));
		
		
		int totalPages = (int) Math.ceil((double) totalComments / pageSize);
		int pageBarSize = POST_PAGE_BAR_SIZE;
		int startPage = ((pageNo - 1)/pageBarSize) * pageBarSize + 1;
		int endPage = Math.min(totalPages, startPage + pageBarSize - 1);
		
		List<PostCommentVO> comments = dao.getPostComments(paraMap);
		Gson gson = new Gson();

		JsonObject result = new JsonObject();
		result.add("comments", gson.toJsonTree(comments));
		result.addProperty("startPage", startPage);
		result.addProperty("endPage", endPage);
		result.addProperty("totalPages", totalPages);
		result.addProperty("currentPage", pageNo);
		
		String resultStr = gson.toJson(result); 
		
		
		
		return resultStr;
	}

	

	@Override
	public Map<String, Object> getPostCommentData(Map<String, String> paraMap) {
		int totalComments = dao.getToalPostComments(paraMap);
		int pageSize = COMMENT_PAGE_SIZE;
		int totalPages = (int) Math.ceil((double) totalComments / pageSize);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalComments", totalComments);
		result.put("totalPages", totalPages);
		
		return result;
	}
	
	

	@Override
	public Map<String, Object> createPostComment(PostCommentVO postComment) {
		postComment = dao.createPostComment(postComment);
		if(postComment != null) {
			return getPostCommentIndex(postComment);
		} else {
			return null;
		}
		 
	}
	
	@Override
	public Map<String, Object> getPostCommentIndex(PostCommentVO postComment) {
		int rownum = dao.getRownumOfComment(postComment);
		int page = ((rownum - 1) / COMMENT_PAGE_SIZE) + 1;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("commentId", postComment.getCommentId());
		map.put("page", page);
		return map;
	}


	@Override
	public int deletePostComment(String commentId, HttpServletRequest request) {
		String userid = dao.getUseridByCommentId(commentId);
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(!loginuser.getUser_id().equals(userid)) {
			return 0;
		}


		PostCommentVO postComment = new PostCommentVO();
		postComment.setCommentId(Integer.parseInt(commentId));
		int rownum = dao.getRownumOfComment(postComment);
		
		int page = ((rownum - 1) / COMMENT_PAGE_SIZE) + 1; 
		
		
		int n = dao.deletePostComment(commentId);
		
		if(n > 0) {
			return page;
		} else {
			return 0;
		}

	}


	@Override
	public Map<String, Object> insertLikes(String postId, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser == null) return null;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("postId", postId);
		paraMap.put("userId", loginuser.getUser_id());
//		paraMap.put("userId", "qwer1234");
		
				
		Map<String, Object> result = new HashMap<>();
		
		
		int n =dao.insertPostLikes(paraMap);
		if(n > 0) {
			result.put("status", 1);	
		}
//		dao.deletePostLikes(paraMap);
//		result.put("status", 0);
		int count = dao.getLikesCount(paraMap);
		result.put("count", count);
		
		return result;
	}

	@Override
	public Map<String, Object> deleteLikes(String postId, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser == null) return null;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("postId", postId);
		paraMap.put("userId", loginuser.getUser_id());

		Map<String, Object> result = new HashMap<>();		
		int n = dao.deletePostLikes(paraMap);

		if(n > 0) {
			result.put("status", 0);	
		}

		int count = dao.getLikesCount(paraMap);
		result.put("count", count);
		
		return result;
	}
	@Override
	public Map<String, Object> hasLikedPost(String postId, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser == null) return null;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("postId", postId);
		paraMap.put("userId", loginuser.getUser_id());

		int n = dao.hasLikedPost(paraMap);

		Map<String, Object> result = new HashMap<>();
		result.put("status", n);

		return result;
	}




	
	private HttpSession getSession() {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        return attr.getRequest().getSession(true);
    }


	@Override
	public boolean isPostAccessed(String postId) {
        HttpSession session = getSession();
        Boolean viewed = (Boolean) session.getAttribute("viewedPost_" + postId);
        return viewed != null && viewed;
	}


	@Override
	public void incrementViewCount(String postId) {
		dao.incrementViewCount(postId);
	}


	@Override
	public Map<String, Object> deletePost(Map<String, String> paraMap) {
		int n = dao.deletePost(paraMap);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("status", n);
		if(n == 0) {
			result.put("alertMessage", "게시글 삭제에 실패했습니다. 로그인 상태를 확인하시고 다시 시도해주세요.");
		}
		return result;
	}


	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Throwable.class})
	public Map<String, Object> editPost(PostVO post) {
		// 영화 리스트 갱신을 위해서 post tags에 해당 게시글의 영화 삭제
		PostVO tempPost= dao.getPostById(post.getPostId());
		HttpSession session = getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(!loginuser.getUser_id().equals(tempPost.getUserId())) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("status", "error");
			return map;
		}
		
		dao.deletePostTags(post);
		
		// 게시글 갱신
		int a = dao.editPost(post);
		int b = 0;
		if(post.getMovieIds().size() > 0) {
			b = dao.insertPostTags(post);	
		}
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(a == 1 && b == post.getMovieIds().size()) {
			map.put("status", 1);
		} else {
			map.put("status", 0);
		}
		
		return map;
	}

	
	
	


}
