package com.mini.user.secu;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class loginController {
	
	@RequestMapping("secu/loginPage")
	public String page() throws Exception {
		return "/user/secu/loginPage";
	}
	
	@RequestMapping("secu/access_denied_page")
	public String accessDeinedPage() throws Exception {
		return "/user/secu/access_denied_page";
	}
	
	@RequestMapping(value = "/login")
	public String login(HttpServletRequest req, HttpServletResponse res) throws IOException{
		return "redirect:/";
	}

}
