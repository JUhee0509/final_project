<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>리뷰 작성하기</title>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		
		<style>
			.a1{width: 500px;
				border-bottom: 2px solid #000;
				border-top: 2px solid #000}
				
			.btn{background: #fff;
				 border: 1px solid #3d3d3d;
				 width: 70px;}
			
			.btn:hover{background: #3d3d3d;
					   color: #fff;}
			
			.a2{padding: 10px;
				text-align: right;}
			
			li{margin: 10px 0;
			   padding: 10px;}
			
			form{
			      display: flex;
			      justify-content: center;
			      align-items: flex-start;
			      height: 100vh; /* 뷰포트의 전체 높이를 차지하도록 설정 */
			      margin: 0;
			    }
			
			#a3{font-weight: bold;
				font-size: 20px;}
		</style>
			
		<script>
			function send(f) {
				let rs = f.reviewscore.value;
				if(rs < 0 || rs > 5){
					alert("평점은 0~5점만 가능합니다.");
					return;
				}
				f.action = "review_insert.do";
				f.submit();
			}
		</script>
			
	</head>
	
	<body>
		<jsp:include page="<%= includePage %>"/>
		<br>
		
		<h1 align="center">리뷰 작성하기</h1>
		<br>
		<!-- 사진 -->
		<form method="post"
		      enctype="multipart/form-data">
		<div class="a1">
			<ul>
				<li>
				<input type="hidden" value="${c_id}" name="c_id">
				<div class="row">
					<div class="col" id="a3">
					제품번호
					</div>
					
					<div class="col" >
					${p_idx}
					<input type="hidden" name="p_idx" value="${p_idx}">
					</div>
				</div>	
				</li>
				
				<li>
				<div class="row">
					<div class="col" id="a3">
					평점(0~5점)
					</div>
					
					<div class="col">
					<input size="2" name="reviewscore">
					</div>
				</div>
				</li>
				
				<li>
				<div id="a3">
					사진 등록
				</div>
				<div>
					<input type="file" name="photo">
				</div>
				</li>
				
				<li>
				  <div id="a3">구매 후기</div>
				  <br>
 				  <textarea name="content" cols="50" rows="5" style="resize: none;"></textarea>
				</li>
				
			</ul>
			
			<div class="a2">
				<input type="button" class="btn" value="확인" onclick="send(this.form);">
			</div>
			<br>
		</div>
		</form>
	</body>
</html>