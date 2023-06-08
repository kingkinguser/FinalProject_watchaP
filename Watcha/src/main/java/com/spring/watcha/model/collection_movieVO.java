package com.spring.watcha.model;

public class collection_movieVO {
	
	private String user_id;
	private String movie_id;
	
	public collection_movieVO() {}
	
	public collection_movieVO(String user_id, String movie_id) {
		super();
		this.user_id = user_id;
		this.movie_id = movie_id;
	}

	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}

	
	
}
