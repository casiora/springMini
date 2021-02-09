package com.mini.user.service;

import javax.annotation.Resource;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.mini.user.mapper.UserMapper;
import com.mini.user.vo.UserVO;

@Service("userService")
public class UserService implements UserDetailsService {
	
	@Resource(name="userMapper")
	private UserMapper userMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		UserVO user = userMapper.selectUserById(username);
		if(user==null) {
            throw new UsernameNotFoundException(username);
        }
		
		return user;
	}
	
	public void countFailure(String username) {
		userMapper.updateFailureCount(username);
	}
	
	public int checkFailureCount(String username) {
		return userMapper.checkFailureCount(username);
	}
	
	public void disabledUsername(String username) {
		userMapper.updateDisabled(username);
	}

}
