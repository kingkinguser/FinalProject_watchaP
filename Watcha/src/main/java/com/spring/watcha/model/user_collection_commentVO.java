package com.spring.watcha.model;

public class user_collection_commentVO {

	private String collection_id;  	  	      // 콜렉션ID
	private String user_id;  	              // 아이디
	private String user_collection_seq;  	  // 댓글번호
	private String user_collection_content;   // 댓글내용
	private String user_collection_time;  	  // 작성시간
	private String user_collection_status;    // 글삭제여부
	
	public user_collection_commentVO() {}
	
	public user_collection_commentVO(String collection_id, String user_id, String user_collection_seq,
			String user_collection_content, String user_collection_time, String user_collection_status) {
		super();
		this.collection_id = collection_id;
		this.user_id = user_id;
		this.user_collection_seq = user_collection_seq;
		this.user_collection_content = user_collection_content;
		this.user_collection_time = user_collection_time;
		this.user_collection_status = user_collection_status;
	}

	public String getCollection_id() {
		return collection_id;
	}

	public void setCollection_id(String collection_id) {
		this.collection_id = collection_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_collection_seq() {
		return user_collection_seq;
	}

	public void setUser_collection_seq(String user_collection_seq) {
		this.user_collection_seq = user_collection_seq;
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
