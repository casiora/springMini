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
		
		$(".delete_btn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath}/board/delete.do");
			formObj.attr("method", "post");
			formObj.submit();
		})
	})

	function fn_update() {
		var title = $("#title").val();
		var writer = $("#writer").val();
		var content = $("#content").val();
		var bno = $("#bno").val();
		
		if (title == null || title == ""
			|| title == "undefined") {
		alert("제목을 입력하세요.");
		return;
		}
		if (content == null || content == ""
			|| content == "undefined") {
		alert("내용을 입력하세요.");
		return;
		}
		
		var form = {
				"title" : title,
				"writer" : writer,
				"content" : content,
				"bno" : bno
		};
				$.ajax({
					type : 'post'
					,async : true
					,url : '${pageContext.request.contextPath }/board/updateBoard.do'
					,contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
					,data : form
					,success : function(data) {
						if(data == "success") {				
							alert("저장되었습니다.");	
							location.reload();
						} else if(data == "fail") {
							alert("실패하였습니다.");							
							location.reload();
						}
					},
					error : function(data, status, err) {
						alert('서버와의 통신이 실패했습니다.');
					}
				});
	}

			

	function fn_insert() {
		var title = $("#title").val();
		var writer = $("#writer").val();
		var content = $("#content").val();
		
		if (title == null || title == ""
			|| title == "undefined") {
		alert("제목을 입력하세요.");
		return;
		}
		if (content == null || content == ""
			|| content == "undefined") {
		alert("내용을 입력하세요.");
		return;
		}
		
 		
	var form = {
			"title" : title,
			"writer" : writer,
			"content" : content
	};
			$.ajax({
				type : 'post'
				,async : true
				,url : '${pageContext.request.contextPath }/board/insertBoard.do'
				,contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
				,data : form
				,success: function (data) {  
		        	if(data == "success"){
		        		alert("저장되었습니다.");
		        		 goList();
		        	} else if(data == "fail"){
		        		alert("실패하였습니다.");
		        		location.reload();
		        	}		        	
		        }
		        , error  : function (data, status, err) {
		            alert('서버와의 통신이 실패했습니다.');
		        }
		    });
	}
	function fn_goList() {
		location.href = "${pageContext.request.contextPath }/board/list.do?p=${page}";
	}
	
	
	
</script>
</head>
<body>
	<div>
	<h2>작성</h2>
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
						<button type="button" onclick="fn_update();">수정</button>
						<button type="submit" class="delete_btn">삭제</button>
					</c:when>
					<c:otherwise>
						<button type="button" onclick="fn_insert();">저장</button>
					</c:otherwise>
				</c:choose>
				<button type="button" onclick="fn_goList();">목록</button>
			</div>
			</form>
		</div>
	</div>
</body>
</html>