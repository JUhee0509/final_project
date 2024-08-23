<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String adminMenu = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<% String adminBoard = Common.VisitAdminBoard.VIEW_PATH + "admin_board.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/store/resources/css/board.css">
		<script>
			function send(f){
				
				let title = f.title.value;
				let content = f.content.value;
				
				if(title == ''){
					alert("제목을 입력해주세요");
					return;
				}else if(content == ""){
					alert("내용을 입력해주세요.");
					return;
				}
				
				f.action = "notice_fin.do";
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
		<form>
			<table>
				<tr>
					<td>제목</td>
					<td><input name="title" class="text" size="100"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea class="text" cols="40" rows="80" name="content" wrap="hard"></textarea></td>
				</tr>
			</table>
			<input type="button" value="등록" onclick="send(this.form);">
			<input type="button" value="취소" onclick="history.go(-1);">
		</form>
	</body>
</html>