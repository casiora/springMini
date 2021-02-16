package com.mini.user.secu;

import java.util.Collection;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.mini.user.service.UserService;
import com.mini.user.vo.UserVO;

public class SecuAuthenticationProvider implements AuthenticationProvider {
	
	Logger log = Logger.getLogger(getClass());

	@Resource(name="userService")
	private UserService userService;
	
	// 패스워드 암호화 객체
	@Autowired
	BCryptPasswordEncoder pwEncoding;

	@SuppressWarnings("unchecked")
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = (String) authentication.getPrincipal();
		String password = (String) authentication.getCredentials();
		
		log.debug("AuthenticationProvider :::::: 1");
		
		UserVO user = (UserVO) userService.loadUserByUsername(username);		
		Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) user.getAuthorities();
		
		//PW안맞을 경우
		if (user == null || !username.equals(user.getUsername())
			||!pwEncoding.matches(password, user.getPassword())) {
			log.debug("matchPassword :::::::: false!");
			throw new BadCredentialsException(username);
		}
		
		//만료된 계정일 경우
		if(!user.isEnabled()) {
			log.debug("isEnabled :::::::: false!");
			throw new DisabledException(username);
		}
		
		return new UsernamePasswordAuthenticationToken(username, password, authorities);
	}

	/*private boolean matchPassword(String loginPwd, String password) {
		// TODO Auto-generated method stub
		return loginPwd.equals(password);
	}*/

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
