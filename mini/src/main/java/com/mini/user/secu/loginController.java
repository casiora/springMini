package com.mini.user.secu;

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

}
