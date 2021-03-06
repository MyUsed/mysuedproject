package com.spring.vertx.controller;

import java.sql.SQLXML;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sun.javafx.sg.prism.NGShape.Mode;
import com.sun.org.apache.regexp.internal.recompile;


@Controller
public class chatController {
	@Autowired
	private SqlMapClientTemplate SqlMapClientTemplate;
	
	// 채팅방 접속
	@RequestMapping("chat.nhn")
	public ModelAndView main(Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String sessionId = (String)session.getAttribute("memId");
		int count = (int)SqlMapClientTemplate.queryForObject("chat.oncount", sessionId);	// chatonoff컬럼이 0이냐 1이냐
		if(count == 0){	// 채팅에 접속중이 아니면
			SqlMapClientTemplate.update("chat.on", sessionId);	// 채팅방에 접속하면 1
		}
		int totalcount = (int)SqlMapClientTemplate.queryForObject("chat.totalCount", null);	// 채팅방 총접속자 수
		mav.addObject("totalcount", totalcount);
		mav.setViewName("/views/chat.jsp");
		return mav;
	}
	
	// 채팅방 총접속자 수
	@RequestMapping("oncount.nhn")
	public ModelAndView oncount(){
		ModelAndView mv = new ModelAndView();
		int totalcount = (int)SqlMapClientTemplate.queryForObject("chat.totalCount", null);	// 채팅방 총접속자 수
		mv.addObject("totalcount", totalcount);
		mv.setViewName("/views/count.jsp");
		return mv;
	}
	
	@RequestMapping("namelist.nhn")
	public ModelAndView namelist(HttpSession session){
		ModelAndView mv = new ModelAndView();
		String sessionId = (String)session.getAttribute("memId");
		String name = (String)SqlMapClientTemplate.queryForObject("chat.me", sessionId);	// 회원의 이름 가져오기
		int mynum = (int)SqlMapClientTemplate.queryForObject("chat.mynum", sessionId);		// 회원 고유번호 가져오기
		List list = SqlMapClientTemplate.queryForList("chat.onName", null);	// 채팅방에 들어와있는 사람의 name 
		mv.addObject("list", list);
		mv.addObject("name", name);
		mv.addObject("mynum", mynum);
		mv.setViewName("/views/namelist.jsp");
		return mv;
	}
	
	@RequestMapping("chatExit.nhn")
	public String chatExit(HttpSession session){
		String sessionId = (String)session.getAttribute("memId");
		SqlMapClientTemplate.update("chat.off", sessionId);
		return "/views/chatExit.jsp";
	}
}