package com.spring.watcha.model;

public class collection_likeVO {
	
	private String user_id;
	
	public collection_likeVO() {}
	
	public collection_likeVO(String user_id) {
		super();	
		this.user_id = user_id;
	}


	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	
	
}
