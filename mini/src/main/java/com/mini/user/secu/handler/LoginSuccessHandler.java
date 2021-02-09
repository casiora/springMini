package com.mini.user.secu.handler;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.mini.user.service.UserService;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Resource(name="userService")
	private UserService userService;
	
	private String loginIdName;
	private String defaultUrl;
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse res, Authentication auth)
			throws IOException, ServletException {
		
		String username = req.getParameter(loginIdName);
		
		resultRedirectStrategy(req, res, auth);
		clearAuthenticationAttributes(req);
		userService.resetFailureCount(username);
		
	}

	private void clearAuthenticationAttributes(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if(session != null) return;
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		
	}

	
	protected void resultRedirectStrategy(HttpServletRequest req, HttpServletResponse res, Authentication auth) throws IOException, ServletException {
		
		SavedRequest savedRequest = requestCache.getRequest(req, res);
		
		if(savedRequest != null) {
			String targetUrl = savedRequest.getRedirectUrl();
			redirectStratgy.sendRedirect(req, res, targetUrl);
		} else {
			redirectStratgy.sendRedirect(req, res, defaultUrl);
		}
	}

	
	public String getLoginIdName() {
		return loginIdName;
	}

	public void setLoginIdName(String loginIdName) {
		this.loginIdName = loginIdName;
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}
	
}
