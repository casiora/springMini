<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	String name = "";
	if(auth.getPrincipal() != null) {
		name = auth.getName();
	}
%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<a href="/map/map">지도</a>
<a href="/board/list">게시판</a>
<a href="/user/list">회원관리</a>

<div class="container text-center">
         <sec:authorize access="isAnonymous()">
         	<h5><a href='<c:url value="/user/secu/loginPage"/>' class="badge badge-pill badge-info">LOGIN</a> 로그인 해주세요.</h5>
         </sec:authorize>
 		 <sec:authorize access="isAuthenticated()">
 		    <h5><%=name %>님, 반갑습니다.</h5>
           <%--  <p><sec:authentication property="principal.loginId"/>님, 반갑습니다.</p> --%>
	        <form action="/logout" method="POST">
	                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                <button type="submit" class="btn btn-dark btn-sm">LOGOUT</button>
	        </form>
         </sec:authorize>
</div>


 <div class="container text-center col-2">
          <a href='<c:url value="/page"/>' role="button" class="btn btn-outline-secondary btn-block">GUEST</a>
          <a href='<c:url value="/user/page"/>' role="button" class="btn btn-outline-secondary btn-block">USER</a>
          <a href='<c:url value="/member/page"/>' role="button" class="btn btn-outline-secondary btn-block">MEMBER</a>
          <a href='<c:url value="/admin/page"/>' role="button" class="btn btn-outline-secondary btn-block">ADMIN</a>
</div>

</body>
</html>
