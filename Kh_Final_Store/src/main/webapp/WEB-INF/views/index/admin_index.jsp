<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String check_login = Common.index.VIEW_PATH + "login_admin.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>이동메뉴작업</title>
		<link href="resources/css/index.css" rel="stylesheet"/>
		<script>
			document.addEventListener("DOMContentLoaded", function() {
			    var header = document.querySelector("header");
			
			    window.addEventListener("scroll", function() {
			        if (window.scrollY > 0) {
			            header.classList.add("scrolled");
			        } else {
			            header.classList.remove("scrolled");
			        }
			    });
			});
		</script>
	</head>
	
	<body>
	<!-- 로그인 여부 확인 -->
	<jsp:include page="<%= check_login %>"/>
		<header>
			<nav class="sub_title2">
				<ul>
					<!-- !! --><li><a href="admin_modify_form.do"><관리자></a></li>
		        <!-- 로그인/아웃 수정했습니다. -->
		        <c:choose>
		        	<c:when test="${ empty admin }">
		        		<li><a href="login_form.do">Login</a></li>
		        	</c:when>
		        	<c:otherwise>
		        		<li><a href="admin_logout.do">Logout</a></li>
		        	</c:otherwise>
		        </c:choose>	
				</ul>
			</nav>
			<div class="wrapper">
				<h1 class="logo"><a href="admin_mainPage.do">Eclat de Luxe</a></h1>
				<nav class="sub_title">
					<ul>
				        <li><a href="customer_admin.do">고객</a></li>
				        <li><a href="product_check.do">제품</a></li>
				        <li><a href="order_manager.do">주문</a></li>
				        <li><a href="review_check.do">리뷰</a></li>
				        <li><a href="admin_board.do">게시판 관리</a></li>
				    </ul>
				</nav>
			</div>
		</header>
	</body>
</html>