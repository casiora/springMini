package com.mini.user.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mini.board.vo.BoardVO;
import com.mini.common.vo.PageVO;
import com.mini.user.mapper.UserMapper;
import com.mini.user.vo.UserVO;

@Service("userService")
public class UserService implements UserDetailsService {
	
	@Resource(name="userMapper")
	private UserMapper userMapper;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		UserVO user = userMapper.selectUserById(username);
		if(user==null) {
            throw new UsernameNotFoundException(username);
        }
		
		return user;
	}
	
	public void updateFailureCount(String username) {
		userMapper.updateFailureCount(username);
	}
	
	public int checkFailureCount(String username) {
		return userMapper.checkFailureCount(username);
	}
	
	public void updateDisabled(String username) {
		userMapper.updateDisabled(username);
	}

	public void resetFailureCount(String username) {
		userMapper.resetFailureCount(username);
		
	}
	
	public boolean signID(UserVO userVO) {
		
		Integer userCount = userMapper.idChk(userVO.getID());		
		if(userCount > 0) {
			return false;
		} else {
			userVO.setPASSWORD(pwEncoder.encode(userVO.getPassword()));
			userMapper.signID(userVO);
			return true;			
		}							
	}
	
	
	//리스트
	public PageVO<UserVO> list(UserVO UserVO,int currentPage, int pageSize, int blockSize){
		int listcount = 0; 
		System.out.println("keyword ====> " + UserVO.getKeyword());
		System.out.println("searchtype ====> " + UserVO.getSearchType());
		listcount = userMapper.listCount(UserVO);
		System.out.println("listcount ====> " + listcount);
		PageVO<UserVO> paging = new PageVO<UserVO>(listcount, currentPage, pageSize, blockSize);
		
		if(listcount>0) {
			HashMap map = new HashMap<>();
			
			map.put("keyword", UserVO.getKeyword());
			map.put("searchType", UserVO.getSearchType());
			map.put("startNo", paging.getStartNo());
			map.put("pageSize", paging.getPageSize());
			
			List<UserVO> list = userMapper.list(map);
			paging.setList(list);
		}
		
		return paging;
	}
	
	//게시판 상세
	public UserVO detail(int idx) {
		UserVO detail = userMapper.detail(idx);
		
		return detail;
	}
	
	public void update(UserVO userVO) {
		userMapper.update(userVO);
	}
	
	public void updatEnabled(int idx) {
		userMapper.updatEnabled(idx);
	}
	
	//비밀번호 초기화 >> 자기ID
	public void resetPassword(UserVO userVO) {
		
		userVO.setPASSWORD(pwEncoder.encode(userVO.getID()));		
		userMapper.resetPassword(userVO);
									
	}

}
