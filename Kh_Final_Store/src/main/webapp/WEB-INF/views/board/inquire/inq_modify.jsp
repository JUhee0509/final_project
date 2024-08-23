<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String check_login = Common.index.VIEW_PATH + "login.jsp"; %>
<% String board = Common.Visit_board.VIEW_PATH + "board.jsp"; %>
<% String mainMenu = Common.index.VIEW_PATH + "index.jsp"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Eclat de Luxe</title>
		<script src="/store/resources/js/httpRequest.js"></script>
		<link rel="stylesheet" href="/store/resources/css/board.css">
		
		
		
		<script>
			function modify(f){
				
				let title = f.title.value;
				let content = f.content.value;
				let type = f.type.value;
				
				//유효성 검사
				if(title == ""){
					alert("제목을 입력하세요");
					return;
				}else if(content == ""){
					alert("내용을 입력하세요.");
					return;
				}
				
				let url="inq_modify_fin.do"
			
				let param = 'i_idx=${vo.i_idx}&title='+title+'&content='+content+'&type='+type;
				sendRequest(url, param, modifyFn, "POST");
			}
			
			//수정후
			function modifyFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					
					if(data == 'complete'){
						alert("수정됐습니다.");
						location.href="inquire_view.do?i_idx=${vo.i_idx}";
					}else{
						alert("수정 실패했습니다.");
					}
				}
			}
		</script>
	</head>
		
	<body>
	<!-- 문의 수정 -->
	<div class="fixed-header">
        	<jsp:include page="<%= mainMenu %>"/>
   	 	</div>
	<jsp:include page="<%= board %>"/>
		<jsp:include page="<%= check_login %>"/><!-- 로그인여부 확인  -->
		
		
		<div class="text_container">
		<h1>1:1 문의</h1>
		<h5>문의 수정</h5>
		</div>
		<form>
			<table border="1">
				<tr>
					<td>제목</td>
					<td><input class="text" value="${ vo.title }" name="title"></td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td>
					<textarea class="text" cols="40" rows="80" name="content" wrap="hard">${ vo.content }"</textarea>
					</td>
				</tr>
				
				<tr>
					<td>종류</td>
					<td>
					<div class="inquire_list">
						<select name="type" class="selected">
							<option value="배송">배송</option>
							<option value="return">반품</option>
							<option value="exchange">교환</option>
							<option value="refund">환불</option>
						</select>
					</div>
					</td>
				</tr>
					<tr>
						<td>사진첨부</td>
						<td><input type="file" name="photo" class="selected" value="${ vo.image }"></td>
					<tr>
			</table>
			<div class="btn_container">
				<input type="button" value="수정하기" onclick="modify(this.form);">
				<input type="button" value="취소하기" onclick="history.go(-1);">
			</div>
		</form>	
	</body>
</html>