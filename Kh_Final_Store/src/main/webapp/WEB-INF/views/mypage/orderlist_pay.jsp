<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주문 내역</title>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		
		<script>
			function fin() {
				location.href = "fin.do";
			}
			
			function ship() {
				location.href = "ship.do";
			}
			
			function ready() {
				location.href = "ready.do";
			}
			
			function refund() {
				location.href = "refund.do";
			}
	
			function del(o_idx) {
				if(!confirm("결제 취소 할까요?")){
					return;
				}
				location.href = "pay_del.do?o_idx="+o_idx;
			}
		</script>
		
		<style>
			.row{padding: 10px;}
			#header{width:900px; height: 400px;}
			.row #a1{text-align: left;}
			.row #a2{text-align: right;}
			
			.btn-group{width: 700px;}
			
			.btn{color: #000;
				background: #fff;
				border:2px solid #d3d3d3;
				}
			
			.bttn{width: 100px;
				  border: 1px solid #3d3d3d;
				  background: #fff;
				  border-radius: 5px;}
				  
			.bttn:hover{background: #3d3d3d;
						color: #fff;}
			.fixed-header {position: fixed;
			   			   top: 0;
			               left: 0;
			               width: 100%;
			               background-color: white;
			               z-index: 1000;
			               height: 80px;}
			 .pay{padding-top: 80px;}
		</style>
		
	</head>
	
	<body>
		<div class="fixed-header">
        	<jsp:include page="<%= includePage %>"/>
    	</div>
		<br>
		<h2 class="pay" align="center">주문 내역</h2><br>
		
	<div id="header" class="container text-center">
		<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
		  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked >
		  <label class="btn " for="btnradio1">입금/결제</label>
		
		  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" onclick="ready();">
		  <label class="btn " for="btnradio2">배송 준비중</label>
		
		  <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off" onclick="ship();">
		  <label class="btn " for="btnradio3">배송중</label>
		  
		  <input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off" onclick="fin();">
		  <label class="btn " for="btnradio4">배송 완료</label>
		  
		  <input type="radio" class="btn-check" name="btnradio" id="btnradio5" autocomplete="off"onclick="refund();">
		  <label class="btn " for="btnradio5">교환/환불</label>
		  
		</div>
		<hr>
	<c:forEach var="vo" items="${list }">
	<input type="hidden" value="${vo.o_idx }">
	<input type="hidden" value="${vo.p_idx }">
	<input type="hidden" value="${vo.status }">
		 <div class="row">
		    <div class="col" id="a1">
		      주문일 ${vo.paytime }
		    </div>
		    <div class="col" id="a2">
		      <a href="#">주문상세</a>
		    </div>
		  </div>
		  
		  <div class="row">
		    <div class="col-2" id="a1">
		     <img src="/store/resources/upload/${vo.s_image}" width="100" height="90">
		    </div>
		    <div class="col-md-auto" id="a1">
		      ${vo.brand } <br> ${vo.p_name }<br>${vo.volume }ml <%-- / 수량 ${vo.amount } --%>
		    </div>
		    <div class="col" id="a2">
		      <span style="text-decoration:line-through;">정가 <fmt:formatNumber value="${vo.price }" />원</span>
		      <br><span style="color:red;">(할인${vo.p_rate}%)</span><br>
		      판매가<fmt:formatNumber value="${vo.sale_price}"/>
		    </div>
		  </div>
		  
		  <div class="row">
		    <div class="col" id="a2">
		      <input type="button" class="bttn" value="결제취소" onclick="del(${vo.o_idx});">
		    </div>
		</div>
		  <hr>
	</c:forEach>
		
	</div>
	
	
	
	</body>
</html>