<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>등록</title>
<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form[name='frm']");
		
		$(".sign_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/user/sign");
			formObj.attr("method", "post");
			formObj.submit();
		})
		
		$(".cancel_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/user/secu/loginPage");
			formObj.attr("method", "post");
			formObj.submit();
		})
	})
	
	
</script>
</head>
<body>
	<div>
	<h2>작성</h2>
		<div>
			<form name="frm" role="form" method="post">
			<table>
				<tbody>
				<tr>
					<td>
						<label for="id">ID<input type="text" id="ID" name="ID" ></label>
					</td>	
				</tr>
				<tr>	
					<td>
						<label for="password">비밀번호<input type="password" id="PASSWORD" name="PASSWORD" ></label>
					</td>
				</tr>
				<tr>
					<td>
						<label for="name">이름<input type="text" id="NAME" name="NAME" ></label>
					</td>
				</tr>
			</tbody>
			</table>
			 <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
			<div class="buttonWrap fr">
				<button type="submit" class="sign_btn">회원가입</button>
				<button type="submit" class="cancel_btn">취소</button>
			</div>
			</form>
		</div>

	</div>
</body>
</html>