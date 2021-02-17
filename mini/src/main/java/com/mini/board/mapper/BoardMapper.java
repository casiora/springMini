package com.mini.board.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mini.board.vo.BoardVO;
import com.mini.common.config.MapperInterface;

@MapperInterface("boardMapper")
public interface BoardMapper {

	public List<BoardVO> list(HashMap map);
	public int listCount(BoardVO boardVO);
	public BoardVO getDetail(int i);
	public int write(BoardVO boardVO);
	public void update(BoardVO boardVO);
	public void deleteBoard(int i);
	public void insertFile(HashMap map);
	public void insertFile(Map<String, Object> map);
	public List<Map<String, Object>> selectFileList(int bno);
	public Map<String, Object> selectFileInfo(Map<String, Object> map);
}
