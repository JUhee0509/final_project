<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>장바구니</title>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
		<style>
			#a{text-align: right;}
			#a1{text-align: left;}
			#a2{text-align: right;}
			#a3{text-align: left;}
			#a4{text-align: right;
				font-size: 15px;}	
			
			.row{padding: 5px;}
			
			.box{margin-top: 10px;
				 width: 900px;
				 margin: 0 auto;}
			
			.button{text-align: right;}
				
			#cart{width: 900px;
				  margin: 0 auto;}
			
			.cart_btn{background: #fff;
					  border: none;
					  font-size: 15px;}
			
			  
			/* 결제 버튼 */
			.btn{border: 2px solid #198754;
				 border-radius: 5px;
				 width: 300px;
				 height: 50px;
				 font-weight: bold;
				 font-size: 20px;}
				 
			.btn:hover{background: #198754;
						color: #fff;}
			
			/* 수량 버튼 */
			.counter-btn {
			    width: 30px;
			    height: 30px;
			    background-color: white;
			    color: #198754;
			    border: 1px solid #198754;
			    border-radius: 5px;
			    font-size: 20px;
			    cursor: pointer;
			    margin: 0 10px;
			    font-weight: bold;
			}
			
			/* 수량버튼 호버 */
			.counter-btn:hover {
			    background-color: #198754;
			    color: #fff;
			}
			
		</style>
		
		<script>
			//결제 창(주문서) 이동
			function send_pay(f) {
				
				f.action = "order_sheet.do";			
				f.submit();
			}
			
			//목록 삭제
			function cart_delete(c_idx) {
				if(!confirm("삭제하시겠습니까?")){
					return;
				}
				location.href = "cart_delete.do?c_idx=" + c_idx;
			}
			
			//수량 변경
			function amount_minus(p_idx) {
				
				
				var amountElement = document.getElementById("amount_" + p_idx);
	            var currentAmount = parseInt(amountElement.innerText);

	            // amount가 1보다 크거나 같은 경우에만 감소시킵니다.
	            if (currentAmount > 1) {
	                
	                location.href = "amount_minus.do?p_idx=" + p_idx;
	            } else {
	                alert("수량은 최소 1개입니다.");
	            }
			}
			
			function amount_plus(p_idx) {
				
				location.href = "amount_plus.do?p_idx=" + p_idx;

			}
			
			
			
		</script>
		
	</head>
	
	<body>
		<jsp:include page="<%= includePage %>"/>
		<br>
		<form class="box">
		<h1 align="center">장바구니</h1>
		
		<hr>
		
		<c:choose>
			<c:when test="${empty list }">
			<h2 align="center">장바구니가 비었습니다.</h2>
			</c:when>
		<c:otherwise>
		
		
		<div class="text-center" id="cart">
		
		<c:forEach var="vo" items="${list}">
				
			<div class="row">
				
				<input type="hidden" value="${vo.c_id}" name="c_id" id="c_id">
				<input type="hidden" value="${vo.p_idx}" name="p_idx" id="p_idx">
				<div class="col-3">
				<img src="/store/resources/upload/${vo.s_image}" width="120" height="110" onclick="location.href='PageProductList.do?p_idx=${vo.p_idx}'"> 
				</div>
				<div class="col-9" id="a3">
					<div class="row">
					
						<div class="col">${vo.brand }</div>
						<div class="col" id="a4">
						<button class="cart_btn" onclick="cart_delete(${vo.c_idx})">🗑️</button>
						</div>
					</div>
					<div class="row">
						<div class="col">${vo.p_name}</div>
						<div class="col" id="a4"><span style="text-decoration:line-through;">정가 <fmt:formatNumber value="${vo.price }" />원</span><span style="color: red;">(할인 : ${vo.p_rate }%)</span></div>
					</div>
					<div class="row">
						<div class="col">${vo.volume }ml</div>
						<div class="col" id="a4">판매가 <fmt:formatNumber value="${vo.sale_price }"/>원</div>
					</div>	
				</div>
						
						
			<div class="button">
						
				<div class="button_quantity">
				<button class="counter-btn" onclick="amount_minus(${vo.p_idx})">-</button>
				
					수량
				<span id="amount_${vo.p_idx}">${vo.amount}</span>

				
				<button class="counter-btn" onclick="amount_plus(${vo.p_idx})">+</button>
				</div>
				
				<hr>
			</div>
		</div>	
			</c:forEach>
						
		
					<br><br>
					
				
					<div class="row">
						<div class="col" id="a1">
							총 상품 가격
						</div>
						
						<div class="col" id="a2">
							<fmt:formatNumber value="${total_price }"/>원
						</div>
					</div>
		
				</div>
				<br>
		<div class="text-center" >
			
			<input class="btn" type="button" value="결제하기" onclick="send_pay(this.form)">
			
		</div>
		</c:otherwise>
		</c:choose>
		</form>
	<br><br>
	</body>
</html>