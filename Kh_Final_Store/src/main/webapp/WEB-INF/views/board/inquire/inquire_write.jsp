<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String check_login = Common.index.VIEW_PATH + "login.jsp"; %>
<% String board = Common.Visit_board.VIEW_PATH + "board.jsp"; %>
<% String mainMenu = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Eclat de Luxe</title>
		
		<link rel="stylesheet" href="/store/resources/css/board.css">
		
		<script>
			function send(f){
				
				let title = f.title.value;
				let content = f.content.value;
				
				if(title == ""){
					alert("제목을 입력하세요");
					return;
				}else if(content == ""){
					alert("내용을 입력하세요.");
					return;
				}
				
				f.action="inq_write.do";
				f.submit();
			}
		</script>
		
	</head>
	
	<body>
		<!-- 문의 글작성 -->
		<jsp:include page="<%= check_login %>"/><!-- 로그인여부 확인 -->
		<jsp:include page="<%= mainMenu %>"/>
		<form method="post" enctype="multipart/form-data">
		<input type="button" value="shop" onclick="location.href='mainPage.do'"><!-- shop페이지 이동 --><br>
		
		<jsp:include page="<%= board %>"/>
		
		
		<div class="text_container">
			<h1>1:1 문의</h1>
			<h4>문의 작성</h4>
		</div>
		
		<table border="1">
			<tr>
				<th class="th">제목</th>
				<td><input name="title" class="text" size="100"></td>
			</tr>
			
			<tr>
				<th class="th">내용</th>
				<td><textarea class="text" cols="40" rows="80" name="content" wrap="hard"></textarea></td>
						
			</tr>
			
			<tr>
				<th class="th">종류</th>
				<td>
					<select name="type" class="selected">
						<option value="배송">배송</option>
						<option value="반품">반품</option>
						<option value="교환">교환</option>
						<option value="환불">환불</option>
						
					</select>
				</td>
			</tr>
			
			<tr>
				<th>사진첨부</th>
				<td><input type="file" name="photo" class="selected"></td>
			</tr>
			
			
		</table>
		<input type="hidden" value=${ user } name="c_id">
		
		<div class="btn_container_bottom">
			<input type="button" value="등록" onclick="send(this.form);">
			<input type="button" value="취소" onclick="history.go(-1);"></div>
		</form>
		
	</body>
</html>