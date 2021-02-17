<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>등록</title>
<a href="/board/list.do">게시판</a>
<a href="../index.jsp">로그인</a>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form[name='frm']");
		
		$(".write_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/board/write?${_csrf.parameterName}=${_csrf.token}");
			formObj.attr("method", "post");
			formObj.submit();
		})
		
		$(".update_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/board/update?${_csrf.parameterName}=${_csrf.token}");
			formObj.attr("method", "post");
			formObj.submit();
		})
		
		$(".delete_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/board/delete?${_csrf.parameterName}=${_csrf.token}");
			formObj.attr("method", "post");
			formObj.submit();
		})
		
		$(".list_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/board/list?${_csrf.parameterName}=${_csrf.token}");
			formObj.attr("method", "post");
			formObj.submit();
		})
	})
	
	//파일다운로드
	function fileDown(fileNo){
		var formObj = $("form[name='frm']");
		$("#FILE_NO").attr("value", fileNo);
		formObj.attr("action", "${pageContext.request.contextPath}/board/filedown?${_csrf.parameterName}=${_csrf.token}");
		formObj.submit();
	}
	
	
	
	
</script>
</head>
<body>
	<div>
	<h2>글쓰기</h2>
		<div>
			<form name="frm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="ckbox" value="${detail.bno }" />
			<input type="hidden" id="FILE_NO" name="FILE_NO" value="">
			<table>
				<tbody>
				<tr>
				<c:if test="${detail.bno != null}">
					<td>
						<label for="bno">글번호<input type="text" id="bno" name="bno" value="${detail.bno }" readonly></label>
					</td>
				</c:if>	
				</tr>
				<tr>
					<td>
						<label for="title">제목<input type="text" id="title" name="title" value="${detail.title }" ></label>
					</td>	
				</tr>
				<tr>	
					<td>
						<label for="content">내용<textarea id="content" name="content"><c:out value="${detail.content}" /></textarea></label>
					</td>
				</tr>
				<tr>
					<td>
						<label for="writer">작성자<input type="text" id="writer" name="writer" value="${detail.writer }" <c:if test="${detail != null and not empty detail}">readonly</c:if>></label>
					</td>
				</tr>
				<tr>	
				<c:if test="${detail.bno != null}">
					<td>
						<label for="writer">작성날짜</label>
						<fmt:formatDate value="${detail.regdate}" pattern="yyyy-MM-dd"/>					
					</td>
				</c:if>	
				</tr>
				<tr>
					<td>
						<input type="file" name="file" >
					</td>	
				</tr>			
			</tbody>			
			</table>
			<hr>
				<span>파일 목록</span>
				<div class="form-group" style="border: 1px solid #dbdbdb;">
					<c:forEach var="file" items="${file}">
						<a href="#" onclick="fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILENM}</a>(${file.FILESIZE}kb)<br>
					</c:forEach>
				</div>
			<hr>	
			<div class="buttonWrap fr">
				<c:choose>
					<c:when test="${detail != null and not empty detail}">
						<button type="submit" class="update_btn">수정</button>
						<button type="submit" class="delete_btn">삭제</button>
					</c:when>
					<c:otherwise>
						<button type="submit" class="write_btn">저장</button>
					</c:otherwise>
				</c:choose>
				<button type="button" class="list_btn">목록</button>
			</div>			
			<!-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> -->
			</form>
		</div>
	</div>
</body>
</html>