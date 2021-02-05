package com.mini.common.vo;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PageVO<T> {
	
	private Logger logger = LoggerFactory.getLogger(PageVO.class);
	// 입력받을 변수 4개
	private int totalCount;			// 전체 개수
	private int currentPage;		// 현재 페이지
	private int pageSize;			// 페이지당 글 수
	private int blockSize;			// 하단표시 페이지 갯수

	// 계산할 변수 5개
	private int totalPage;			// 전체 페이지 수
	private int startNo;			// 시작 글번호
	private int endNo;				// 끝 글번호(오라클만 사용)
	private int startPage;			// 시작 페이지 번호
	private int endPage;			// 끝 페이지 번호
	
	// 1페이지 분량의 VO 데이터를 담을 변수
	private List<T> list;			// 여기에 DB에서 1페이지 분량을 얻어서 담는다.
	
	// 입력변수는 생성자로 받자!!!
	public PageVO(int totalCount, int currentPage, int pageSize, int blockSize) {
		super();
		this.totalCount = totalCount;
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.blockSize = blockSize;
		// 나머지 변수는 계산을 하자!!!
		calc();
	}
	private void calc() {
		// 일단은 입력된 변수의 유효성을 검증하자!!!
		if(currentPage<=0) currentPage =1; // 현재페이지가 0이하일 수 없다.
		if(pageSize<1) pageSize = 10; // 페이지당 글수는 1보다 적을 수 없다
		if(blockSize<1) blockSize = 10; // 페이지 리스트는 1보다 적을 수 없다
		if(totalCount>0) {
			totalPage = (totalCount-1)/pageSize + 1;
			// 현재 페이지는 전체 페이지 수보다 클 수 없다
			if(currentPage>totalPage) currentPage = 1;
			startNo = (currentPage-1)*pageSize; // 오라클은 +1을 해준다.
			endNo = startNo + pageSize -1;
			//끝 글번호는 전체 개수를 넘을 수 없다.
			if(endNo>totalCount) endNo = totalCount; // 오라클에서만 사용
			startPage = (currentPage-1)/blockSize * blockSize + 1;
			endPage = startPage + blockSize - 1;
			// 마지막 페이지 번호는 전체 페이지 보다 클 수 없다.
			if(endPage>totalPage) endPage = totalPage;
		}
	}

	// list를 뺀 모든 멤버는 getter만 만들어 준다.
	public List<T> getList() {
		return list;
	}
	public void setList(List<T> list) {
		this.list = list;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public int getStartNo() {
		return startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public int getStartPage() {
		return startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	
	
	@Override
	public String toString() {
		return "Paging [totalCount=" + totalCount + ", currentPage=" + currentPage + ", pageSize=" + pageSize
				+ ", blockSize=" + blockSize + ", totalPage=" + totalPage + ", startNo=" + startNo + ", endNo=" + endNo
				+ ", startPage=" + startPage + ", endPage=" + endPage + ", list=" + list + "]";
	}
	//---------------------------------------------------------------------------------------------------------
	// 페이지 상단에 페이지 정보를 출력해주는 메서드 작성
	public String getPageInfo() {
		String msg = totalCount + "개";
		return msg;
	}
	
	// 페이지 하단에 페이지 번호 링크 출력해주는 메서드 작성
	public String getPageList() {
		StringBuilder sb = new StringBuilder();
		sb.append("<div class='pages'>");
		// 이전은 시작페이지 번호가 1보다 클때만 있다.
		if(startPage>1) {
//			sb.append("<a href=\"javascript:sendPost('?',{'s_srch_name':$('#s_srch_name').val(),'p':1,'s':"+pageSize+",'b':"+blockSize+"});\">");
//			sb.append("◂");
//			sb.append("</a>");nationality_gb

			sb.append("<a href=\"javascript:$('#p').val("+(startPage-1)+");$('#s').val("+pageSize+");$('#b').val("+blockSize+"); fn_search();\">");
			sb.append("◂");
			sb.append("</a>");
		}
		// 페이지 번호 반복
		for(int i=startPage;i<=endPage;i++) {
			// 현재 페이지는 링크를 걸지 않는다.
			if(i==currentPage) {
				sb.append("<a class='page_current'>" + i + "</a>");
			}else {		   
				sb.append("<a class='page' href=\"javascript:$('#p').val("+i+");$('#s').val("+pageSize+");$('#b').val("+blockSize+"); fn_search();\">" + i + "</a>");
			}
		}
		// 다음은 끝페이지 번호가 전체페이지 번호 보다 적을때만 있다.
		if(endPage<totalPage) {
			sb.append("<a href=\"javascript:$('#p').val("+(endPage+1)+");$('#s').val("+pageSize+");$('#b').val("+blockSize+"); fn_search();\">");
			sb.append("▸");
			sb.append("</a>");
//			sb.append("<a href=\"javascript:sendPost('?',{'s_srch_name':$('#s_srch_name').val(),'p':"+((totalCount/pageSize)+1)+",'s':"+pageSize+",'b':"+blockSize+"});\">");
//			sb.append("▸");
//			sb.append("</a>");
		}
		sb.append("</div>");
		return sb.toString();
	}
	
}
