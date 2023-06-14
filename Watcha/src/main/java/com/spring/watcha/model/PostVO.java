package com.spring.watcha.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class PostVO {
	
	private String postId;
	private String userId;
	private String title;
	private String content;
	private int views;
	private int likes;
	private String postDate;
	private String postCategoryId;
	private String postCategoryName;
	private int commentCount;
	private MemberVO member;
	private List<MovieVO> movies;
	private List<String> movieIds;
	
	
	
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public String getPostCategoryName() {
		return postCategoryName;
	}
	public void setPostCategoryName(String postCategoryName) {
		this.postCategoryName = postCategoryName;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	
	
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public List<String> getMovieIds() {
		return movieIds;
	}
	public void setMovieIds(List<String> movieIds) {
		this.movieIds = movieIds;
	}
	public String getPostCategoryId() {
		return postCategoryId;
	}
	public void setPostCategoryId(String postCategoryId) {
		this.postCategoryId = postCategoryId;
	}
	
	
	
	public MemberVO getMember() {
		return member;
	}
	public void setMember(MemberVO member) {
		this.member = member;
	}
	
	
	public List<MovieVO> getMovies() {
		return movies;
	}
	public void setMovies(List<MovieVO> movies) {
		this.movies = movies;
	}
	
	public boolean isHasImage() {
        Document doc = Jsoup.parse(content);
        Elements imgTags = doc.select("img");

        return !imgTags.isEmpty();
    }
	
	
	public String getFormattedPostDate() {
        if (postDate == null) {
            return "";
        }
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime postDateTime = LocalDateTime.parse(postDate, formatter);
        
        LocalDateTime now = LocalDateTime.now();
        long minutes = ChronoUnit.MINUTES.between(postDateTime, now);
        long hours = ChronoUnit.HOURS.between(postDateTime, now);
        long days = ChronoUnit.DAYS.between(postDateTime, now);
        
        if (minutes < 60) {
            return minutes + "분 전";
        } else if (hours < 24) {
            return hours + "시간 전";
        } else if (days < 7) {
            return days + "일 전";
        } else {
            DateTimeFormatter outputFormatter  = DateTimeFormatter.ofPattern("yy.MM.dd.");
            return postDateTime.format(outputFormatter);
        }
    }
	
	public String getFormattedPostTime() {
		if (postDate == null) {
            return "";
        }
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime postDateTime = LocalDateTime.parse(postDate, formatter);
		
        DateTimeFormatter outputFormatter  = DateTimeFormatter.ofPattern("HH:mm");
        
		return postDateTime.format(outputFormatter); 
	}
	
}
