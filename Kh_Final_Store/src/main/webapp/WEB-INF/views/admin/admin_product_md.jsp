<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<% String checkpage = Common.Admin.VIEW_PATH + "admin_product_check_list.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
		<script>
	    function modify_MD(p_idx) {
	        event.stopPropagation();
	        if (confirm('수정하시겠습니까?')) {
	            location.href = 'md_modify_form.do?p_idx=' + p_idx;
	        }
	    }
	
	    function delete_MD(p_idx) {
	        event.stopPropagation();
	        if (confirm('정말 삭제하시겠습니까?')) {
	            location.href = 'MD_delete.do?p_idx=' + p_idx;
	        }
	    }
	    </script>
	    <style>
		.fixed-header {top: 0;
			           height: 80px;
			           width: 1200px;
			           margin: 0 auto;}
		
		
		th, td {border: 1px solid #000;
            padding: 8px;
            text-align: center;}
		
		.head{background: #d3d3d3;}
		
		button:hover{color: #fff;
					 background: #158492;}
		
		.reg_btn{text-align: center;}
		
		
		#reg_btn{height: 40px;
				 width: 100px;
				 background: #fff;
				 border-radius: 5px;}
		
		#reg_btn:hover{color: #fff;
					   background: #158492;}
		p {text-align: center;
		   color: red;
		   font-weight: bold;
		   font-size: 30px;}
		</style>
	</head>
	<body>
		<div class="fixed-header">
	        <jsp:include page="<%= includePage %>" />
	    </div>
	    <div class="data">
	    <jsp:include page="<%= checkpage %>" />
	    </div>
	    <br>
	    <div class="reg_btn">
	    <input type="button" id="reg_btn" value="md추가" onclick="location.href='md_insert_form.do'">
	    </div>
	    <br>
	    <c:choose>
        <c:when test="${empty list}">
            <p>상품이 등록되어 있지 않습니다.</p>
        </c:when>
        <c:otherwise>
		    <table border="1" align="center">
		    <tr class="head">
	                <th>상품번호</th>
	                <th>대표사진</th>
	                <th>상품명</th>
	                <th>브랜드</th>
	                <th>비고</th>
	               
	            </tr>
		    <c:forEach var="vo" items="${list}">
	                <tr>
	                    <td>${vo.p_idx}</td>
	                    <td><img src="/store/resources/upload/${vo.s_image}" width="100"></td>
	                    <td>${vo.p_name}</td>
	                    <td>${vo.brand}</td>
	                    <td>
	                        <button type="button" onclick="modify_MD(${vo.p_idx}); event.stopPropagation();">수정</button>
	                        <button type="button" onclick="delete_MD(${vo.p_idx}); event.stopPropagation();">삭제</button>
	                    </td>
	                </tr>
	            </c:forEach>
		    </table>
	    </c:otherwise>
    </c:choose>
	</body>
</html>