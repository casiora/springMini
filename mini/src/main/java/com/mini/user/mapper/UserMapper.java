package com.mini.user.mapper;

import java.util.HashMap;
import java.util.List;

import com.mini.common.config.MapperInterface;
import com.mini.user.vo.UserVO;

@MapperInterface("userMapper")
public interface UserMapper {
	public UserVO selectUserById(String name);

	public void updateFailureCount(String username);

	public int checkFailureCount(String username);

	public void updateDisabled(String username);

	public void resetFailureCount(String username);
	
	public void signID(UserVO userVo);
	
	public int idChk(String username);
	
	public List<UserVO> list(HashMap map);
	public int listCount(UserVO userVO);
	public UserVO detail(int idx);
	public void update(UserVO userVO);
}
