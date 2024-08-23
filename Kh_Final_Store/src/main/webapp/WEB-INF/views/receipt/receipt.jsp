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
		<title>주문 완료 영수증</title>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		
		<style>
			.box{width: 900px;
				 margin: 0 auto;}
			
		
			
			#a1{text-align: left;
				font-weight: bold;
				font-size: 20px;}
			#a2{text-align: left;}
			
			#image{padding: 5px;}
			
			.btn{background: #fff;
				 color: #198754;
				 width:400px;
				 font-weight: bold;
				 font-size: 20px;
				 border: 2px solid #20c997;;
				 border-radius: 10px;
				 height: 50px;}
				 
			.btn:hover{border: 2px solid #3d3d3d;
					   background: #20c997;
					   color: #fff;}
			
		</style>
		
	</head>
	
	<body>
		<jsp:include page="<%= includePage %>"/>
		<br>
		<h1 align="center">주문이 완료 되었습니다.</h1>
		<br>
		<h2 align="center">영수증</h2>
		<br>
		
		<div class="text-center box">
			<div id="a1">
				주문 상품
			</div>
		<c:forEach var="vo" items="${list}">
			<div class="row">
				<div class="col" id="image">
					<img src="/store/resources/upload/${vo.s_image}" width="100" height="90">
				</div>
				<div class="col">
					<span style="font-weight: bold;">제품명</span><br>
					${vo.p_name }
				</div>
				<div class="col">
					<span style="font-weight: bold;">수량</span><br>${vo.amount }
					
				</div>
				<div class="col">
					<span style="font-weight: bold;">상품금액</span><br><fmt:formatNumber value="${vo.price * vo.amount }"/>원
				</div>
				<div class="col">
					<span style="font-weight: bold;">할인금액</span><br><fmt:formatNumber value="${(vo.price * vo.p_rate / 100) * vo.amount }"/>원
				</div>
				<div class="col">
					<span style="font-weight: bold;">결제금액</span><br>
					<fmt:formatNumber value="${vo.price*(100-vo.p_rate)/100 * vo.amount}"/>원
				</div>
			</div>
		</c:forEach>
			<hr>
			
			<div id="a1">
				결제 정보
			</div>
			
			<div class="row">
				<div class="col-2">
				총 상품 금액
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				<fmt:formatNumber value="${total_price }"/>원
				</div>
			</div>
			
			<div class="row">
				<div class="col-2">
				할인 금액
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				<fmt:formatNumber value="${total_sale_price}"/>원
				</div>
			</div>
			
			<div class="row">
				<div class="col-2">
				적립 예정 포인트
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				<fmt:formatNumber value="${(total_price - total_sale_price)*0.05 }"/>P
				</div>
			</div>
			
			<div class="row">
				<div class="col-2">
				총 결제 금액
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				<fmt:formatNumber value="${total_price - total_sale_price}"/>원
				</div>
			</div>
			
			<hr>
			
			<div id="a1">
				주문자 정보
			</div>
			
			<div class="row">
				<div class="col-2">
				이름
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				${vo.name }
				</div>
			</div>
			
			<div class="row">
				<div class="col-2">
				전화번호
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				${vo.tel }
				</div>
			</div>
			
			<div class="row">
				<div class="col-2">
				이메일
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				${vo.email }
				</div>
			</div>
			
			<hr>
			
			<div id="a1">
				배송지 정보
			</div>
			
			<div class="row">
				<div class="col-2">
				이름
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				${vo.name }
				</div>
			</div>
			
			<div class="row">
				<div class="col-2">
				전화번호
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				${vo.tel }
				</div>
			</div>
			
			<div class="row">
				<div class="col-2">
				주소
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				${addr}
				</div>
			</div>
			
			<div class="row">
				<div class="col-2">
				배송 요청 사항
				</div>
				<div class="col-1">
				:
				</div>
				<div class="col-9" id="a2">
				${select}
				</div>
			</div>
			<br>
			<div>
				<input type="button" class="btn" value="확인"
				 onclick="location.href='mainPage.do'">
			</div>
			
			<br><br><br>
			
		</div>
	</body>
</html>