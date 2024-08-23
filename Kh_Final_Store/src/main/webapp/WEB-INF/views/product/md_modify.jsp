<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String includePage = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<%@ page import="common.Common" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
		<script>
			/* 상품 데이터 확인 */
			function validateProductNumber() {
				var enteredProductNumber = document.querySelector('input[name="p_idx"]').value;
				var productNumbers = Array.from(document.querySelectorAll('.product .row .col-3'))
					.map(td => td.textContent.trim());

				if (productNumbers.includes(enteredProductNumber)) {
					document.forms[0].action = "md_modify.do";
					document.forms[0].method = "post";
					document.forms[0].submit();
				} else {
					alert("해당 상품은 없습니다.");
				}
			}
		</script>
		
		<style>
			.box { width: 500px; margin: 0 auto; }	
			.bttn { background: #fff; border-radius: 5px; border-color: #d3d3d3; }
			.bttn:hover { background: #158492; color: #fff; }	
			.row { padding: 5px; }
			#title { border: 1px solid #3d3d3d; background: #d3d3d3; }
			#r { border-right: 1px solid #3d3d3d; }
		</style>
	</head>
	<body>
		<div class="fixed-header">
	        <jsp:include page="<%= includePage %>"/>
	    </div>
		<h1 align="center">MD상품 수정</h1>
		<br>
		<div class="box text-center">
			<div>
				<form method="post" enctype="multipart/form-data">
					<input type="hidden" name="idx" value="${vo.idx}">	
					<div>
						<div class="row">
							<div class="col-3">상품번호</div>
							<div class="col-6">
								<input name="p_idx" value="${vo.p_idx}">
							</div>
							<div class="col-3">
								<input type="button" class="bttn" value="수정하기" onclick="validateProductNumber();">
							</div>
						</div>
					</div>
					<br>
				</form>
			</div>
			<br>
			<div class="product">
				<div class="row" id="title">
					<div class="col-3" id="r">상품번호</div>	
					<div class="col-6" id="r">상품명</div>
					<div class="col-3">대표사진</div>
				</div>
				<c:forEach var="vo" items="${list}">
					<div class="row">
						<div class="col-3">${vo.p_idx}</div>
						<div class="col-6">${vo.p_name}</div>
						<div class="col-3"><img src="/store/resources/upload/${vo.s_image}" width="100"></div>	
					</div>
				</c:forEach>
				${ pageMenu }
				<br>
				<input type="button" class="bttn" value="뒤로가기" onclick="location.href='product_md_check.do';">
			</div>
		</div>
	</body>
</html>
