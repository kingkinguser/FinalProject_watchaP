package com.spring.watcha.model;

import java.util.List;

public class collection_movieVO {
	
	private String user_id;
	private String movie_id;
	private List<MemberVO> member;
	
	public collection_movieVO() {}
	
	public collection_movieVO(String user_id, String movie_id, List<MemberVO> member) {
		super();
		this.user_id = user_id;
		this.movie_id = movie_id;
		this.member = member;
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

	public List<MemberVO> getMember() {
		return member;
	}

	public void setMember(List<MemberVO> member) {
		this.member = member;
	}

	
	
	
}
