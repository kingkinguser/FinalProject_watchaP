package com.spring.watcha.model;

import java.util.List;

public class MovieVO {
	
	private String movie_id;          // 영화 아이디
	private String movie_title;       // 영화 제목
	private String overview;          // 영화 개요
    private String original_language; // 언어
    private String original_title;    // 원제목
    private String release_date;      // 개봉일자
    private String tagline;           // 슬로건
    private String runtime;			  // 러닝 타임 
    private String poster_path;       // 포스터 url
    private String backdrop_path;     // 포스터 url 백업
    private String rating_count;         // 평균 별점
    private String rating_avg;           // 평가 수 
    private List<GenreVO> genres;
    private List<Movie_roleVO> movieRoles;  
    private List<Star_ratingVO> starRating;
    private List<ActorVO> actor;
     
    // 기본생성자
    public MovieVO(){};
	   
    public MovieVO(String movie_id, String movie_title, String overview, String original_language, String original_title, String release_date,
  		  String tagline, String runtime, String poster_path, String backdrop_path, String rating_avg, String rating_count,
  		  List<GenreVO> genres, List<Movie_roleVO> movieRoles, List<Star_ratingVO> starRating, List<ActorVO> actor ) {
	
	this.movie_id = movie_id;
	this.movie_title = movie_title;
	this.overview = overview;
	this.original_language = original_language;
	this.original_title = original_title;
	this.release_date = release_date;
	this.tagline = tagline;
	this.runtime = runtime;
	this.poster_path = poster_path;
	this.backdrop_path = backdrop_path;
	this.rating_avg = rating_avg;
	this.rating_count = rating_count;
	this.genres = genres;
	this.movieRoles = movieRoles;
	this.starRating = starRating;
	this.actor = actor;
	}

    
	public String getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}

	public String getMovie_title() {
		return movie_title;
	}

	public void setMovie_title(String movie_title) {
		this.movie_title = movie_title;
	}

	public String getOverview() {
		return overview;
	}

	public void setOverview(String overview) {
		this.overview = overview;
	}

	public String getOriginal_language() {
		return original_language;
	}

	public void setOriginal_language(String original_language) {
		this.original_language = original_language;
	}

	public String getOriginal_title() {
		return original_title;
	}

	public void setOriginal_title(String original_title) {
		this.original_title = original_title;
	}

	public String getRelease_date() {
		return release_date;
	}

	public void setRelease_date(String release_date) {
		this.release_date = release_date;
	}

	public String getTagline() {
		return tagline;
	}

	public void setTagline(String tagline) {
		this.tagline = tagline;
	}

	public String getRuntime() {
		return runtime;
	}

	public void setRuntime(String runtime) {
		this.runtime = runtime;
	}

	public String getPoster_path() {
		return poster_path;
	}

	public void setPoster_path(String poster_path) {
		this.poster_path = poster_path;
	}

	public String getBackdrop_path() {
		return backdrop_path;
	}

	public void setBackdrop_path(String backdrop_path) {
		this.backdrop_path = backdrop_path;
	}

	public String getRating_count() {
		return rating_count;
	}

	public void setRating_count(String rating_count) {
		this.rating_count = rating_count;
	}

	public String getRating_avg() {
		return rating_avg;
	}

	public void setRating_avg(String rating_avg) {
		this.rating_avg = rating_avg;
	}

	public List<GenreVO> getGenres() {
		return genres;
	}

	public void setGenres(List<GenreVO> genres) {
		this.genres = genres;
	}

	public List<Movie_roleVO> getMovieRoles() {
		return movieRoles;
	}

	public void setMovieRoles(List<Movie_roleVO> movieRoles) {
		this.movieRoles = movieRoles;
	}

	public List<Star_ratingVO> getStarRating() {
		return starRating;
	}

	public void setStarRating(List<Star_ratingVO> starRating) {
		this.starRating = starRating;
	}
	  
	public List<ActorVO> getActor() {
		return actor;
	}

	public void setActor(List<ActorVO> actor) {
		this.actor = actor;
	}

	
	
	
}
