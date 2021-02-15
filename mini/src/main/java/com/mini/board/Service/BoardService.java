package com.mini.board.Service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mini.board.mapper.BoardMapper;
import com.mini.board.vo.BoardVO;
import com.mini.common.vo.PageVO;


@Service("boardService")
public class BoardService {
	
	@Resource(name="boardMapper")
	private BoardMapper boardMapper;
	
	//리스트
	public PageVO<BoardVO> list(BoardVO boardVO,int currentPage, int pageSize, int blockSize){
		int listcount = 0; 
		System.out.println("keyword ====> " + boardVO.getKeyword());
		System.out.println("searchtype ====> " + boardVO.getSearchType());
		listcount = boardMapper.listCount(boardVO);
		System.out.println("listcount ====> " + listcount);
		PageVO<BoardVO> paging = new PageVO<BoardVO>(listcount, currentPage, pageSize, blockSize);
		
		if(listcount>0) {
			HashMap map = new HashMap<>();
			
			map.put("keyword", boardVO.getKeyword());
			map.put("searchType", boardVO.getSearchType());
			map.put("startNo", paging.getStartNo());
			map.put("pageSize", paging.getPageSize());
			
			List<BoardVO> list = boardMapper.list(map);
			paging.setList(list);
		}
		
		return paging;
	}
	//상세
	public BoardVO getDetail(int i) {
		BoardVO detail = boardMapper.getDetail(i);
		
		return detail;
	}
	//등록
	public void write(BoardVO boardVO) {
		boardMapper.write(boardVO);
		
	}
	//수정
	public void update(BoardVO boardVO) {
		boardMapper.update(boardVO);
		
	}
	
	//리스트 - 우성 210128
	public void deleteBoard(int i) throws Exception{
		boardMapper.deleteBoard(i);
	}
	
}
