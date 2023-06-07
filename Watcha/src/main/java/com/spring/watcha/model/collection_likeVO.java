package com.spring.watcha.model;

public class collection_likeVO {
	
	private int collection_id;
	private String user_id;
	
	public collection_likeVO() {}
	
	public collection_likeVO(int collection_id, String user_id) {
		super();
		this.collection_id = collection_id;
		this.user_id = user_id;
	}

	public int getCollection_id() {
		return collection_id;
	}

	public void setCollection_id(int collection_id) {
		this.collection_id = collection_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	
	
}
