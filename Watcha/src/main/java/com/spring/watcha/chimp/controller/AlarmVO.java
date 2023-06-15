package com.spring.watcha.chimp.controller;

public class AlarmVO {
	
	private String userId;
	private String message;
	private String type;
	private String url;
	
	public AlarmVO() {
		
	}
	
	public AlarmVO(String userId, String message, String type, String url) {
		super();
		this.userId = userId;
		this.message = message;
		this.type = type;
		this.url = url;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
	

}
