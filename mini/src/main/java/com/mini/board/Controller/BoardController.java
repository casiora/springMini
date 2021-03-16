package com.mini.board.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
		
		List<Map<String, Object>> fileList = boardService.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);

		return "board/detail";
	}
	
	//등록
	@RequestMapping(value="write", method=RequestMethod.POST)
	public String write(BoardVO boardVO, MultipartHttpServletRequest mpReq) throws Exception{
			
		boardService.write(boardVO, mpReq);
		
		return "redirect:../board/list";
	}
	
	//수정
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(BoardVO boardVO,
						@RequestParam(value="fileNoDel[]") String[] files, 
						@RequestParam(value="fileNameDel[]")String[] fileNames, 
						MultipartHttpServletRequest mpReq) throws Exception {

		boardService.update(boardVO, files, fileNames, mpReq);
				
		return "redirect:../board/list";
	}
	
	@RequestMapping(value="filedown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse res) throws Exception{
			
		Map<String, Object> resultMap = boardService.selectFileInfo(map);
		String mask_filenm = (String) resultMap.get("MASK_FILENM");
		String org_filenm = (String) resultMap.get("ORG_FILENM");
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File("D:\\java\\springMini\\file"+mask_filenm));
		
		res.setContentType("application/octet-stream");
		res.setContentLength(fileByte.length);
		res.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(org_filenm,"UTF-8")+"\";");
	    res.setHeader("Content-Transfer-Encoding", "binary");
		res.getOutputStream().write(fileByte);
		res.getOutputStream().flush();
		res.getOutputStream().close();
	}
	
	//리스트 체크박스
	@RequestMapping(value="delete", method = RequestMethod.POST)
	public String delete(@RequestParam("ckbox") List<Integer> ids) throws Exception{

			for(Integer i: ids) boardService.deleteBoard(i);
	
		return "redirect:/board/list";
	}
}
