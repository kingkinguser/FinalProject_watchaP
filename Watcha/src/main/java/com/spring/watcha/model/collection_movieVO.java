package com.spring.watcha.model;

public class collection_movieVO {
	
	private int collection_id;
	private String movie_id;
	
	public collection_movieVO() {}
	
	public collection_movieVO(int collection_id, String movie_id) {
		super();
		this.collection_id = collection_id;
		this.movie_id = movie_id;
	}

	public int getCollection_id() {
		return collection_id;
	}

	public void setCollection_id(int collection_id) {
		this.collection_id = collection_id;
	}

	public String getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}

	
	
}
