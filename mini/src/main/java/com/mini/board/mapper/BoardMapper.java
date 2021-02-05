package com.mini.board.mapper;

import java.util.HashMap;
import java.util.List;

import com.mini.board.vo.BoardVO;
import com.mini.common.config.MapperInterface;

@MapperInterface("boardMapper")
public interface BoardMapper {

	public List<BoardVO> list(HashMap map);
	public int listCount(BoardVO boardVO);
	public BoardVO getDetailBoard(int i);
	public void insertBoard(BoardVO boardVO);
	public void updateBoard(BoardVO boardVO);
	public void deleteBoard(int i);

}
