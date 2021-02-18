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
<a href="/">홈 화면 바로가기</a>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form[name='frm']");		
		
		$(".update_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/user/update");
			formObj.attr("method", "post");
			formObj.submit();
		})		
		
		$(".list_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/user/list");
			formObj.attr("method", "post");
			formObj.submit();
		})
	})
	
</script>
</head>
<body>
	<div>
	<h2>회원정보</h2>
		<div>
			<form name="frm" method="post">
			<input type="hidden" name="IDX" value="${detail.IDX }" />	
			<table>
				<tbody>				
				<tr>
					<td>
						<label for="ID">ID<input type="text" id="ID" name="ID" value="${detail.ID }" readonly ></label>
					</td>	
				</tr>
				<tr>	
					<td>
						<label for="ID">이름<input type="text" id="NAME" name="NAME" value="${detail.NAME }" ></label>
					</td>
				</tr>
				<tr>
					<td>
						<label for="writer">권한<input type="text" id="AUTHORITY" name="AUTHORITY" value="${detail.AUTHORITY }" <c:if test="${detail != null and not empty detail}">readonly</c:if>></label>
					</td>
				</tr>
				<tr>	
					<td>
						<label for="writer">등록일</label>
						<fmt:formatDate value="${detail.REGDATE}" pattern="yyyy-MM-dd"/>					
					</td>
				</tr>		
			</tbody>			
			</table>			
			<div class="buttonWrap fr">
				<button type="submit" class="update_btn">수정</button>
				<button type="button" class="list_btn">목록</button>
			</div>			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
		</div>
	</div>
</body>
</html>