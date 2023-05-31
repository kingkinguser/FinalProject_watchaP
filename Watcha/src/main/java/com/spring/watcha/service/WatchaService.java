package com.spring.watcha.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.watcha.common.AES256;
import com.spring.watcha.model.InterWatchaDAO;


@Service
public class WatchaService implements InterWatchaService {
	
   @Autowired
   private InterWatchaDAO dao;

   @Autowired
   private AES256 aes;
		
}
