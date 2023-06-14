package com.spring.watcha.chimp.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.PostCommentVO;
import com.spring.watcha.model.PostVO;

import info.movito.themoviedbapi.model.MovieDb;
import info.movito.themoviedbapi.model.people.PersonCast;
import info.movito.themoviedbapi.model.people.PersonPeople;

public interface InterCommunityDAO {

	int insertMovie(List<MovieDb> movieList);

	int insertMovieGenres(List<MovieDb> movieList);

	boolean isExistPerson(PersonCast person);

	int insertPerson(PersonPeople actor);

	int insertCasts(MovieDb movieDetail);

	MovieVO getMovieDetail(String movieId);

	List<MovieVO> getMoviesByKeyword(String search);

	MovieVO getMovieByMovieId(String search);

	int insertPost(PostVO post);

	int getTotaPosts(Map<String, String> paraMap);

	List<PostVO> getPostsByParam(Map<String, String> paraMap);

	PostVO getPostById(String postId);

	int getToalPostComments(Map<String, String> paraMap);

	List<PostCommentVO> getPostComments(Map<String, String> paraMap);

	List<Map<String, String>> getPostCategories();

	PostCommentVO createPostComment(PostCommentVO postComment);

	String getUseridByCommentId(String commentId);

	int deletePostComment(String commentId);

	int getRownumOfComment(PostCommentVO postComment);

	int hasLikedPost(Map<String, String> paraMap);

	int insertPostLikes(Map<String, String> paraMap);

	int deletePostLikes(Map<String, String> paraMap);

	int getLikesCount(Map<String, String> paraMap);

	void incrementViewCount(String postId);

}
