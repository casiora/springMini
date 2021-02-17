package com.mini.board;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mini.board.vo.BoardVO;

@Component("fileUtils")
public class FileUtils {
	
	private static final String filePath = "D:\\storage\\";
	
	//단일 파일 업로드
	public List<Map<String, Object>> parseInsertFileInfo(BoardVO boardVo, MultipartHttpServletRequest mpReq) throws Exception{
		Iterator<String> iterator = mpReq.getFileNames();
		
		MultipartFile multipartFile = null;
		String ORG_FILENM = null;
		String FILE_EXTEND = null;
		String MASK_FILENM = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		int bno = boardVo.getBno();
		
		File file = new File(filePath);
		if(file.exists() == false) {
			file.mkdirs();
		} 
		
		while(iterator.hasNext()) {
			multipartFile = mpReq.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) {
				ORG_FILENM = multipartFile.getOriginalFilename();
				FILE_EXTEND = ORG_FILENM.substring(ORG_FILENM.lastIndexOf("."));
				MASK_FILENM = getRandomString() + FILE_EXTEND;
				
				file = new File(filePath + MASK_FILENM);
				multipartFile.transferTo(file);
				listMap = new HashMap<String, Object>();
				listMap.put("BNO", bno);
				listMap.put("ORG_FILENM", ORG_FILENM);
				listMap.put("MASK_FILENM", MASK_FILENM);
				listMap.put("FILESIZE", multipartFile.getSize());
				list.add(listMap);
			}
		}
		
		return list;
		
	}
	
	//다중 파일 업로드
	public List<Map<String, Object>> parseInsertFileInfo(BoardVO boardVo, String[] files, String[] fileNames, MultipartHttpServletRequest mpReq) throws Exception{
		Iterator<String> iterator = mpReq.getFileNames();
		
		MultipartFile multipartFile = null;
		String ORG_FILENM = null;
		String FILE_EXTEND = null;
		String MASK_FILENM = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		int bno = boardVo.getBno();
		
		while(iterator.hasNext()) {
			multipartFile = mpReq.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) {
				ORG_FILENM = multipartFile.getOriginalFilename();
				FILE_EXTEND = ORG_FILENM.substring(ORG_FILENM.lastIndexOf("."));
				MASK_FILENM = getRandomString() + FILE_EXTEND;
				multipartFile.transferTo(new File(filePath + MASK_FILENM));
				
				listMap = new HashMap<String, Object>();
				listMap.put("IS_NEW", "Y");
				listMap.put("BNO", bno);
				listMap.put("ORG_FILENM", ORG_FILENM);
				listMap.put("MASK_FILENM", MASK_FILENM);
				listMap.put("FILESIZE", multipartFile.getSize());
				list.add(listMap);
			}
		}
		
		if(files != null && fileNames != null) {
			for(int i=0; i<fileNames.length; i++) {
				listMap = new HashMap<String, Object>();
				listMap.put("IS_NEW", "N");
				listMap.put("FILE_NO", files[i]);
				list.add(listMap);
			}
		}
		
		return list;
		
	}

	private String getRandomString() {
		// TODO Auto-generated method stub
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}
