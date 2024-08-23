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
		
		<link rel="stylesheet" href="/store/resources/css/board.css">
		
		<script>
			function send(f){
				
				let content = f.content.value;
				
				if(content == ""){
					alert("내용을 입력하세요.");
					return;
				}
				
				f.action="admin_inq_write.do";
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
		<!-- 문의 글작성 -->
		<form>
		
		<div class="text_container">
			<h1>1:1 문의</h1>
			<h4>문의 작성</h4>
		</div>
		
		<h3>문의</h3>
		<table>
				
					
					<tr>
						<td width="20%">제목</td>
						<td>${ vo.title }</td>
					</tr>
					
					<tr>
						<td>작성자</td>
						<td>${ vo.c_id }</td>
					</tr>
					
					
					<tr>
						<td>분류</td>
						<td>${ vo.type }</td>
					</tr>
					
					
					<tr>
						<td>상태</td>
						<td>${ vo.status }</td>
					</tr>
					
					<tr>
						<td>내용</td>
						<td><pre>${ vo.content }</pre></td>
					</tr>
					
				</table>	
		
		
		<table border="1">
			
			<tr>
				<th>내용</th>
				<td><textarea class="text" cols="40" rows="80" name="content" wrap="hard"></textarea></td>
						
			</tr>
			
			
		</table>
		<input type="hidden" value=${ admin } name="a_id">
		<input type="hidden" value="${ i_idx }" name="i_idx">
		
		<div class="btn_container_bottom">
			<input type="button" value="등록" onclick="send(this.form);">
			<input type="button" value="취소" onclick="history.go(-1);"></div>
		</form>
		
	</body>
</html>