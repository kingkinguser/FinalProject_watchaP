package com.spring.watcha.common;

public class MovieDiaryVO {
	
	// field
    private String diary_id;	  // 무비다이어리 ID
    private String movie_id;	  // 영화 ID
    private String user_id;		  // 회원 아이디
    private String watching_date; // 관람일자
    private String photo_front;	  // 포토티켓(앞)
    private String photo_back;	  // 포토티켓(뒤)
	
    // 기본 생성자
    public MovieDiaryVO() {}
    
    // 파라미터 생성자
    public MovieDiaryVO(String diary_id, String movie_id, String user_id, String watching_date, String photo_front,
						String photo_back) {
		this.diary_id = diary_id;
		this.movie_id = movie_id;
		this.user_id = user_id;
		this.watching_date = watching_date;
		this.photo_front = photo_front;
		this.photo_back = photo_back;
	}

	public String getDiary_id() {
		return diary_id;
	}

	public void setDiary_id(String diary_id) {
		this.diary_id = diary_id;
	}

	public String getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getWatching_date() {
		return watching_date;
	}

	public void setWatching_date(String watching_date) {
		this.watching_date = watching_date;
	}

	public String getPhoto_front() {
		return photo_front;
	}

	public void setPhoto_front(String photo_front) {
		this.photo_front = photo_front;
	}

	public String getPhoto_back() {
		return photo_back;
	}

	public void setPhoto_back(String photo_back) {
		this.photo_back = photo_back;
	}

    
    
}
