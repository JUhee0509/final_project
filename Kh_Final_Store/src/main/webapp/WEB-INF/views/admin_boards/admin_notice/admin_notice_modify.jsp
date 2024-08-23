<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String adminMenu = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<% String adminBoard = Common.VisitAdminBoard.VIEW_PATH + "admin_board.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Eclat de Luxe</title>
		<script src="/store/resources/js/httpRequest.js"></script>
		<link rel="stylesheet" href="/store/resources/css/board.css">
		
		<script>
			function modify_notice(f) {
				
				f.action = "admin_modify_fin.do";
				f.submit();
			}
			
			
		</script>
	</head>
	
	<body>
		<div class="fixed-header">
		<jsp:include page="<%= adminMenu %>"/>
	</div>
	
	 <div class="board_menu">
		<jsp:include page="<%= adminBoard %>"/>	
	</div>
		
		<div class="text_container">
			<h1>NOTICE</h1>
			<h5>공지사항</h5>
		</div>
		
		<div class="notice-details">
		<form>
        <table class="notice-table">
            <tr>
                <td>제목</td>
                <td><input name="title" value="${ vo.title }"></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea class="text" cols="40" rows="80" name="content" wrap="hard">${ vo.content }</textarea></td>
            </tr>
        </table>
        <input type="hidden" name="idx" value="${ vo.idx }">
        
       <input type="button" value="수정하기" onclick="modify_notice(this.form)">
        <input type="button" value="취소하기" onclick="history.go(-1);">
        </form>
    </div>
    
	</body>
</html>