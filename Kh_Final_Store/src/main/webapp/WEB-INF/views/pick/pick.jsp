<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>찜한 상품</title>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		
		<script>
			function pick_to_delete(p_idx) {
				if(!confirm("삭제 하시겠습니까?")){
					return;
				}
				location.href="pick_to_delete.do?p_idx="+p_idx;
			}
			function pick_to_cart(p_idx) {
				
				alert("장바구니에 담겼습니다.");
				location.href="pick_to_cart.do?p_idx="+p_idx;
			}
		</script>
		
		<style>
			#box{width: 800px;
				 margin: 0 auto;}
				 
			#left{text-align: left;}
			#right{text-align: right;}
			
			.pick_btn{background: #fff;
					  width: 35px;
					  border:none;}
					  
			.cart_btn{width: 35px;
					  border:none;
					  background: #fff;}
			
			.row{padding: 5px;
				 cursor: pointer;}
			.fixed-header {position: fixed;
   			   top: 0;
               left: 0;
               width: 100%;
               background-color: white;
               z-index: 1000;
               height: 80px;}
               
            .title{padding-top: 80px;}
		</style>
		
	</head>
	
	<body>
	<div class="fixed-header">
		<jsp:include page="<%= includePage %>"/>
	</div>
	<br>
	<h1 class="title" align="center">찜 목록</h1><!-- fixed-header 분리를 위해 이름 지정하여 분리 했습니다 -->
	
	<div class="text-center" id="box">
	<hr>
	<c:choose>
		<c:when test="${ empty list }">
			<h3 align="center">카트가 비었습니다.</h3>
		</c:when>
		<c:otherwise>
			<c:forEach var="vo" items="${ list }">
			<div class="row" onclick="location.href='PageProductList.do?p_idx=${vo.p_idx}'">
				<div class="col-3">
					<br>
					<img src="/store/resources/upload/${vo.s_image}" width="120" height="110">
				</div>
				<div class="col-9">
					<div class="row">
						<div class="col" id="right">
						<button class="pick_btn" onclick="pick_to_delete(${vo.p_idx})">🗙</button>
						</div>
					</div>
					<div class="row">
						<div class="col" id="left">${ vo.brand }</div>
						<div class="col" id="right">
						<button class="cart_btn" onclick="pick_to_cart(${vo.p_idx})">🛒</button>
						</div>
					</div>
					<div class="row">
						<div class="col" id="left">${ vo.p_name }
						<br><div id="left">${vo.volume }ml</div>
						</div>
						
						<div class="col" id="right"><span style="text-decoration:line-through;">정가 <fmt:formatNumber value="${vo.price }" />원</span>
						<br><span style="color: red;">(할인 : ${vo.p_rate }%)</span></div>
					</div>
					<div class="row">
						
						<div class="col" id="right">판매가 <fmt:formatNumber value="${vo.sale_price }"/>원</div>
					</div>
				</div>
			
			</div>
			    <hr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</div>	
	</body>
</html>