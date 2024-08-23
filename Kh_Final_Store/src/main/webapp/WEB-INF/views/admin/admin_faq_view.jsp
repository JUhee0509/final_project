<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String mainMenu = Common.index.VIEW_PATH + "admin_index.jsp"; %>
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
		
		<style>
			form{width:80%;
				 margin: 0 auto;}
		</style>
		
	</head>
	
	<body>
		<div class="fixed-header">
	        <jsp:include page="<%= mainMenu %>"/>
	   	</div>
	   	
	   	<div class="text_container">
			<h1>자주 묻는 질문</h1>
		</div>
		<br><br>
	   	
	   	<form>
			
					
				<table>
				
					
					<tr>
						<td width="20%">질문${vo.idx}</td>
						<td>${ vo.question }</td>
					</tr>
					
					<tr>
						<td>작성자</td>
						<td>${ vo.a_id }</td>
					</tr>
					
					<tr>
						<td>작성일</td>
						<td>${ vo.regdate }</td>
					</tr>
				
					<tr>
						<td>답</td>
						<td><pre>${ vo.answer }</pre></td>
					</tr>
					
					
				</table>	
				
			</form>
	   	
	   	
	   	<div class="btn_container_bottom">
	   		<input type="hidden" value="${ vo.idx }" name="idx">
			<input type="button" value="수정" onclick="faq_modify(this.form)">
			<input type="button" value="삭제" onclick="faq_del(this.form)">
			<input type="button" value="목록으로" onclick="history.go(-1);">
			<!-- 나중에 기능 삭제 : <input type="button" value='삭제' onclick="del();"> -->
		</div>
	</body>
</html>