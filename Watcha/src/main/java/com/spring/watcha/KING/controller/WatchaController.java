package com.spring.watcha.KING.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.watcha.KING.service.InterWatchaService;
import com.spring.watcha.model.MemberVO;
import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.user_collection_commentVO;

@Controller
public class WatchaController {
			
			@Autowired 
			private InterWatchaService service;  
			
			@Resource
			private SqlSessionTemplate sqlsession ;
			
			// ==== ***** project_detail tiles 시작 ***** ==== // 
			@RequestMapping(value="/view/project_detail.action") 
			public String project_detail(HttpServletRequest request, Model model) {
				
				String movie_id = request.getParameter("movie_id");
				MovieVO movieDetail = service.getMovieDetail(movie_id); 

				model.addAttribute("movieDetail",movieDetail);
				
				/*
				// 1대N 배열 한눈에 보기
				Gson gson = new GsonBuilder().setPrettyPrinting().create();
				String movieStr = gson.toJson(movieDetail);
				System.out.println(movieStr);
				*/
				
				return "project_detail.tiles";			
				
			}	
		   // ==== ***** project_detail tiles 끝 ***** ==== // 
			
			// ==== ***** project_detail tiles 시작 ***** ==== // 
			@RequestMapping(value="/view/user_collection.action")
			public String user_collection(HttpServletRequest request, Model model) {
				
	            HttpSession session = request.getSession();
	            MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	            String user_id = loginuser.getUser_id();
				String movie_id = request.getParameter("movie_id");
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("movie_id", movie_id);
				paraMap.put("user_id", user_id);
				
				List<Map<String, String>> collection_view = service.getCollection_view(paraMap); 
				Map<String, String> totalCount = service.totalCount(paraMap); 
				
				model.addAttribute("collection_view", collection_view);
				model.addAttribute("totalCount", totalCount);
				 
				return "user_collection.tiles";
				// /WEB-INF/views/tiles1/tiles1/tiles_test
			}	
		   // ==== ***** project_detail tiles 끝 ***** ==== // 
		
			
		   // ============================================== 기능 시작 ======================================================= //	
			
			// == 더보기(Ajax 로 처리) == //
			@ResponseBody
			@RequestMapping(value="/cardSeeMore.action")
			public String cardSeeMore(HttpServletRequest request) {

	            HttpSession session = request.getSession();
	            MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	            String user_id = loginuser.getUser_id();
				String start = request.getParameter("start");
				String len = request.getParameter("len");
				
				String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1);
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("user_id", user_id);
				paraMap.put("start", start);
				paraMap.put("end", end);
				
				List<Map<String, String>> cardSeeMoreList = service.cardSeeMore(paraMap); 
				
		    	JsonArray jsonArr = new JsonArray();
		    	
		    	if(cardSeeMoreList != null && cardSeeMoreList.size() > 0) {
		    		for(Map<String, String> map :cardSeeMoreList) {
		    			
		    			JsonObject jsonObj = new JsonObject();
		    			jsonObj.addProperty("poster_path", map.get("poster_path"));
		    			jsonObj.addProperty("movie_title", map.get("movie_title"));
		    			jsonObj.addProperty("movie_id", map.get("movie_id"));
		    			
		    			jsonArr.add(jsonObj);
		    			
		    		}//end of for -----------------------------------------------------
		    	}
		    	
		    	return new Gson().toJson(jsonArr);
			}				

			// === 댓글쓰기(Ajax 로 처리) === //
			@ResponseBody
			@RequestMapping(value="/addUserComment.action", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8") 
			public String addUserComment(user_collection_commentVO uccvo) {
				// 댓글쓰기에 첨부파일이 없는 경우 
				
				int n = 0;
				
				try {
					n = service.addUserComment(uccvo);
					// 댓글쓰기(insert)
					
				} catch (Throwable e) {
				    e.printStackTrace(); 
				}
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("n", n);
						
				return jsonObj.toString(); // "{"n":1, "name":"서영학"}" 또는  "{"n":0, "name":"서영학"}"
			}			
			
			
			// === 원게시물에 딸린 댓글들을 페이징 처리해서 조회해오기(Ajax 로 처리) === // 
			@ResponseBody
			@RequestMapping(value="/user_collection_commentList.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
			public String user_collection_commentList(HttpServletRequest request) {
				
				String collection_id = request.getParameter("collection_id");
				String currentShowPageNo = request.getParameter("currentShowPageNo");
				
				if(currentShowPageNo == null) {
					currentShowPageNo = "1";
				}  
				
				int sizePerPage = 3; // 한 페이지당 3개의 댓글을 보여줄 것임.
				
				int startRno = (( Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
				int endRno = startRno + sizePerPage - 1;
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("collection_id", collection_id);
				paraMap.put("startRno", String.valueOf(startRno));
				paraMap.put("endRno", String.valueOf(endRno));
				
				List<Map<String, String>> uccList = service.getuccListPaging(paraMap);
				
				JSONArray jsonArr = new JSONArray(); // []
				
				if(uccList != null) {
					for(Map<String, String> uccvo : uccList) {
						
						JSONObject jsonObj = new JSONObject();
						jsonObj.put("user_collection_seq", uccvo.get("user_collection_seq"));
						jsonObj.put("user_id", uccvo.get("user_id"));
						jsonObj.put("collection_id", uccvo.get("collection_id"));
						jsonObj.put("user_collection_content", uccvo.get("user_collection_content"));
						jsonObj.put("user_collection_time", uccvo.get("user_collection_time"));
						jsonObj.put("name", uccvo.get("name"));
						jsonObj.put("nickname", uccvo.get("nickname"));
						jsonObj.put("profile_image", uccvo.get("profile_image"));
						
						jsonArr.put(jsonObj);
					}// end of for-----------------
				}
				
				return jsonArr.toString();
			}
			
			// === 원게시물에 딸린 댓글 totalPage 알아오기(Ajax 로 처리) === //
			@ResponseBody
			@RequestMapping(value="/getUserCommentTotalPage.action", method= {RequestMethod.GET})   
			public String getUserCommentTotalPage(HttpServletRequest request) {
				
				String collection_id = request.getParameter("collection_id");
				String sizePerPage = request.getParameter("sizePerPage");
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("collection_id", collection_id);
				paraMap.put("sizePerPage", sizePerPage);
				
				// 원글 글번호에 해당하는 댓글의 totalPage 알아오기
				String totalPage = service.getUserCommentTotalPage(paraMap);
				
				return totalPage;
			}

			// === 좋아요 === //
			@ResponseBody
			@RequestMapping(value="/likeCollection.action", method= {RequestMethod.POST})   
			public String likeCollection(HttpServletRequest request) {
				
				String likeCollection = "";
				String collection_id = request.getParameter("collection_id");
				String user_id = request.getParameter("user_id");
				
				Map<String, Object> paraMap = new HashMap<>();
				paraMap.put("collection_id", collection_id);
				paraMap.put("user_id", user_id);
				
				int n = service.getLikeSelect(paraMap);
				
				paraMap.put("n", n);
				
				if(n == 1) {
					 likeCollection = service.getLikeDeleteCollection(paraMap);
				}
				else {
				     likeCollection = service.getLikeInsertCollection(paraMap);
				}
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("likeCollection", likeCollection);
				
				return jsonObj.toString();
			}
			
			
		   // =============================================== 기능 끝 ======================================================== //	
}
