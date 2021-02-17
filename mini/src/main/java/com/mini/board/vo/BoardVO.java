package com.mini.board.vo;

import java.util.Date;

public class BoardVO {
	
	private int bno;
	private String title;
	private String content;
	private String writer;
	
	//검색관련
	private String keyword;
	private String searchType;
	
	private String org_fileNm;
	private String mask_fileNm;
	private String filesize;
	private String file_extend;
	private String file_no;
	

	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	private Date regdate;
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getOrg_fileNm() {
		return org_fileNm;
	}
	public void setOrg_fileNm(String org_fileNm) {
		this.org_fileNm = org_fileNm;
	}
	public String getMask_fileNm() {
		return mask_fileNm;
	}
	public void setMask_fileNm(String mask_fileNm) {
		this.mask_fileNm = mask_fileNm;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	public String getFile_extend() {
		return file_extend;
	}
	public void setFile_extend(String file_extend) {
		this.file_extend = file_extend;
	}
	public String getFile_no() {
		return file_no;
	}
	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}
	

	
}
