package com.spring.watcha.model;

public class ActorVO {


	private String actor_id;      // 배우 ID
	private String actor_name;    // 배우명 
	private int gender;           // 성별
	private String date_of_birth; // 생년월일
	private String place_of_birth;// 출생지
	private String profile_image_path;  // 프로필 이미지 주소 
	
	public ActorVO(){};
	
	public ActorVO(String actor_id, String actor_name, int gender, String date_of_birth,
			       String place_of_birth, String profile_image_path) {
		 
		this.actor_id = actor_id;
		this.actor_name = actor_name;
		this.gender = gender;
		this.date_of_birth = date_of_birth;
		this.place_of_birth = place_of_birth;
		this.profile_image_path = profile_image_path;
	}

	public String getActor_id() {
		return actor_id;
	}

	public void setActor_id(String actor_id) {
		this.actor_id = actor_id;
	}

	public String getActor_name() {
		return actor_name;
	}

	public void setActor_name(String actor_name) {
		this.actor_name = actor_name;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public String getDate_of_birth() {
		return date_of_birth;
	}

	public void setDate_of_birth(String date_of_birth) {
		this.date_of_birth = date_of_birth;
	}

	public String getPlace_of_birth() {
		return place_of_birth;
	}

	public void setPlace_of_birth(String place_of_birth) {
		this.place_of_birth = place_of_birth;
	}

	public String getProfile_image_path() {
		return profile_image_path;
	}

	public void setProfile_image_path(String profile_image_path) {
		this.profile_image_path = profile_image_path;
	}
	
	
	
}
