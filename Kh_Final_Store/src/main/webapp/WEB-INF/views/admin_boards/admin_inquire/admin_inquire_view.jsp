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
		
		<style>
      
    </style>
		
	</head>
		<body>
		<div class="fixed-header">
		<jsp:include page="<%= adminMenu %>"/>
	</div>
	
	 <div class="board_menu">
		<jsp:include page="<%= adminBoard %>"/>	
	</div>
			<!-- 문의 상세보기 -->
			<div class="text_container">
				<h1>나의 문의</h1>
				<h5>문의 내용</h5>
			</div>
				<table width="75%">
				
					
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
					
					<c:if test="${! vo.image eq 'no_file' }">
						<tr>
							<td>첨부파일</td>
							<td><img src="/store/resources/upload/${vo.image}" alt="첨부 이미지" width="100" height="90"></td>
                		</tr>
					</c:if>
					
					<tr>
						<td>상태</td>
						<td>${ vo.status }</td>
					</tr>
					<tr>
						<td>내용</td>
						<td><pre>${ vo.content }</pre></td>
					</tr>
					
				</table>	
				
			<form>
				<input type="hidden" value="${ vo.i_idx }" name="i_idx">
				
				<!-- if문으로 한정짓지 않아도 괜찮을듯??? -->
			<div class="table">
				<c:if test="${ !empty a_vo }">
					<h3>답변</h3>
					<table border="1">
						<tr>
							<td  width="20%">내용</td>
							<td>${ a_vo.content }</td>
						</tr>
						<tr>
							<td>작성일</td>
							<td>${ a_vo.regdate }</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td>관리자</td>
						</tr>
					</table>
				</c:if>
			</div>
					<div class="btn_container_bottom">
					    <input type="button" value="목록으로" onclick="history.go(-1);">
					    
					    <c:choose>
					        <c:when test="${ empty a_vo }">
					            <input type="button" value="답변하기" onclick="location.href='admin_inquire_write.do?i_idx=${vo.i_idx}'">
					        </c:when>
					        <c:otherwise>
					            <input type="button" value="답변수정" onclick="location.href='admin_inq_modify.do?i_idx=${vo.i_idx}'">
					        </c:otherwise>
					    </c:choose>
					    
					</div>
					
			</form>		
					
					<!-- 나중에 기능 삭제 : <input type="button" value='삭제' onclick="del();"> -->
				
		</body>
</html>
