<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Study Page</title>
<a href="/">홈 화면 바로가기</a>
<a href="../map/map">지도</a>
<a href="../board/list">게시판</a>
<style>
table, th, td { padding: 5px; }
</style>
<script type="text/javascript">
	function fn_search(){
		var form = document.getElementById("frm");
		form.action="${pageContext.request.contextPath}/board/list";
		form.submit();
	}
 	//전체 체크박스 체크 시 액션
	$(function(){
		$("#allCheckbox").click(function(){
			if($("#allCheckbox").prop("checked")){
				$("input[type=checkbox]").prop("checked",true);
				} else{
					$("input[type=checkbox]").prop("checked",false);	
				}
		});
	});
	
	$(function(){
		$("input[name=ckbox]").click(function(){
				$("#allCheckbox").prop("checked",false);
		});
	}); 
	
	$(document).ready(function(){
		var formObj = $("form[id='frm']");
		
		$(".detail_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/board/detail");
			formObj.attr("method", "get");
		})
		
		$(".delete_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/board/delete");
			formObj.attr("method", "post");
			formObj.submit();
		})
	})

	
</script>
</head>
<body>
	<h3>게시판</h3>
			<section id="container">
				<form id="frm" role="form" method="post">
						<input type="hidden" id ="p" name ="p"/>
	                   	<input type="hidden" id ="s" name ="s"/>
	                   	<input type="hidden" id ="b" name ="b"/>
					<table>
						<tr>
						<th><input type="checkbox" name="allCheckbox" id="allCheckbox" /></th>
						<th>번호</th><th>제목</th><th>작성자</th><th>등록일</th>
						</tr>
						
						<c:forEach var="list" items="${paging.list }">
						<tr>
							<td><input type="checkbox" name="ckbox" id="ckbox" value="${list.bno}"/></td>
							<td><c:out value="${list.bno}"/></td>
							<td><a href="/board/detail?bno=${list.bno}"><c:out value="${list.title}" /></a></td>
							<td><c:out value="${list.writer}" /></td>
							<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
						</tr>
						</c:forEach>																		
					</table>
													
               	<div id="pagination" style="overflow: hidden;margin-top: 10px;">
				    <c:if test="${paging.totalCount > 10}">
					${paging.pageList }
					</c:if>
				</div>
			<div class="search">
			
				    <select name="searchType">
				   
				      <option value="null"<c:out value="${paging.list[0].searchType == null ? 'selected' : ''}"/>>----</option>
				      <option value="t"<c:out value="${paging.list[0].searchType eq '' ? 'selected' : ''}"/>>제목</option>
				      <option value="c"<c:out value="${paging.list[0].searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
				      <option value="w"<c:out value="${paging.list[0].searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>	
				      <option value="tc"<c:out value="${paging.list[0].searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option> 		
				   
				   </select>	
				 <input type="text" name="keyword" id="keywordInput" value="${list.keyword}"/>
   				 <button id="searchBtn" type="button" onclick="fn_search();">검색</button>    
			</div>		    
			<table>
			<tr>
				<td>
				<button type="submit" class="detail_btn">글쓰기</button>
				<button type="submit" class="delete_btn">삭제</button>
				</td>
			</tr>	
			</table>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">				
			</form>
			</section>
	</body>
	
</html>		