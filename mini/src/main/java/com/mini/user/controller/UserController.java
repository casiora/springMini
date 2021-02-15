package com.mini.user.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mini.user.service.UserService;
import com.mini.user.vo.UserVO;

@Controller
@RequestMapping("user")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Resource(name="userService")
	private UserService userService;
	
	//회원가입 페이지
	@RequestMapping(value="signPage")
	public String signPage(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		logger.info("signPage");

		return "user/sign";
	}
	
	@RequestMapping(value="sign")
	public String sign(UserVO userVO) throws Exception {
		
		logger.info("sign");
		
		userService.signID(userVO);

		return "redirect:/";
	}

}
