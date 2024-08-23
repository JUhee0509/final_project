<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<% String board = Common.Visit_board.VIEW_PATH + "board.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Eclat de Luxe</title>
		<link rel="stylesheet" href="/store/resources/css/board.css">
		
		<script>
			function modify_notice(f) {
				
			}
		</script>
	</head>
	
	<body>
		<div class="fixed-header">
        	<jsp:include page="<%= includePage %>"/>
   	 	</div>
   	 	<jsp:include page="<%= board %>"/>
		
		<div class="text_container">
			<h1>NOTICE</h1>
			<h5>공지사항</h5>
		</div>
		
		<div class="notice-details">
        <table class="notice-table">
            <tr>
                <td>제목</td>
                <td>${ vo.title }</td>
            </tr>
            <tr>
                <td>게시일</td>
                <td>${ vo.regdate }</td>
            </tr>
            <tr>
                <td>작성자</td>
                <td>관리자</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><pre>${ vo.content }</pre></td>
            </tr>
        </table>
        
       <!--  <input type="button" value="공지 글 수정" onclick="location.href='modify_notice.do'"> -->
        <input type="button" value="목록보기" onclick="history.go(-1);">
    </div>
    
	</body>
</html>