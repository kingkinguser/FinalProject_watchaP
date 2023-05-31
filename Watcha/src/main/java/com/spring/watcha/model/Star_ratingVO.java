package com.spring.watcha.model;

public class Star_ratingVO {

	private String movie_id;       // 영화 id
	private String user_id;        // 유저 id
	private String rating;         // 평점
	private String rating_date;    // 평점 등록 일자
	
	// 기본생성자
    public Star_ratingVO(){};
	   
    public Star_ratingVO(String movie_id, String user_id, String rating, String rating_date) {
    	this.movie_id = movie_id;
    	this.user_id = user_id;
    	this.rating = rating;
    	this.rating_date = rating_date;
    }

	public String getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getRating_date() {
		return rating_date;
	}

	public void setRating_date(String rating_date) {
		this.rating_date = rating_date;
	}
    
    
	
	
	
}
