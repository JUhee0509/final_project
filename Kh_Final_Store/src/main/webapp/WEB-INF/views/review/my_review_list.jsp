<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내 리뷰</title>
		
		<script src="/store/resources/js/httpRequest.js"></script>
		
		
		<script>
			function review_modify(f) {
				f.action = "review_modify_form.do";
				f.submit();
			}
			
			function review_del(f) {
				if(!confirm("삭제하시겠습니까?")){
					return;
				}
				
				f.action = "review_del.do";
				f.submit();
			
			}
		</script>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		
		
		<style>
			.box{margin:0 auto;
				 width: 700px;}
			
			#left{text-align: left;}
			
			#right{text-align: right;}
			
			.btn{border: none;
				 background: #fff;
				 font-size: 20px;}
			.fixed-header {position: fixed;
						   top: 0;
						   left: 0;
						   width: 100%;
						   background-color: white;
						   z-index: 1000;
						   height: 80px;}
			.review_title{padding-top: 80px;}
		</style>
		
	</head>
	
	<body>
		<div class="fixed-header">
        	<jsp:include page="<%= includePage %>"/>
    	</div>
		
		<h1 class="review_title" align="center">내 리뷰</h1> <!-- css 지정을 위한 이름 지정 -->
		
		<c:forEach var="vo" items="${list}">
		<div class="box">
			<form>
			<div class="row">
			<div class="col" id="left">${vo.p_name } / ${vo.volume }ml<br>
			<c:forEach begin="1" end="5" var="i">
				<c:choose>
					<c:when test="${i <= vo.reviewscore}">
						★
					</c:when>
					<c:otherwise>
						☆
					</c:otherwise>
				</c:choose>
			</c:forEach> </div>
			
			<div class="col" id="right">
			<button class="btn" onclick="review_modify(this.form)" title="수정하기">📝</button>
			
			<button class="btn" onclick="review_del(this.form)" title="삭제하기">🗑️</button>
			</div>
			</div>
			
			<input type="hidden" value="${vo.c_id}">
			<input type="hidden" value="${vo.p_idx}">
			
			
			
			<c:if test="${vo.image ne 'no_file' }">
						<img src="/store/resources/upload/${vo.image}" width="100" height="90">
			</c:if>
			
			<div>${vo.content }</div>
			
			<div>작성일 : ${vo.regdate }</div>
			
			
			
			<input type="hidden" value="${vo.r_idx }" name="r_idx">
			
			</form>
			
			<hr>
		</div>
		</c:forEach>
	</body>
</html>