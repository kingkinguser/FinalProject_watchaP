package com.spring.watcha.shinjh.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.watcha.service.InterWatchaService;

@Controller
public class WatchaController {
			
		@Autowired 
		private InterWatchaService service; 
			
		@RequestMapping(value="/views/login_test.action")
		public String login_test() {
			
			return "login_test";
		}	
}
