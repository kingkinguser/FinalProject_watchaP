package com.spring.watcha.chimp.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.PostCommentVO;
import com.spring.watcha.model.PostVO;

import info.movito.themoviedbapi.model.MovieDb;

public interface InterCommunityService {

	int insertMovie(List<MovieDb> movieSet);

	MovieVO getMovieDetail(String movieId);

	List<MovieVO> getMoviesByKeyword(String search);

	MovieVO getMovieByMovieId(String search);

	int insertPost(PostVO post);

	Model getPostsByParam(Map<String, String> paraMap, Model model);

	Model getPostById(String post, Model model);

	String getPostCommentList(Map<String, String> paraMap);

	Map<String, Object> createPostComment(PostCommentVO postComment);

	int deletePostComment(String commentId, HttpServletRequest request);

	Map<String, Object> getPostCommentIndex(PostCommentVO postComment);

	Map<String, Object> insertLikes(String postId, HttpServletRequest request);

	Map<String, Object> hasLikedPost(String postId, HttpServletRequest request);

	Map<String, Object> deleteLikes(String postId, HttpServletRequest request);

	Map<String, Object> getPostCommentData(Map<String, String> paraMap);

	boolean isPostAccessed(String postId);

	void incrementViewCount(String postId);

}
