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
		
		$(".enabled_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/user/updatEnabled");
			formObj.attr("method", "post");
			formObj.submit();
		})
		
		$(".reset_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/user/resetPassword");
			formObj.attr("method", "post");
			formObj.submit();
		})
	})
	
	var result = '${msg}';
	if(result == 'success'){
		alert("처리완료");
	} 
	
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
						<label for="NAME">이름<input type="text" id="NAME" name="NAME" value="${detail.NAME }" ></label>
					</td>
				</tr>
				<tr>
					<td>
						<label for="AUTHORITY">권한
						<select name="AUTHORITY">
							<option value="ROLE_USER" <c:out value="${detail.AUTHORITY eq 'ROLE_USER' ? 'selected' : ''}"/>>유 저</option>
							<option value="ADMIN" <c:out value="${detail.AUTHORITY eq 'ADMIN' ? 'selected' : ''}"/>>관리자</option>
						</select>
						<%-- <input type="text" id="AUTHORITY" name="AUTHORITY" value="${detail.AUTHORITY }"> --%>
						</label>
					</td>
				</tr>
				<tr>	
					<td>
						<label for="REGDATE">등록일</label>
						<fmt:formatDate value="${detail.REGDATE}" pattern="yyyy-MM-dd"/>					
					</td>
				</tr>
				<tr>	
					<td>
						<label for="Enabled">계정 활성화</label>
						<button type="submit" class="enabled_btn">활성화</button>				
					</td>
				</tr>	
				<tr>	
					<td>
						<label for="resetPassword">비밀번호 초기화</label>
						<button type="submit" class="reset_btn">초기화</button>				
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