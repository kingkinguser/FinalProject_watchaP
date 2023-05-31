package com.spring.watcha.model;

public class ReviewCommentVO {

	// field
    private String comment_id;	 // 한줄평댓글 ID
    private String review_id;	 // 한줄평 ID
    private String user_id;		 // 회원 아이디
    private String content;		 // 댓글내용
    private String comment_date; // 댓글 등록일자

    // 기본생성자
    public ReviewCommentVO() {}
    
    // 파라미터 생성자
	public ReviewCommentVO(String comment_id, String review_id, String user_id, String content, String comment_date) {
		this.comment_id = comment_id;
		this.review_id = review_id;
		this.user_id = user_id;
		this.content = content;
		this.comment_date = comment_date;
	}

	public String getComment_id() {
		return comment_id;
	}

	public void setComment_id(String comment_id) {
		this.comment_id = comment_id;
	}

	public String getReview_id() {
		return review_id;
	}

	public void setReview_id(String review_id) {
		this.review_id = review_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getComment_date() {
		return comment_date;
	}

	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}

}
