<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "admin_index.jsp"; %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주문 관리</title>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
		<style>
			.fixed-header {top: 0;
			           height: 80px;
			           width: 100%;
			           margin: 0 auto;}
		
			.box{width: 1500px;
				 margin: 0 auto;}
			
			a{text-decoration: none;
			  color: #000;}
			
			.a{padding: 5px;
			   background: #DCDCDC;}
			
			.aa{padding: 2px;}
			 
			.row{border: 1px solid #3d3d3d;}
			
			h3{font-weight: bold;
			   margin-left: 10%;}
			
			#table{border-right: 1px solid #3d3d3d;}
			
			#pro-table{border-right: 1px solid #3d3d3d;}
		</style>
		
		<script>
			function order_modify(p_idx) {
				location.href="order_modify.do?p_idx="+p_idx;
			}
		</script>
		
	</head>
	
	<body>
		<div class="fixed-header">
        <jsp:include page="<%= includePage %>"/>
   		 </div>
		<br>
		<h3>주문 관리</h3>
		<div class="text-center box">
			<div class="row">
				<div class="col-1 a" id="table"> 
				주문번호
				</div>
				<div class="col-2 a" id="table">
				주문일
				</div>
				<div class="col-1 a" id="table">
				주문자
				</div>
				<div class="col-4 a" id="table">
				주문상품
				</div>
				<div class="col-1 a" id="table">
				상품가격
				</div>
				<div class="col-1 a" id="table">
				전체가격
				</div>
				<div class="col-1 a" id="table">
				주문상태
				</div>
				<div class="col-1 a">
				비고
				</div>
				<!-- <div class="col">
				결제방법
				</div> -->
			</div>
			<c:forEach var="vo" items="${list}">
				<%-- ${vo.paytime}
				${vo.o_idx}
				${vo.c_id}
				${vo.status}
				${vo.amount}
				${vo.price}
				${vo.brand}
				${vo.p_name}
				${vo.volume} --%>
				<%-- ${total_price} --%>
				<%-- ${vo.pay_method} --%>
			<div class="row">
				<div class="col-1 aa" id="pro-table">
				${vo.o_idx}
				</div>
				<div class="col-2 aa" id="pro-table">
				${vo.paytime}
				</div>
				<div class="col-1 aa" id="pro-table">
				${vo.c_id}
				</div>
				<div class="col-4 aa" id="pro-table">
				<a href="#">
				<input type="hidden" value="${vo.p_idx}" name="p_idx">
				[${vo.brand}]${vo.p_name}/${vo.volume}ml
				</a>
				</div>
				<div class="col-1 aa" id="pro-table">
				<fmt:formatNumber value="${vo.price}"/> 
				</div>
				<div class="col-1 aa" id="pro-table">
				전체가격
				</div>
				<div class="col-1 aa" id="pro-table">
				${vo.status}
				</div>
				<div class="col-1 aa">
				
				<div class="dropdown">
				  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
				    변경
				  </button>
				  <ul class="dropdown-menu">
				    <li><a class="dropdown-item" href="order_ready.do?o_idx=${vo.o_idx}">배송준비중</a></li>
				    <li><a class="dropdown-item" href="order_shipping.do?o_idx=${vo.o_idx}">배송중</a></li>
				    <li><a class="dropdown-item" href="order_complete.do?o_idx=${vo.o_idx}">배송완료</a></li>
				    <li><a class="dropdown-item" href="order_exchange.do?o_idx=${vo.o_idx}">교환</a></li>
				    <li><a class="dropdown-item" href="order_refund.do?o_idx=${vo.o_idx}">환불</a></li>
				    <li><a class="dropdown-item" href="order_cancel.do?o_idx=${vo.o_idx}">취소</a></li>
				  </ul>
				</div>
				</div>
				<!-- <div class="col">
				결제방법
				</div> -->
				
			</div>
			</c:forEach>
		</div>
			<br>
		
	</body>
</html>