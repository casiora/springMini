package com.mini.board.Controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mini.board.Service.BoardService;
import com.mini.board.vo.BoardVO;
import com.mini.common.vo.PageVO;

@Controller
@RequestMapping("board")
public class BoardController {
	
	@Resource(name ="boardService")
	private BoardService boardService;
	
	
	//리스트
	@RequestMapping(value="list")
	public String list(BoardVO boardVO,
	 @RequestParam(defaultValue = "1", value = "p", required = false) int currentPage, 
	 @RequestParam(defaultValue = "10", value = "s", required = false) int pageSize, 
	 @RequestParam(defaultValue = "5", value = "b", required = false) int blockSize,
	Model model) throws Exception {
		
		PageVO<BoardVO> paging = boardService.list(boardVO, currentPage, pageSize, blockSize);
		model.addAttribute("paging", paging);
		
		return "board/list";
		
	}
	
	//디테일 페이지
	@RequestMapping(value="detail", method=RequestMethod.GET)
	public String detail (BoardVO boardVO, Model model) throws Exception {
			
		BoardVO detail = boardService.getDetail(boardVO.getBno());
		model.addAttribute("detail",detail);

		return "board/detail";
	}
	
	//등록
	@RequestMapping(value="write", method=RequestMethod.POST)
	public String write(BoardVO boardVO) {
			
		boardService.write(boardVO);
		
		return "redirect:../board/list";
	}
	
	//수정
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(BoardVO boardVO) {

			boardService.update(boardVO);
				
			return "redirect:../board/list";
	}
	
	
	@RequestMapping(value="delete", method = RequestMethod.POST)
	public String delete(@RequestParam("ckbox") List<Integer> ids) throws Exception{

			for(Integer i: ids) boardService.deleteBoard(i);
	
		return "redirect:/board/list";
	}
}
