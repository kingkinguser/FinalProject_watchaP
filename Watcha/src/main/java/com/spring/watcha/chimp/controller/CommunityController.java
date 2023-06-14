package com.spring.watcha.chimp.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import com.spring.watcha.chimp.service.InterCommunityService;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.PostCommentVO;
import com.spring.watcha.model.PostVO;

import info.movito.themoviedbapi.TmdbApi;
import info.movito.themoviedbapi.TmdbMovies;
import info.movito.themoviedbapi.TmdbMovies.MovieMethod;
import info.movito.themoviedbapi.model.MovieDb;
import info.movito.themoviedbapi.model.core.MovieResultsPage;
import info.movito.themoviedbapi.tools.ApiUrl;


@RequestMapping("/community")
@Controller
public class CommunityController {
	
	@Autowired
	private InterCommunityService service;


	@GetMapping(value = {"", "/"})
	public String communityMain(Model model, @RequestParam(required = false) Map<String, String> paraMap ) {
		model = service.getPostsByParam(paraMap, model);
		return "community/main.tiles";
	}
	
	@GetMapping("/{postId}")
	public String getPost(Model model, HttpSession session, @PathVariable("postId")String postId, @RequestParam(required = false) Map<String, String> paraMap) {
        boolean isFirstAccess = !service.isPostAccessed(postId);
		
		
		if (isFirstAccess) {
            service.incrementViewCount(postId);
            session.setAttribute("viewedPost_" + postId, true);
        }
		model = service.getPostsByParam(paraMap, model);
		model = service.getPostById(postId, model);
		
		return "community/main.tiles";
	}
	
	
	//게시판 댓글 작성
	@PostMapping("/comment")
	public ResponseEntity<?> createPostComment(PostCommentVO postComment){
		Map<String, Object> map = service.createPostComment(postComment);
		
		
		if (map != null ) {
			return ResponseEntity.ok(map);
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시글 작성 실패");
		}
	}
	
	@DeleteMapping("/comment/{commentId}")
	public ResponseEntity<?> deletePostComment(@PathVariable("commentId")String commentId, HttpServletRequest request){
		int n = service.deletePostComment(commentId, request);
		
		if (n > 0 ) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("page", n);
			return ResponseEntity.ok(map); // 200 OK
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("댓글 삭제 실패"); // 500 에러
		}
	}
	
	@GetMapping("/comment/{commentId}")
	public ResponseEntity<?> getPostCommentIndex(@PathVariable("commentId")String commentId, @RequestParam("postId") String postId){
		
		int comId = Integer.parseInt(commentId);
		PostCommentVO postComment = new PostCommentVO();
		postComment.setCommentId(comId);
		postComment.setPostId(postId);
		
		Map<String, Object> map = service.getPostCommentIndex(postComment);
		
		if (map != null ) {
			return ResponseEntity.ok(map);
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("댓글 조회 실패");
		}
	}
	
	
	
	
	
	// 글작성페이지
	@GetMapping("/write")
	public String viewWritePostPageWithParam() {
		
		return "community/write.tiles";
	}
	
	
	// 글작성실행
	@PostMapping("/write")
	public ResponseEntity<?> writePost(@RequestBody PostVO post) {
		int n = service.insertPost(post);
		
		if(n > 0) {
			Map<String, Object> response = new HashMap<>();
		    response.put("postId", n);
		    return ResponseEntity.ok(response);			
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시글 작성 실패");
		}
	}
	
	

	
	
	@ResponseBody
	@GetMapping(value="/comments/{postId}/{page}", produces = "application/text; charset=utf8")
	public String getPostCommentListByPage(@PathVariable Map<String, String> paraMap) {
		String commnetList = service.getPostCommentList(paraMap);
		
		
		
		return commnetList;
	}
	
	
	@GetMapping(value="/comments/{postId}")
	public ResponseEntity<?> getPostCommentData(@PathVariable Map<String, String> paraMap) {
		
		Map<String, Object> commentData = service.getPostCommentData(paraMap);
		if(commentData != null) {
			return ResponseEntity.ok(commentData);	
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("좋아요 조회 실패");
		}
	}
	
	@GetMapping("/likes/{postId}")
	public ResponseEntity<?> hasLikedPost(@PathVariable("postId") String postId, HttpServletRequest request) {
		Map<String, Object> map = service.hasLikedPost(postId, request);
		if(map != null) {
			return ResponseEntity.ok(map);	
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("좋아요 조회 실패");
		}

	}
	@PostMapping("/likes/{postId}")
	public ResponseEntity<?> insertLikes(@PathVariable("postId") String postId, HttpServletRequest request) {
		Map<String, Object> map = service.insertLikes(postId, request);
		if(map != null) {
			return ResponseEntity.ok(map);	
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("좋아요 작성 실패");
		}

	}
	
	
	@DeleteMapping("/likes/{postId}")
	public ResponseEntity<?> deleteLikes(@PathVariable("postId") String postId, HttpServletRequest request) {
		Map<String, Object> map = service.deleteLikes(postId, request);
		if(map != null) {
			return ResponseEntity.ok(map);	
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("좋아요 삭제 실패");
		}

	}
	
	
	
	
	
