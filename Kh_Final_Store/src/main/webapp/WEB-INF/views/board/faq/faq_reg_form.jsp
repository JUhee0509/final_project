<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>새 글 작성</title>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		
		<script>
			function send(f) {
				f.action = "faq_insert.do";
				f.submit();
			}
		</script>
	
		<style>
			.box{margin: 0 auto;
				 width: 700px;}	
			
			.row{padding: 15px;}
			
			.row #btn{text-align: right;}
			.fixed-header {position: fixed;
			   			   top: 0;
			               left: 0;
			               width: 100%;
			               background-color: white;
			               z-index: 1000;
			               height: 80px;}
			.data{padding-top: 80px;}
		</style>
		
	</head>
	
	<body>
		<div class="fixed-header">
        	<jsp:include page="<%= includePage %>"/>
    	</div>
		<br>
		<h1 class="data" align="center">새 글 작성</h1>
		
		<form class="box">
			<div>
				<input type="hidden" value="${a_id}" name="a_id">
			</div>
			<div class="row">
				<div class="col-2">
					질문
				</div>
				<div class="col-10">
					<input name="question" size="45">
				</div>
			</div>
			
			<div class="row">
				<div class="col-2">
					답변
				</div>
				<div class="col-10">
					<textarea name="answer" rows="5" cols="50"></textarea>
				</div>
			</div>
			
			<div class="row">
				
				<div class="col" id="btn">
				<input type="button" value="등록" onclick="send(this.form)">
				</div>
			</div>
		</form>
		
	</body>
</html>