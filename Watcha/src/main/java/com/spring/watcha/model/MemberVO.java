package com.spring.watcha.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {

	private String user_id;					// 회원아이디
	private String password;				// 비밀번호 (Sha-256 암호화 대상)
	private String name;        			// 회원명
	private String nickname; 				// 닉네임
	private String mobile;              	// 연락처 (AES-256 암호화/복호화 대상)
	private String email;              		// 이메일 (AES-256 암호화/복호화 대상)
	private int gender;                     // 성별	남자:1 / 여자:2
	private String birthday;                // 생년월일
	private String date_joined;             // 가입일자
	private String profile_message;			// 프로필 문구
	private String profile_image;      		// 프로필 이미지
	private String last_password_change;	// 마지막으로 암호를 변경한 날짜
	// idle 추가할것

	private int pwdchangegap;          // select 용. 지금으로 부터 마지막으로 암호를 변경한지가 몇개월인지 알려주는 개월수(3개월 동안 암호를 변경 안 했을시 암호를 변경하라는 메시지를 보여주기 위함)  
	private int lastlogingap;          // select 용. 지금으로 부터 마지막으로 로그인한지가 몇개월인지 알려주는 개월수(12개월 동안 로그인을 안 했을 경우 해당 로그인 계정을 비활성화 시키려고 함)
	
	////////////////////////////////////////////////////////////////////////
	
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
	
	////////////////////////////////////////////////////////////////////////

	private MultipartFile attach; // form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다.

	
	private int total_count;   // 유저의 평가 개수를 저장하기 위해 설정함 
	private int count_user_id_like;    // 유저에 대한 컬렉션 좋아요 수
	private int count_user_id_collection;  // 유저에 대한 컬렉션 댓글 수 
	
	private List<MovieVO> poster;
	////////////////////////////////////////////////////////////////////////
	
	
	public MemberVO() {}
	
	// loginuser값 받아오기
	public MemberVO(String user_id, String name, String mobile, String email, String date_joined
					, String profile_message, String profile_image, int pwdchangegap) {
		
		this.user_id = user_id;
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.date_joined = date_joined;
		this.profile_message = profile_message;
		this.profile_image = profile_image;
		this.pwdchangegap = pwdchangegap;
		
	}
	
	
	// 내정보수정
	public MemberVO(String user_id, String password, String name, String mobile, String email
			, String profile_message, String profile_image) {

		this.user_id = user_id;
		this.password = password;
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.profile_message = profile_message;
		this.profile_image = profile_image;
	}
	
	// 유저 나타내기 위해, 그리고 컬렉션 나타내기 위해 
	public MemberVO(String user_id, String name, String profile_image, int total_count, 
			        int count_user_id_like, int count_user_id_collection, List<MovieVO> poster ) {

		this.user_id = user_id;
		this.name = name;
		this.profile_image = profile_image;
		this.total_count = total_count;
		this.count_user_id_like = count_user_id_like;
		this.count_user_id_collection = count_user_id_collection;
		this.poster = poster;
	}


	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getDate_joined() {
		return date_joined;
	}

	public void setDate_joined(String date_joined) {
		this.date_joined = date_joined;
	}

	public String getProfile_message() {
		return profile_message;
	}

	public void setProfile_message(String profile_message) {
		this.profile_message = profile_message;
	}

	public String getProfile_image() {
		return profile_image;
	}

	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}

	public String getLast_password_change() {
		return last_password_change;
	}

	public void setLast_password_change(String last_password_change) {
		this.last_password_change = last_password_change;
	}

	// ==== select 용. 지금으로 부터 마지막으로 암호를 변경하지가 몇개월인지 알려주는 개월수 ==== //
	public int getPwdchangegap() {
		return pwdchangegap;
	}

	public void setPwdchangegap(int pwdchangegap) {
		this.pwdchangegap = pwdchangegap;
	}

	// ==== select 용. 지금으로 부터 마지막으로 로그인한지가 몇개월인지 알려주는 개월수 ==== //
	public int getLastlogingap() {
		return lastlogingap;
	}

	public void setLastlogingap(int lastlogingap) {
		this.lastlogingap = lastlogingap;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	public int getTotal_count() {
		return total_count;
	}

	public void setTotal_count(int total_count) {
		this.total_count = total_count;
	}
	
	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public int getCount_user_id_like() {
		return count_user_id_like;
	}

	public void setCount_user_id_like(int count_user_id_like) {
		this.count_user_id_like = count_user_id_like;
	}

	public int getCount_user_id_collection() {
		return count_user_id_collection;
	}

	public void setCount_user_id_collection(int count_user_id_collection) {
		this.count_user_id_collection = count_user_id_collection;
	}

	public List<MovieVO> getPoster() {
		return poster;
	}

	public void setMovie(List<MovieVO> poster) {
		this.poster = poster;
	}

}
