<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String check_login = Common.index.VIEW_PATH + "login.jsp"; %>
<% String board = Common.Visit_board.VIEW_PATH + "board.jsp"; %>
<% String mainMenu = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Eclat de Luxe</title>
		<script src="/store/resources/js/httpRequest.js"></script>
		<link rel="stylesheet" href="/store/resources/css/board.css">
		
		<style>
      
    </style>
		
		<script>
			//삭제
			function del(){
				
				if( !confirm("삭제하시겠습니까?") ){
					return;
				}
				
				let url = "inq_del.do";
				let param = "i_idx=${vo.i_idx}";
				sendRequest(url, param, resultFn, "POST");
			}
			
			//삭제후
			function resultFn(){
				
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == 'complete'){
						alert("삭제 완료했습니다.");
						location.href="inquire.do";
					}else{
						alert("삭제 실패했습니다.");
					}
				}
				
			}
			
			//수정
			function modify(){
				
				let status = "${vo.status}";
				
				if(status===("답변전")){
					location.href="inq_modify.do?i_idx=${vo.i_idx}";
				}else{
					alert("문의가 "+status+"상태이므로 수정할 수 없습니다.");
				}
				
				//location.href='inq_modify.do?i_idx=${vo.i_idx}'
			}
			
			
		</script>
	</head>
		<body>
			<jsp:include page="<%= check_login %>"/><!-- 로그인여부 확인 -->
		<div class="fixed-header">
        	<jsp:include page="<%= mainMenu %>"/>
   	 	</div>
		<jsp:include page="<%= board %>"/>
			<!-- 문의 상세보기 -->
			<div class="text_container">
				<h1>나의 문의</h1>
				<h5>문의 내용</h5>
			</div>
			<form>
			<div class="btn_container_top">
					<input type="button" value="수정" onclick="modify();"></div>
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
				<input type="hidden" value="${ vo.i_idx }" name="i_idx">
				
			</form>
			
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
					<input type="button" value="목록으로" onclick="location.href='inquire.do?page=${param.page}'">
					<!-- 나중에 기능 삭제 : <input type="button" value='삭제' onclick="del();"> -->
				</div>
		</body>
</html>
