<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${ empty user }">
	<script>
		alert("로그인 후 이용 가능합니다.");
		location.href="login_main.do";//나중에 로그인페이지로 이동
	</script>
</c:if>