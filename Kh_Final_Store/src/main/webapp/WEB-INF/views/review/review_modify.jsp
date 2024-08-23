<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내 리뷰 수정</title>
		<script src="/store/resources/js/httpRequest.js"></script>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		
		<style>
			.a1{width: 500px;
				border-bottom: 2px solid #000;
				border-top: 2px solid #000}
			
			#a3{font-weight: bold;
				font-size: 20px;}
			
			input:hover{color: #fff; background: #000}
			
			.a2{padding: 10px;
				text-align: right;
				
				}
			
			.btn{background: #fff;
				 border: 1px solid #3d3d3d;
				 width: 70px;}
			
			.btn:hover{background: #3d3d3d;
					   color: #fff;}	
			
			li{margin: 10px 0;
			   padding: 10px;}
			
			form{
			      display: flex;
			      justify-content: center;
			      align-items: flex-start;
			      height: 100vh; /* 뷰포트의 전체 높이를 차지하도록 설정 */
			      margin: 0;
			    }
		</style>
			
		<script>
			function modify_review(f) {
				let rs = f.reviewscore.value;
				if(rs < 0 || rs >5){
					alert("0점부터 5점까지 가능합니다");
					return;
				}
				f.action="review_modify.do";
				f.submit();
				
			}
			
		</script>
			
	</head>
	<body>
	<jsp:include page="<%= includePage %>"/>
	<br>
	<h1 align="center">리뷰 수정하기</h1>
	<br>
	<form>
		<input type="hidden" name="r_idx" value="${ vo.r_idx }">
		<div class="a1">
			<ul>
				<li>
				<div class="row">
					<div class="col" id="a3">
					제품명 / 용량 
					</div>
					
					<div class="col">
					${vo.p_name } / ${vo.volume }ml
					</div>
				</div>	
				</li>
				
				<li>
				<div class="row">
					<div class="col" id="a3">
					평점(0~5점)
					</div>
					
					<div class="col">
					<input size="2" name="reviewscore" value="${vo.reviewscore }"> 점
					</div>
				</div>
				</li>
				
				<li>
				<div id="a3">
					사진 등록
				</div>
				<div>
					<input type="file" value="${vo.image}" name="image">
				</div>
				</li>
				
				<li>
				  <div id="a3">구매 후기</div>
				  <br>
 				  <textarea name="content" cols="50" rows="5" style="resize: none;">${vo.content }</textarea>
				</li>
				
			</ul>
			
			<div class="a2">
				<input type="button" class="btn" value="확인" onclick="modify_review(this.form)">
			</div>
		</div>
		</form>
	</body>
</html>