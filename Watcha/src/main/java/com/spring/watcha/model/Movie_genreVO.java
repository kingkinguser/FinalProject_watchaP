package com.spring.watcha.model;

public class Movie_genreVO {

	private String movie_id;    // 영화 id
	private String genre_id;    // 장르 id
	
	public Movie_genreVO(){};
	
	public Movie_genreVO(String movie_id, String genre_id) {
		
		this.movie_id = movie_id;
		this.genre_id = genre_id;
	}

	public String getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}

	public String getGenre_id() {
		return genre_id;
	}

	public void setGenre_id(String genre_id) {
		this.genre_id = genre_id;
	}
	
}
