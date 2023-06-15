package com.spring.watcha.chimp.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.PostCommentVO;
import com.spring.watcha.model.PostVO;

import info.movito.themoviedbapi.model.MovieDb;
import info.movito.themoviedbapi.model.people.PersonCast;
import info.movito.themoviedbapi.model.people.PersonPeople;

@Component
@Repository
public class CommunityDAO implements InterCommunityDAO {

	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	

	@Override
	public int insertMovie(List<MovieDb> movieList) {
		int n = sqlsession.update("community.insertMovies", movieList);
		return n;
	}

	@Override
	public int insertMovieGenres(List<MovieDb> movieList) {
		int n = sqlsession.update("community.insertMovieGenres", movieList);
		return n;
	}

	@Override
	public boolean isExistPerson(PersonCast person) {
		int n = sqlsession.selectOne("community.isExistPerson", person);
		
		return (n == 1);
	}

	@Override
	public int insertPerson(PersonPeople actor) {
		int n = sqlsession.insert("community.insertPerson", actor);
		return n;
		
	}

	@Override
	public int insertCasts(MovieDb movie) {
		int n = sqlsession.update("community.insertCasts", movie);
		return n;
	}

	
	
	//// 까지 TMDB API 관련 
	
	
	@Override
	public MovieVO getMovieDetail(String movieId) {
		MovieVO movie = sqlsession.selectOne("community.getMovieDetails", movieId); 
		
		return movie;
	}

	@Override
	public List<MovieVO> getMoviesByKeyword(String search) {
		List<MovieVO> movies = sqlsession.selectList("community.getMoviesByKeyword", search);
		return movies;
	}

	@Override
	public MovieVO getMovieByMovieId(String search) {
		MovieVO movie = sqlsession.selectOne("community.getMovieByMovieId", search);
		return movie;
	}

	
	@Override
	public int insertPost(PostVO post) {
		int n = sqlsession.update("community.insertPost", post);
		if (n>0) {
			return Integer.parseInt(post.getPostId());
		} else {
			return 0;
		}

	}

	@Override
	public int getTotaPosts(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("community.getTotalPosts", paraMap);
		
		return n;
	}

	@Override
	public List<PostVO> getPostsByParam(Map<String, String> paraMap) {
		
		List<PostVO> posts = sqlsession.selectList("community.getPostsByParam", paraMap);
		return posts;
	}

	@Override
	public PostVO getPostById(String postId) {

		PostVO post = sqlsession.selectOne("community.getPostById", postId); 
		return post;
	}

	@Override
	public int getToalPostComments(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("community.getToalPostComments", paraMap);
		return n;
	}

	@Override
	public List<PostCommentVO> getPostComments(Map<String, String> paraMap) {
		List<PostCommentVO> comments = sqlsession.selectList("community.getPostComments", paraMap);
		return comments;
	}

	@Override
	public List<Map<String, String>> getPostCategories() {
		List<Map<String, String>> categories = sqlsession.selectList("community.getPostCategories");
		return categories;
	}

	@Override
	public PostCommentVO createPostComment(PostCommentVO postComment) {
		int n = sqlsession.insert("community.createPostComment", postComment);
		if(n > 0) {
			return postComment;
		} else {
			return null;
		}
		
	}
	
	@Override
	public int getRownumOfComment(PostCommentVO postComment) {
		int rownum = sqlsession.selectOne("community.getRownumOfComment", postComment);
		return rownum;
	}

	
	
	@Override
	public String getUseridByCommentId(String commentId) {
		String userId = sqlsession.selectOne("community.getUseridByCommentId", commentId); 
		return userId;
	}

	@Override
	public int deletePostComment(String commentId) {
		int a = sqlsession.selectOne("community.getChildCommentCount", commentId);

		int b = 0;
		if(a > 0) {
			b = sqlsession.update("community.updatePostCommentStatus", commentId);
		} else {
			b = sqlsession.delete("community.deletePostComment",commentId);
		}
		
		return b;
	}

	
	// 좋아요 처리 method
	
	@Override
	public int hasLikedPost(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("community.hasLikedPost", paraMap);
		return n;
	}

	@Override
	public int insertPostLikes(Map<String, String> paraMap) {
		int n = sqlsession.insert("community.insertPostLikes",paraMap);
		return n;
	}

	@Override
	public int deletePostLikes(Map<String, String> paraMap) {
		int n = sqlsession.delete("community.deletePostLikes",paraMap);
		return n;
	}

	@Override
	public int getLikesCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("community.getLikesCount",paraMap);
		paraMap.put("count", String.valueOf(n));
		sqlsession.update("community.updatePostLikes", paraMap);
		return n;
	}

	@Override
	public void incrementViewCount(String postId) {
		sqlsession.update("community.incrementViewCount", postId);
	}

	@Override
	public int deletePost(Map<String, String> paraMap) {
		int n = sqlsession.delete("community.deletePost", paraMap);
		return n;
	}

	@Override
	public void deletePostTags(PostVO post) {
		sqlsession.delete("community.deletePostTags", post);
	}

	@Override
	public int editPost(PostVO post) {
		int n = sqlsession.update("community.editPost", post);
		return n;
	}

	@Override
	public int insertPostTags(PostVO post) {
		int n = sqlsession.update("community.insertPostTags", post);
		return n;
	}


	
}
