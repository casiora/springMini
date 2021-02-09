package com.mini.user.secu.handler;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.mini.user.secu.MessageUtils;
import com.mini.user.service.UserService;

public class LoginFailureHandler implements AuthenticationFailureHandler {
	
	@Resource(name="userService")
	private UserService userService;
	
	private String loginIdName;
	private String loginPwdName;
	private String errorMsgName;
	private String defaultFailureUrl;

	@Override
	public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse res, AuthenticationException exc)
			throws IOException, ServletException {
		
		
		String username = req.getParameter(loginIdName);
		String password = req.getParameter(loginPwdName);
		String errormsg = null;
		
		if(exc instanceof BadCredentialsException) {
			loginFailureCount(username);
            errormsg = MessageUtils.getMessage("error.BadCredentials");
        } else if(exc instanceof InternalAuthenticationServiceException) {
            errormsg = MessageUtils.getMessage("error.BadCredentials");
        } else if(exc instanceof DisabledException) {
            errormsg = MessageUtils.getMessage("error.Disaled");
        } else if(exc instanceof CredentialsExpiredException) {
            errormsg = MessageUtils.getMessage("error.CredentialsExpired");
        }
	
		req.setAttribute(loginIdName, username);
		req.setAttribute(loginPwdName, password);
		req.setAttribute(errorMsgName, errormsg);
		
		req.getRequestDispatcher(defaultFailureUrl).forward(req, res);
		
	}

	private void loginFailureCount(String username) {
		userService.updateFailureCount(username);
		int cnt = userService.checkFailureCount(username);
		if(cnt == 3) {
			userService.updateDisabled(username);
		}
		
	}

	public String getLoginIdName() {
		return loginIdName;
	}

	public void setLoginIdName(String loginIdName) {
		this.loginIdName = loginIdName;
	}


	public String getLoginPwdName() {
		return loginPwdName;
	}

	public void setLoginPwdName(String loginPwdName) {
		this.loginPwdName = loginPwdName;
	}

	public String getErrorMsgName() {
		return errorMsgName;
	}

	public void setErrorMsgName(String errorMsgName) {
		this.errorMsgName = errorMsgName;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}
	
	

}
