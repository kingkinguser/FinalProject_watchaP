package com.spring.watcha.model;

public class collectionVO {
	
	private int collection_id;
	private String user_id;
	private String collection_name;
	private int creation_date;
	
	public collectionVO() {}
	
	public collectionVO(int collection_id, String user_id, String collection_name, int creation_date) {
		super();
		this.collection_id = collection_id;
		this.user_id = user_id;
		this.collection_name = collection_name;
		this.creation_date = creation_date;
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
	
	public String getCollection_name() {
		return collection_name;
	}
	
	public void setCollection_name(String collection_name) {
		this.collection_name = collection_name;
	}
	
	public int getCreation_date() {
		return creation_date;
	}
	
	public void setCreation_date(int creation_date) {
		this.creation_date = creation_date;
	}
	
	
	
}
