package com.mini.board.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mini.board.FileUtils;
import com.mini.board.mapper.BoardMapper;
import com.mini.board.vo.BoardVO;
import com.mini.common.vo.PageVO;


@Service("boardService")
public class BoardService {
	
	@Resource(name="boardMapper")
	private BoardMapper boardMapper;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
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
	//게시판 상세
	public BoardVO getDetail(int bno) {
		BoardVO detail = boardMapper.getDetail(bno);
		
		return detail;
	}
	//게시판 글 등록
	public void write(BoardVO boardVO, MultipartHttpServletRequest mpReq) throws Exception {
		//본문내용 등록
		boardMapper.write(boardVO);
		boardVO.getBno(); //글번호 가져오기
		
		//첨부파일 등록
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(boardVO, mpReq);
		int size = list.size();
		for(int i=0; i<size; i++) {
			boardMapper.insertFile(list.get(i));
		}
	}
	
	//수정
	public void update(BoardVO boardVO, String[] files, String[] fileNames, MultipartHttpServletRequest mpReq) throws Exception {
		boardMapper.update(boardVO);
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(boardVO, files, fileNames, mpReq);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for(int i=0; i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				boardMapper.insertFile(tempMap); //다수 추가
			} else {
				boardMapper.deleteFile(tempMap); //삭제
			}			
		}
		
	}
	
	//리스트 - 우성 210128
	public void deleteBoard(int i) throws Exception{
		boardMapper.deleteBoard(i);
	}
	
	//첨부파일 목록 보여주기
	public List<Map<String, Object>> selectFileList(int bno) throws Exception{
		return boardMapper.selectFileList(bno);
	}
	
	//첨부파일 다운로드
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
		return boardMapper.selectFileInfo(map);
	}
	
	
	
}
