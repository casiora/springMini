<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			formObj.attr("action", "${pageContext.request.contextPath}/board/write");
			formObj.attr("method", "post");
			formObj.submit();
		})
		
		$(".delete_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/board/delete");
			formObj.attr("method", "post");
			formObj.submit();
		})
		
		$(".list_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/board/list");
			formObj.attr("method", "post");
			formObj.submit();
		})
	})
	
	
	function list(){
			var formObj = $("form[name='frm']");
			formObj.attr("action", "${pageContext.request.contextPath}/board/list");
			formObj.attr("method", "post");
			formObj.submit();
		}
	
	
</script>
</head>
<body>
	<div>
	<h2>글쓰기</h2>
		<div>
			<form name="frm" role="form" method="post">
			<input type="hidden" name="ckbox" value="${detail.bno }" />
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
			</tbody>
			</table>
			<div class="buttonWrap fr">
				<c:choose>
					<c:when test="${detail != null and not empty detail}">
						<button type="button" onclick="update();">수정</button>
						<button type="submit" class="delete_btn">삭제</button>
					</c:when>
					<c:otherwise>
						<button type="submit" class="write_btn">저장</button>
					</c:otherwise>
				</c:choose>
				<button onclick="list()">목록</button>
			</div>
			</form>
		</div>
	</div>
</body>
</html>