//	@GetMapping("/testPage/{movieId}")
//	public String movieDetail(@PathVariable("movieId")String movieId, HttpServletRequest request) {
//		
//		MovieVO movie = service.getMovieDetail(movieId);
//		
//		Gson gson = new GsonBuilder().setPrettyPrinting().create();
//		String result = gson.toJson(movie);
//		System.out.println(result);
//
//		return "community/main.tiles";
//	}
	
	
	@PostMapping(value="/write/upload-image")
	public ResponseEntity<?> uploadImage(@RequestParam("image") MultipartFile image) {
		
		if (!image.getContentType().startsWith("image/")) {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("적합한 파일 형식이 아닙니다.");
		    }
		
		// ctxPath 구하기
	    ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	    HttpServletRequest request = attributes.getRequest();
	    String ctxPath = request.getContextPath();
		
		try {
			// 고유식별자 생성
			String filename = UUID.randomUUID().toString() + "-" + image.getOriginalFilename();
			// 저장 디렉토리 설정
			Path imagePath = Paths.get(System.getProperty("catalina.base"), "wtpwebapps", "Watcha", "resources" ,"postimages", filename);

			// imagepath에 전달받은 image 파일 저장
			Files.write(imagePath, image.getBytes());
			
			// view단에 나타내기 위한 image URL 생성
			String imageURL = ctxPath + "/resources/postimages/"+filename;
			
			// URL  JSON에 담아서 RETURN
			// JsonObject jsonObject = new JsonObject();
			// jsonObject.addProperty("url",imageURL );
			
			Map<String, Object> response = new HashMap<>();
		    response.put("url", imageURL);
		    return ResponseEntity.ok(response);

		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이미지 업로드 실패");
		}
	}
	
	
	
	@ResponseBody
	@GetMapping(value="/write/movielist", produces = "application/text; charset=utf8")
	public String searchMovieList(@RequestParam("search") String search) {
		List<MovieVO> movies = service.getMoviesByKeyword(search);
		Gson gson = new Gson();
		String moviesJson = gson.toJson(movies);
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("movies", moviesJson);
		return gson.toJson(jsonObject);
	}
	
	@ResponseBody
	@GetMapping(value="/write/movie", produces = "application/text; charset=utf8")
	public String searchMovieByMovieId(@RequestParam("search") String search) {
		MovieVO movie = service.getMovieByMovieId(search);
		Gson gson = new Gson();
		String movieJson = gson.toJson(movie);
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("movie", movieJson);
		return gson.toJson(jsonObject);
	}
	


		     
	
	
	
	
//	@GetMapping("/insertMovie.action")
//	public String insertMovie() {
//
//		String apiKey = System.getenv("TMDB_API_KEY");
//		
//		TmdbMovies movies = new TmdbApi(apiKey).getMovies();
//		int pageNo = 1;
//		boolean hasMorePages = true;
//		while (hasMorePages) {
//			ApiUrl apiUrl = new ApiUrl("discover", "movie");
//			apiUrl.addParam("include_adult", false);
//			apiUrl.addParam("include_video", false);
//			apiUrl.addParam("language", "ko-KR");
//			apiUrl.addParam("sort_by", "popularity.desc");
//			apiUrl.addParam("primary_release_year", "2001");
//							
//			apiUrl.addParam("region", "kr");
//			apiUrl.addParam("page", pageNo);
//			apiUrl.addParam("vote_count.gte", "4");
//
//			MovieResultsPage movieListResult = movies.mapJsonResult(apiUrl, MovieResultsPage.class);
//			List<MovieDb> movieList = movieListResult.getResults();
//			
//			List<MovieDb> movieSet = new ArrayList<MovieDb>();   
//			for (MovieDb movie : movieList) {
//				int id = movie.getId();
//				MovieDb movieDetail = movies.getMovie(id, "ko-KR", MovieMethod.credits);
//				movieSet.add(movieDetail);
//			}
//			System.out.println(movieSet.size());
//			
//			service.insertMovie(movieSet);
//			
//			
//			System.out.println(movieListResult.getTotalPages() + "페이지 중에서" + pageNo + "페이지 까지함");
//			pageNo++;
////			pageNo = 5000;
//			hasMorePages = movieListResult.getTotalPages() >= pageNo;
//		}
//		return "community/main";
//	}

}