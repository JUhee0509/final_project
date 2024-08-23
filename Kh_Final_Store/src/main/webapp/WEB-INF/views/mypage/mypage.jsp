<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@page import="common.Common"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>마이 페이지</title>
		
		<script>
			//회원정보 수정 폼 이동
			function modify_form() {
				location.href = "modify_form.do"
			}
		
			function fin() {
				location.href = "fin.do";
			}
			
			function detail(){
				location.href = "detail.do";
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
			
			function addr_del(f) {
				if(!confirm("삭제하시겠습니까?")){
					return;
				}
				f.action = "addr_del.do";
				f.submit();
			}

			function review_move(f) {
				f.action = "review_move.do";
				f.submit();
			}
			
			function require_move() {
				location.href = "require_move.do";
			}
		</script>
		
		
		
		<style>
			.row .btn:hover{color:  #198754;
							 border-radius: 10px;
							 border: 1px solid #D3D3D3;}
			.order_btn:hover{color: #198754;}
			
			.order_btn{
			  border: 0;
			  background-color: transparent;
			}
			
			#title{font-weight: bold;
					font-size: 35px;}
			
			#header{width:800px; height: 400px;}
			.row{padding: 10px;}
			.row #a2{text-align: left;
					 font-weight: bold;}
			.row #a3{font-weight: bold;}
			.row #a1{text-align: right;} 
			.row .btn{color:#808080;
					 border-radius: 10px;
					 border: 2px solid #198754;
					 
					 color:  #198754;}
			
			.order_btn{border: 1px solid #d3d3d3;
				   border-radius: 10px;
				   width: 130px;}
			
			.select{padding: 10px;
		            font-size: 16px;
		            border: 1px solid #ccc;
		            border-radius: 4px;
		            background-color: #fff;
		            color: #333;
		            appearance: none; /* 기본 브라우저 스타일 제거 */
		            -webkit-appearance: none;
		            -moz-appearance: none;
       		 }
			.fixed-header {position: fixed;
   			   top: 0;
               left: 0;
               width: 100%;
               background-color: white;
               z-index: 1000;
               height: 80px;}
            #title{padding-top: 80px;}
		</style>
		<!-- 부트스트랩 연결 링크 -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		
	</head>
	
	<body>
		<div class="fixed-header">
			<jsp:include page="<%= includePage %>"/>
		</div>
		<br>
	
		<div id="title" align="center">마이 페이지</div>
	
		<br>
		<div class="container text-center" id="header">
		
		 <div class="row">
		 	<div class="col" id="a2">
		      이름
		    </div>
		    <div class="col">
		     ${vo.name }
		    </div>
		    <div class="col" id="a3">
		      적립금
		    </div>
		    <div class="col">
		     <fmt:formatNumber value="${vo.bonus_point}"/> 점
		    </div>
		  </div>
		<hr>
		
		<div class="row">
		    <div class="col" id="a2">
		      로그인 정보
		    </div>
		    <div class="col" id="a1">
		      <input type="button" value="수정" class="btn" onclick="modify_form();">
		    </div>
		</div>
		<hr>
		  <div class="row">
		    <div class="col" id="a2">
		      주문 내역
		    </div>
		    <div class="col" id="a1">
		     <input type="button" value="상세보기" class="btn" onclick="detail();">
		    </div>
		  </div>
		
		  <div class="row">
		    <div class="col">
		     <input type="button" class="order_btn" value="입금/결제" class="order_btn" onclick="detail();">
		    </div>
		    <div class="col">
		      <input type="button" class="order_btn" value="배송 준비중" class="order_btn" onclick="ready();">
		    </div>
		    <div class="col">
		      <input type="button" class="order_btn" value="배송중" class="order_btn" onclick="ship();">
		    </div>
		     <div class="col">
		      <input type="button" class="order_btn" value="배송 완료" class="order_btn" onclick="fin();">
		    </div>
		     <div class="col">
		      <input type="button" class="order_btn" value="교환/환불" class="order_btn" onclick="refund();">
		    </div>
		  
		</div>
		<hr>  
		<form>
		<div class="row">
		    <div class="col" id="a2">
		      배송지 관리
		    </div>
		
		    <div class="col-md-auto">
		    <c:choose>
		      	<c:when test="${empty list }">
		      	주소를 등록해주세요.
		      	</c:when>
				<c:otherwise>
		      <select name="idx" class="select">
		      	
				<c:forEach var="vo" items="${list}">
				     <option value="${vo.idx}" >${vo.addr}</option>
				</c:forEach>
				</select>
				</c:otherwise>
				</c:choose>
		      
		    </div>
		
		    <div class="col"id="a1">
		      <input type="button" value="추가" class="btn"
		      onclick="window.open('addr_add.do','new','scrollbars=yes,resizable=no width=400 height=300 left=700 top=250');return false();">
		      <input type="button" value="삭제" class="btn"
		      onclick="addr_del(this.form)">
		    </div>
		</div>
		</form>
		 
		 <hr>
		 <form>
		<div class="row">
		    <div class="col" id="a2">
		      내 리뷰
		    </div>
		    <div class="col" id="a1">
		    	<input type="hidden" value="${c_id}" name="c_id">
		      <input type="button" value="이동" class="btn" onclick="review_move(this.form);">
		    </div>
		</div>
		</form>
		<hr>
		
		<div class="row">
		    <div class="col" id="a2">
		      내 문의
		    </div>
		    <div class="col" id="a1">
		      <input type="button" value="이동" class="btn" onclick="require_move();">
		    </div>
		</div>
		
		
		</div>
		
	</body>
</html>