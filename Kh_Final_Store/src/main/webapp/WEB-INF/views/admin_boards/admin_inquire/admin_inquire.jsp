<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String adminMenu = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<% String adminBoard = Common.VisitAdminBoard.VIEW_PATH + "admin_board.jsp"; %>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/store/resources/css/board.css">
	</head>
	<body>
	<div class="fixed-header">
		<jsp:include page="<%= adminMenu %>"/>
	</div>
	
	 <div class="board_menu">
		<jsp:include page="<%= adminBoard %>"/>	
	</div>
	
	<div class="text_container">
		<h1>나의 문의</h1>
		<h5>문의사항</h5>
	</div>
		
	    <table>
	            <tr>
	                <th width="10%">글번호</th>
	                <th width="10%">문의종류</th>
	                <th>제목</th>
	                <th width="10%">작성자</th>
	                <th>답변상태</th> 
	                <th width="15%">작성일</th>
	            </tr>
	            <c:forEach var="vo" items="${ list }">
	                <tr>
	                    <td>${ vo.i_idx }</td>
	                    <td>${ vo.type }</td>
	                    <td><a href="admin_inquire_view.do?i_idx=${ vo.i_idx }&page=${param.page}">${ vo.title }</a></td>
	                    <td>${ vo.c_id }</td>
	                    <td>${ vo.status }</td>
	                    <td>${ vo.regdate }</td>
	                </tr>
	            </c:forEach>
	    </table>
	    <div class="pageMenu">
	        ${ pageMenu }
	    </div>
	    
		<div class="btn_container">
	    	<!-- 지울것 :  <input type="button" value="문의답변하기" onclick="location.href='admin_inquire_write.do'"> -->
	    </div>
	</body>
</html>