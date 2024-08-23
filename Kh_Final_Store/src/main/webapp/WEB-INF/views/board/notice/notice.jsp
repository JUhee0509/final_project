<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String board = Common.Visit_board.VIEW_PATH + "board.jsp"; %>
<% String mainMenu = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Eclat de Luxe</title>
		
		<link rel="stylesheet" href="/store/resources/css/board.css">
		
	</head>
		<body>
		<div class="fixed-header">
	        <jsp:include page="<%= mainMenu %>"/>
	   	 </div>
   	 	<!-- board.jsp의 css 적용을 위해 div 적용 -->
   	 	 <div class="board_menu">
	    	<jsp:include page="<%= board %>"/>
	    </div>	
		
		<div class="text_container">
			<h1>NOTICE</h1>
			<h5>공지사항</h5>
		</div>
		
		<!-- 공지사항 페이지 -->
		<br>
			<table>
				<tr>
					<td width="10%">글번호</td>
					<td>제목</td>
					<td width="10%">작성자</td>
					<td width="15%">작성일</td>
				</tr>
				<c:forEach var="vo" items="${ list }">
					<tr>
						<td>${ vo.idx }</td>
						<td><a href="notice_view.do?idx=${vo.idx}">${ vo.title }</a></td>
						<td>관리자</td>
						<td>${ vo.regdate }</td>
					</tr>
				</c:forEach>
			</table>
			<div class="pageMenu">
	        ${ pageMenu }
	    </div>
		</body>
</html>