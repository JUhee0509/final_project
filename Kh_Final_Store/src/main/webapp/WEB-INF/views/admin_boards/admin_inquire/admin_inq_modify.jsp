<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			function modify(f){
				
				let content = f.content.value;
				
				//유효성 검사
				if(content == ""){
					alert("내용을 입력하세요.");
					return;
				}
				
				let url="admin_inq_modify_fin.do"
			
				let param = 'c_idx=${a_vo.c_idx}&i_idx=${a_vo.i_idx}&content='+content;
				sendRequest(url, param, modifyFn, "POST");
			}
			
			//수정후
			function modifyFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					
					if(data == 'complete'){
						alert("수정됐습니다.");
						location.href="admin_inquire_view.do?i_idx=${vo.i_idx}";
					}else{
						alert("수정 실패했습니다.");
					}
				}
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
		<h1>1:1 문의</h1>
		<h5>문의 수정</h5>
	</div>
		
		<h3>문의글</h3>
			<table>
				<tr>
					<td>제목</td>
					<td>${ vo.title }</td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td>${ vo.content }</td>
				</tr>
				
				<tr>
					<td>종류</td>
					<td>${ vo.type }</td>
				</tr>
				
				<c:if test="${! vo.image eq 'no_file' }">
					<tr>
						<td>첨부파일</td>
						<td><img src="/store/resources/upload/${vo.image}" alt="첨부 이미지" width="100" height="90"></td>
               		</tr>
				</c:if>
				
			</table>
		<h3>답글 수정</h3>
		<form>
		<table border="1">
			<tr>
				<td  width="20%">내용</td>
				<td><textarea class="text" cols="40" rows="80" name="content" wrap="hard">${ a_vo.content }</textarea></td>
			</tr>
		</table>		


			<div class="btn_container">
				<input type="button" value="수정하기" onclick="modify(this.form);">
				<input type="button" value="취소하기" onclick="history.go(-1);">
			</div>
		</form>	
	</body>
</html>