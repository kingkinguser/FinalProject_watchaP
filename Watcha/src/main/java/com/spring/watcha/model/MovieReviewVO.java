package com.spring.watcha.model;

public class MovieReviewVO {

	// field
    private String review_id;			// 한줄평 ID   
    private String movie_id;			// 영화 ID
    private String user_id;				// 회원 아이디
    private String review_content;		// 한줄평 내용
    private String review_date;			// 등록날짜
    private String spoiler_status;		// 스포일러 여부 (0 이면 스포일러 포함X, 1 이면 스포일러 포함O)
    private String number_of_likes;		// 좋아요 개수
    private String number_of_comments;	// 댓글 개수
	
    // 기본생성자
    public MovieReviewVO() {}
    
    // 파라미터 생성자
    public MovieReviewVO(String review_id, String movie_id, String user_id, String review_content, String review_date,
						 String spoiler_status, String number_of_likes, String number_of_comments) {
		this.review_id = review_id;
		this.movie_id = movie_id;
		this.user_id = user_id;
		this.review_content = review_content;
		this.review_date = review_date;
		this.spoiler_status = spoiler_status;
		this.number_of_likes = number_of_likes;
		this.number_of_comments = number_of_comments;
	}

	public String getReview_id() {
		return review_id;
	}

	public void setReview_id(String review_id) {
		this.review_id = review_id;
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

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public String getReview_date() {
		return review_date;
	}

	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}

	public String getSpoiler_status() {
		return spoiler_status;
	}

	public void setSpoiler_status(String spoiler_status) {
		this.spoiler_status = spoiler_status;
	}

	public String getNumber_of_likes() {
		return number_of_likes;
	}

	public void setNumber_of_likes(String number_of_likes) {
		this.number_of_likes = number_of_likes;
	}

	public String getNumber_of_comments() {
		return number_of_comments;
	}

	public void setNumber_of_comments(String number_of_comments) {
		this.number_of_comments = number_of_comments;
	}

}
