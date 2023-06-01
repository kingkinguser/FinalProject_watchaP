package com.spring.watcha.mindh.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.watcha.model.MovieVO;

@Controller
public class WatchaController {

	@Autowired 
	private com.spring.watcha.mindh.service.InterWatchaService service ; 
	
	@RequestMapping(value="/view/main.action")
	public ModelAndView main(ModelAndView mav) {
		
		List<MovieVO> starRankvo = service.starRank();   // 평점 순위 
		List<MovieVO> seeRankvo = service.seeRank();   // 보고싶어요  순위 
		List<MovieVO> commentRankvo = service.commentRank();   // 한줄평 많은  순위 
		List<MovieVO> actorvo = service.actorRank();   // 좋아하는 배우 영화 
		
			
		mav.addObject("starRankvo", starRankvo);
		mav.addObject("seeRankvo", seeRankvo);
		mav.addObject("commentRankvo", commentRankvo);
		mav.addObject("actorvo", actorvo);
		mav.setViewName("/main.tiles");
		
		return mav;
		// /WEB-INF/views/tiles1/tiles1/tiles_test
	}	
	
	
}
