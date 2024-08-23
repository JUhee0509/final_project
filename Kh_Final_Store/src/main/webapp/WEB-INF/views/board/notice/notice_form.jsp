<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String board = Common.Visit_board.VIEW_PATH + "board.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script>
			function send(f){
				alert("들어옴");
				f.action = "notice_fin.do";
				f.submit();
			}
		</script>
	</head>
	
	<body>
	<jsp:include page="<%= board %>"/>
		<form>
			<table>
				<tr>
					<td>제목</td>
					<td><input name="title"></td>
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