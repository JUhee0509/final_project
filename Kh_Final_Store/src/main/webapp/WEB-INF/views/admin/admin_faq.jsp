<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String check_login = Common.index.VIEW_PATH + "login.jsp"; %>
<% String board = Common.Visit_board.VIEW_PATH + "board.jsp"; %>
<% String mainMenu = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<% String adminBoard = Common.VisitAdminBoard.VIEW_PATH + "admin_board.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <title>Eclat de Luxe</title>
    	<link rel="stylesheet" href="/store/resources/css/board.css">
	
		<script>
			function faq_modify(f) {
				f.action = "faq_modify_form.do";
				f.submit();
			}
			
			function faq_del(f) {
				if(!confirm("삭제하시겠습니까?")){
					return;
				}
				
				f.action = "faq_del.do";
				f.submit();
			
			}
		</script>
	
	</head>
	
	<body>
	    
	    <!-- 메인메뉴 -->
	    <div class="fixed-header">
	        <jsp:include page="<%= mainMenu %>"/>
	   	 </div>
	   	<div class="board_menu">
			<jsp:include page="<%= adminBoard %>"/>	
		</div>
	   	 
	    
	    <!-- 설명 -->
	    <div class="text_container">
			<h1>자주 묻는 질문</h1>
			
		</div>
		<br>
		
	    <table>
	            <tr>
	                <th width="10%">글번호</th>
	                <th width="10%">질문</th>
	                <th>답</th>
	                <th width="10%">작성자</th>
	                <th width="15%">작성일</th>
	                
	                
	            </tr>
	            <c:forEach var="vo" items="${ list }">
	                <tr>
	                    <td>${ vo.idx }</td>
	                    <td><a href="faq_view.do?idx=${vo.idx}">${ vo.question }</a></td>
	                    <td><a href="faq_view.do?idx=${vo.idx}">${ vo.answer }</a></td>
	                    <td>${ vo.a_id }</td>
	                    <td>${ vo.regdate }</td>
	                   
	                    
	                </tr>
	            </c:forEach>
	    </table>
						
	    <div class="pageMenu">
	        ${ pageMenu }
	    </div>
	    
		<div class="btn_container_bottom">
				<input type="button" value="새 글 등록" onclick="location.href='faq_reg_form.do'">
		</div>
	</body>
</html>