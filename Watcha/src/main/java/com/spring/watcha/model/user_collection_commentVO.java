package com.spring.watcha.model;

public class user_collection_commentVO {

	private String user_collection_seq;  	  // 댓글번호

	private String user_id_collection;  	  // 컬렉션 보유아이디
	private String user_id_comment;			  // 댓글단 유저 아이디
	private String user_collection_content;   // 댓글내용
	private String user_collection_time;  	  // 작성시간
	private String user_collection_status;    // 글삭제여부
	
	public String getUser_collection_seq() {
		return user_collection_seq;
	}
	public void setUser_collection_seq(String user_collection_seq) {
		this.user_collection_seq = user_collection_seq;
	}
	public String getUser_id_collection() {
		return user_id_collection;
	}
	public void setUser_id_collection(String user_id_collection) {
		this.user_id_collection = user_id_collection;
	}
	public String getUser_id_comment() {
		return user_id_comment;
	}
	public void setUser_id_comment(String user_id_comment) {
		this.user_id_comment = user_id_comment;
	}
	public String getUser_collection_content() {
		return user_collection_content;
	}
	public void setUser_collection_content(String user_collection_content) {
		this.user_collection_content = user_collection_content;
	}
	public String getUser_collection_time() {
		return user_collection_time;
	}
	public void setUser_collection_time(String user_collection_time) {
		this.user_collection_time = user_collection_time;
	}
	public String getUser_collection_status() {
		return user_collection_status;
	}
	public void setUser_collection_status(String user_collection_status) {
		this.user_collection_status = user_collection_status;
	}
	
	
	
}
