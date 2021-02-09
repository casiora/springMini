package com.mini.user.mapper;

import com.mini.common.config.MapperInterface;
import com.mini.user.vo.UserVO;

@MapperInterface("userMapper")
public interface UserMapper {
	public UserVO selectUserById(String name);

	public void updateFailureCount(String username);

	public int checkFailureCount(String username);

	public void updateDisabled(String username);
}
