<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String check_login = Common.index.VIEW_PATH + "login.jsp"; %>
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
		<!-- 로그인 여부 체크 -->
	    <jsp:include page="<%= check_login %>"/>
	    
	    <!-- 메인메뉴 -->
	    <div class="fixed-header">
	        <jsp:include page="<%= mainMenu %>"/>
	   	 </div>
	   	 
	   	 <!-- 고객센터 메뉴 -->
	   	 <div class="board_menu">
	    	<jsp:include page="<%= board %>"/>
	    </div>	
	    
	    <!-- 설명 -->
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
	                <th width="15%">작성일</th>
	            </tr>
	            <c:forEach var="vo" items="${ list }">
	                <tr>
	                    <td>${ vo.i_idx }</td>
	                    <td>${ vo.type }</td>
	                    <td><a href="inquire_view.do?i_idx=${ vo.i_idx }&page=${param.page}">${ vo.title }</a></td>
	                    <td>${ vo.c_id }</td>
	                    <td>${ vo.regdate }</td>
	                </tr>
	            </c:forEach>
	    </table>
	    <div class="pageMenu">
	        ${ pageMenu }
	    </div>
	    
		<div class="btn_container">
	    	<input type="button" value="문의하기" onclick="location.href='inquire_write.do'">
	    </div>
	</body>
</html>