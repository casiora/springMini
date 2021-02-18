package com.mini.user.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mini.common.vo.PageVO;
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
	public String signPage() throws Exception {
		
		logger.info("signPage");

		return "user/sign";
	}
	
	//회원가입
	@RequestMapping(value="sign")
	public String sign(UserVO userVO) throws Exception {
		
		logger.info("sign");
		
		userService.signID(userVO);

		return "redirect:/secu/loginPage";
	}
	
	//로그인페이지 호출
	@RequestMapping("secu/loginPage")
	public String page() throws Exception {
		return "/user/secu/loginPage";
	}
	
	//권한거부 페이지 호출
	@RequestMapping("secu/access_denied_page")
	public String accessDeinedPage() throws Exception {
		return "/user/secu/access_denied_page";
	}
	
	//로그인
	@RequestMapping(value = "/login")
	public String login(HttpServletRequest req, HttpServletResponse res) throws IOException{
		return "redirect:/";
	}
	
	//리스트
	@RequestMapping(value="list")
	public String list(UserVO UserVO,
	 @RequestParam(defaultValue = "1", value = "p", required = false) int currentPage, 
	 @RequestParam(defaultValue = "10", value = "s", required = false) int pageSize, 
	 @RequestParam(defaultValue = "5", value = "b", required = false) int blockSize,
	 Model model) throws Exception {
		
	PageVO<UserVO> paging = userService.list(UserVO, currentPage, pageSize, blockSize);
	model.addAttribute("paging", paging);
	
	return "user/list";
		
	}

}
