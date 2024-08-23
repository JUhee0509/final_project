<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.Common"%>
<% String mainMenu = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
		
		<style>
			.box{width: 1300px;
				 margin: 0 auto;}
			
			
			.btn{text-align: right;}
		
			h2{font-weight: bold;
			   margin-left: 10%;}
			
			.a{padding: 5px;
			   background: #DCDCDC;
			   border-right: 1px solid #3d3d3d;}
			
			.aa{padding: 2px;
				border-right: 1px solid #3d3d3d;}
			
			.row{border: 1px solid #3d3d3d;}
			
			.content{text-align: center;}
			
			.wrapper{max-width: 1200px;}
		</style>
		
		<script>
			function del(r_idx) {
				if(!confirm("정말 삭제 하시겠습니까?")){
					return;
				}
				location.href="review_delete.do?r_idx="+r_idx;
			}
		</script>
		
	</head>
	
	<body>
	
		<div class="fixed-header">
	        <jsp:include page="<%= mainMenu %>"/>
	   	</div>
	   	<br>
	 <div class="box">
	   	<div class="text_container">
			<h2>리뷰 관리</h2>
		</div>
		<br>
		<div class="review">
			<div class="row">
				<div class="col-1 a">번호</div>
				<div class="col-1 a">아이디</div>
				<div class="col-1 a">제품번호</div>
				<div class="col-2 a">사진</div> 
				<div class="col-1 a">평점</div> 
				<div class="col-3 a">후기</div>
				<div class="col-2 a">등록일</div>
				<div class="col-1 a">비고</div>
			</div>
			
			<c:forEach var="vo" items="${list}">
			<div class="row text-center">
				<div class="col-1 aa">${vo.r_idx}</div>
				<div class="col-1 aa">${vo.c_id}</div>
				<div class="col-1 aa">${vo.p_idx}</div>
				<div class="col-2 aa text-break">
				<img src="/store/resources/upload/${vo.image}" width="50">
				</div> 
				<div class="col-1 aa">${vo.reviewscore}</div> 
				<div class="col-3 aa">${vo.content}</div>
				<div class="col-2 aa">${vo.regdate}</div>
				<div class="col-1 aa">
				<input type="button" value="삭제" onclick="del(${vo.r_idx})">
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
	</body>
</html>