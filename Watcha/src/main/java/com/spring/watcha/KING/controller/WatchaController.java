package com.spring.watcha.KING.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.watcha.KING.service.InterWatchaService;

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
			//	MovieVO projectInfo = service.projectInfo(movie_id); 

			//	model.addAttribute("projectInfo",projectInfo);
				  
				return "project_detail.tiles";
				
			}	
		   // ==== ***** project_detail tiles 끝 ***** ==== // 
	
			
			
			// ==== ***** project_detail tiles 시작 ***** ==== // 
			@RequestMapping(value="/view/user_collection.action")
			public String user_collection() {
				
				return "user_collection.tiles";
				// /WEB-INF/views/tiles1/tiles1/tiles_test
			}	
		   // ==== ***** project_detail tiles 끝 ***** ==== // 
		
}
