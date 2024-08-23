<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<header>
			<nav class="sub_title2">
				<ul>
					<li><label><a href="notice.do">고객센터</a></label></li>
		        <c:choose>
		        	<c:when test="${ empty user }">
		        		<li><a href="login_form.do">Login</a></li>
		        	</c:when>
		        	<c:otherwise>
		        		<li><a href="logout.do">Logout</a></li>
		        	</c:otherwise>
		        </c:choose>	
				</ul>
			</nav>
			<div class="wrapper">
				<h1 class="logo"><a href="mainPage.do">Eclat de Luxe</a></h1>
				<nav class="sub_title">
					<ul>
				        <li><a href="shop_list.do">SHOP</a></li>
				        <li><a href="pick.do">PICK</a></li>
				        <li><a href="cart_list.do">CART</a></li>
				        <li><a href="mylist.do">MY</a></li>
				    </ul>
				</nav>
			</div>
		</header>
	</body>
</html>