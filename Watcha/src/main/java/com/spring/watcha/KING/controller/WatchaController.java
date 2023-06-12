package com.spring.watcha.KING.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
	          
				HttpSession session = request.getSession();
	            MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				String movie_id = request.getParameter("movie_id");

				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("movie_id", movie_id);
				
				MovieVO movieDetail = service.getMovieDetail(paraMap); 
				model.addAttribute("movieDetail",movieDetail);
				
			    if(loginuser != null){
			         String user_id = loginuser.getUser_id(); 
			         paraMap.put("user_id", user_id);
			         int moviecollectionSelect = service.getMoviecollectionSelect(paraMap); 
			         model.addAttribute("moviecollectionSelect",moviecollectionSelect);
			    } 
				
				/*
				// 1대N 배열 한눈에 보기 
				Gson gson = new GsonBuilder().setPrettyPrinting().create();
				String movieStr = gson.toJson(movieDetail);
				System.out.println(movieStr);
				*/
				
				return "project_detail.tiles";			
				
			}	
		   // ==== ***** project_detail tiles 끝 ***** ==== // 
			
			// ==== ***** user_collection tiles 시작 ***** ==== // 
			@RequestMapping(value="/view/user_collection.action")
			public String user_collection(HttpServletRequest request, Model model) {
				
	            HttpSession session = request.getSession();
	            MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	            
				String movie_id = request.getParameter("movie_id");
				String user_id_collection = request.getParameter("user_id"); // 메인에서 넘어오는 user_id
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("movie_id", movie_id);
				
				if(user_id_collection != null) {
					// 메인에서 유저의 컬렉션 클릭
					paraMap.put("user_id", user_id_collection);
					List<Map<String, String>> collection_viewA = service.getCollection_view(paraMap); 
					model.addAttribute("collection_viewA", collection_viewA);
				}
				else if(user_id_collection == null && loginuser != null) {
					// 로그인한 유저가 내 컬렉션을 클릭한 경우
					paraMap.put("user_id", loginuser.getUser_id());
					List<Map<String, String>> collection_viewB = service.getCollection_view(paraMap); 
					model.addAttribute("collection_viewB", collection_viewB);
					
			        int likeMaintain = service.getLikeMaintain(paraMap); 
			        model.addAttribute("likeMaintain",likeMaintain);
				}
				
				Map<String, String> totalCount = service.totalCount(paraMap); 
				
				model.addAttribute("totalCount", totalCount);
				 
				return "user_collection.tiles";
				// /WEB-INF/views/tiles1/tiles1/tiles_test
			}	
		   // ==== ***** user_collection tiles 끝 ***** ==== // 
		
			
		   // ============================================== 기능 시작 ======================================================= //	
			
			// == 더보기(Ajax 로 처리) == //
			@ResponseBody
			@RequestMapping(value="/cardSeeMore.action")
			public String cardSeeMore(HttpServletRequest request) {
				
				String user_id_collection = request.getParameter("user_id_collection");
	            String start = request.getParameter("start");
				String len = request.getParameter("len");
				String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1);
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("user_id", user_id_collection);
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
				
				/*	
				Gson gson = new GsonBuilder().setPrettyPrinting().create();
				System.out.println(gson.toJson(uccvo)); 
				*/ 	
				 
				    int n = service.addUserComment(uccvo); 
					// 댓글쓰기(insert)
					
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("n", n);
						
				return jsonObj.toString(); 
			}			
			
			
			// === 원게시물에 딸린 댓글들을 페이징 처리해서 조회해오기(Ajax 로 처리) === // 
			@ResponseBody
			@RequestMapping(value="/user_collection_commentList.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
			public String user_collection_commentList(HttpServletRequest request) {
				
				String user_id_collection = request.getParameter("user_id_collection");
				String currentShowPageNo = request.getParameter("currentShowPageNo");
				
				if(currentShowPageNo == null) {
					currentShowPageNo = "1";
				}  
				
				int sizePerPage = 3; // 한 페이지당 3개의 댓글을 보여줄 것임.
				
				int startRno = (( Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
				int endRno = startRno + sizePerPage - 1;
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("user_id_collection", user_id_collection);
				paraMap.put("startRno", String.valueOf(startRno));
				paraMap.put("endRno", String.valueOf(endRno));
				
				List<Map<String, String>> uccList = service.getuccListPaging(paraMap);
				
				JSONArray jsonArr = new JSONArray(); // []
				
				if(uccList != null) {
					for(Map<String, String> uccvo : uccList) {
						
						JSONObject jsonObj = new JSONObject();
						jsonObj.put("user_collection_seq", uccvo.get("user_collection_seq"));
						jsonObj.put("user_id_comment", uccvo.get("user_id_comment"));
						jsonObj.put("user_id_collection", uccvo.get("user_id_collection"));
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
			public String likeCollection(HttpServletRequest request, HttpServletResponse response) {
				
				String likeCollection = "";
				String user_id_collection = request.getParameter("user_id_collection");
				String user_id_like = request.getParameter("user_id_like");
				
				Map<String, Object> paraMap = new HashMap<>();
				paraMap.put("user_id_collection", user_id_collection);
				paraMap.put("user_id_like", user_id_like); 
				
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
			
			// === 컬렉션 값 === //
			@ResponseBody
			@RequestMapping(value="/view/insert_collection.action", method= {RequestMethod.POST})   
			public String insert_collection(HttpServletRequest request) {
				
				String collectionAdd = "";
				String user_id = request.getParameter("user_id");
				String movie_id = request.getParameter("movie_id");
				
				Map<String, Object> paraMap = new HashMap<>();
				paraMap.put("user_id", user_id);
				paraMap.put("movie_id", movie_id); 
				
				int n = service.getCollectionSelect(paraMap);
				 
				paraMap.put("n", n);
				
				if(n == 1) {
					collectionAdd = service.getCollectionAddDelete(paraMap);
				}
				else {
					collectionAdd = service.getCollectionAddInsert(paraMap);
				}
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("collectionAdd", collectionAdd);
				
				return jsonObj.toString();
				
			}
			
			// === 좋아요 총수 === //
			@ResponseBody
			@RequestMapping(value="/likeTotal.action", method= {RequestMethod.POST})   
			public String likeTotal(HttpServletRequest request, HttpServletResponse response) {
				
				String user_id_collection = request.getParameter("user_id_collection");
				String user_id_like = request.getParameter("user_id_like");
				
				Map<String, Object> paraMap = new HashMap<>();
				paraMap.put("user_id_collection", user_id_collection);
				paraMap.put("user_id_like", user_id_like); 
				
				int likeTotal = service.getLikeTotal(paraMap);
			 		 
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("likeTotal", likeTotal);
				
				return jsonObj.toString();
				
			}			
			
			
		   // =============================================== 기능 끝 ======================================================== //	
}
