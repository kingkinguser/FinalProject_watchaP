package com.spring.watcha.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.watcha.service.InterWatchaService;


@Controller
public class WatchaController {
			
			@Autowired 
			private InterWatchaService service; 
			

}
