package com.spring.watcha.model;

public class Movie_roleVO {

	private String movie_id;    // 영화 id
	private String actor_id;    // 배우 id
	private String role;        // 배역
	private String casting_order;  // 캐스팅 순서(주연일수록 낮은 번호)
	private ActorVO actor;
	
	
	public Movie_roleVO(){};
	
	public Movie_roleVO(String movie_id, String actor_id, String role, String casting_order, ActorVO actor) {
		 
		this.movie_id = movie_id;
		this.actor_id = actor_id;
		this.role = role;
		this.casting_order = casting_order;
		this.actor = actor;
	}

	public String getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}

	public String getActor_id() {
		return actor_id;
	}

	public void setActor_id(String actor_id) {
		this.actor_id = actor_id;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getCasting_order() {
		return casting_order;
	}

	public void setCasting_order(String casting_order) {
		this.casting_order = casting_order;
	}

	public ActorVO getActor() {
		return actor;
	}

	public void setActor(ActorVO actor) {
		this.actor = actor;
	}
	
	
	
	
	
}
