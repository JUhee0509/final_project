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
		<title>주문서</title>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
		<style>
			#cart{width: 900px;
				  margin: 0 auto;}	  
			#a1{text-align: left;
				font-weight: bold;}
			#a2{text-align: right;}  
			#a4{text-align: right;
				font-size: 15px;}
			
			.row{padding: 5px;}
			
			/* 모든 선택지 */
			.select{padding: 10px;
		            font-size: 16px;
		            border: 1px solid #198754;
		            border-radius: 4px;
		            background-color: #fff;
		            color: #333;
		            appearance: none; /* 기본 브라우저 스타일 제거 */
		            -webkit-appearance: none;
		            -moz-appearance: none;
       		 }
       		 
       		/* 결제 선택지 버튼 */
       		.btn{color: #000;
				 background: #fff;
				 border:2px solid #d3d3d3;
				 }
			
			/* 선택시 */
			.btn-check:checked + .btn{background: #198754;
									  color: #fff;}
			
			/* 마우스 */
			.btn-check:hover + .btn{background:#198754;
									color: #fff;}
			
			/* 주소 등록 버튼 */
			.addr_btn{background: #fff;
					  border-radius: 5px;
					  border: 2px solid #d3d3d3;}
								
			.addr_btn:hover{color: #fff;
							background: #d3d3d3;}
							
			/* 결제 버튼 */
			.pay_btn{width:400px;
					 font-weight: bold;
					 font-size: 20px;
					 border: 2px solid #20c997;;
					 border-radius: 10px;
					 height: 50px;
					 background: #fff;
					 color: #198754;}
			
			
			
		</style>
		
		<script>
			function send(f) {
				let pay = f.btnradio.value;
				if(pay == ''){
					alert("결제 방법을 선택해 주세요.");
					return;
				}
				f.action = "pay_complete.do";	
				f.submit();
			}
		</script>
		
	</head>
	
	<body>
		<jsp:include page="<%= includePage %>"/>
		<br>
		<h1 align="center">주 문 서</h1>
		<form>
		<div class="text-center" id="cart">
		<c:forEach var="vo" items="${list}">
				
		<div class="row">
			<div class="col-3">
			<input type="hidden" value="${vo.p_idx}" name="p_idx">
			<input type="hidden" value="${vo.c_idx}" name="c_idx">
			<input type="hidden" value="${vo.c_id}" name="c_id">
			
			
			<img src="/store/resources/upload/${vo.s_image}" width="100" height="90">
			</div>
			<div class="col-9" id="a1">
				<div>${vo.brand }</div>
				<div class="row">
					<div class="col">${vo.p_name}</div>
					<div class="col" id="a4"><span style="text-decoration:line-through;">정가 <fmt:formatNumber value="${vo.price }" />원</span>(<span style="color: red;">할인 : ${vo.p_rate}%</span>)</div>
				</div>
				<div class="row">
					<div class="col">${vo.volume }ml</div>
					<div class="col" id="a4">판매가 <span style="font-weight: bold;"><fmt:formatNumber value="${vo.sale_price }"/></span>원</div>
				</div>	
			</div>
			<div  id="a2">		
			<div>수량 <span style="font-weight: bold;">${vo.amount }</span></div>
			</div>
			<br><br>
			<hr>		
		</div>	
		</c:forEach>
		
		
		<div class="row">
			<div class="col" id="a1">
			배송지
			</div>
						
			<div class="col" id="a2">
			<c:choose>
		      	<c:when test="${empty addr }">
		      	주소를 등록해주세요.
		      	</c:when>
				<c:otherwise>
		      <select name="addr" class="select">
		      	
				<c:forEach var="vo" items="${addr}">
				     <option >${vo.addr}</option>
				</c:forEach>
				</select>
				</c:otherwise>
				</c:choose>
			
			 
			<input type="button" value="추가" class="addr_btn"
		      onclick="window.open('addr_add.do','new','scrollbars=yes,resizable=no width=400 height=300 left=700 top=250');return false();">
	
			</div>
		</div>
		
		<hr>
		
		<div class="row">
			<div class="col" id="a1">
			배송 요청 사항
			</div>
						
			<div class="col" id="a2">
			<select name="select" class="select">
				<%-- <option value="${vo.request}">${vo.request }</option> --%>
				<option value="배송 요청 사항 선택">배송 요청 사항 선택</option>
				<option value="배송 전 연락바랍니다.">배송 전 연락바랍니다.</option>
				<option value="부재시 연락바랍니다.">부재시 연락바랍니다.</option>
				<option value="경비실에 맡겨주세요.">경비실에 맡겨주세요.</option>
				<option value="문 앞에 놔주세요.">문 앞에 놔주세요.</option>
				<option value="직접 수령 할게요.">직접 수령 할게요.</option>
				<option value="직접 입력">직접 입력</option>
			</select>
			</div>
		</div>
		
		<hr>
		
		<div class="row">
			<div class="col-3" id="a1">
			결제 수단
			</div>
			
			
			<div class="btn-group col-9" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" value="신용카드" name="btnradio" id="btnradio1" autocomplete="off">
			  <label class="btn " for="btnradio1">신용카드</label>
			
			  <input type="radio" class="btn-check" value="간편결제" name="btnradio" id="btnradio2" autocomplete="off">
			  <label class="btn " for="btnradio2">간편 결제</label>
			
			  <input type="radio" class="btn-check" value="무통장" name="btnradio" id="btnradio3" autocomplete="off">
			  <label class="btn " for="btnradio3">무통장 입금</label>
		  
			</div>
		</div>
		
		<hr>
		<div id="a1">
			결제 금액
		</div>
		<div class="row">
			<div class="col-3">
			총 상품 가격
			</div>		
			<div class="col-9" id="a2">
				<fmt:formatNumber value="${total_price }"/>원
			</div>
			<div class="col-3">
			적립금 할인 금액
			</div>		
			<div class="col-9" id="a2">
				<!-- <input placeholder="정수 입력" name="bonus_point"> -->
				<fmt:formatNumber value="${bonus_point}"/>P
			</div>
		</div>
		<hr>
				
		<div class="row">
			<div class="col" id="a1">
			결제 가격
			</div>
						
			<div class="col" id="a2">
				<fmt:formatNumber value="${pay_price}"/>원
			</div>
		</div>
		<hr>
		
		<div class="text-center">
			<input type="hidden" value="${o_idx }" name="o_idx">
			
			<input class="pay_btn" type="button" value="결제하기" onclick="send(this.form)">
			
		</div>
		
		<br><br><br>
		</div>
		</form>
	
	
		
	
	</body>
</html>