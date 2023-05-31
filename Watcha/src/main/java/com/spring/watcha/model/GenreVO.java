package com.spring.watcha.model;

public class GenreVO {

	private String genre_id;     // 장르 id
	private String genre_name;   // 장르명
	
	
	public GenreVO(){};
	
	public GenreVO(String genre_id, String genre_name) {
		this.genre_id = genre_id;
		this.genre_name = genre_name;
	}

	
	public String getGenre_id() {
		return genre_id;
	}

	public void setGenre_id(String genre_id) {
		this.genre_id = genre_id;
	}

	public String getGenre_name() {
		return genre_name;
	}

	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}

}
