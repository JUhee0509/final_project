<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        
        <title>Insert title here</title>
        
        <style>
        	.btn:hover{color: #fff;
					   background: #158492;}
			
			.btn{background: #fff;
			 	 border: 1px solid #000;
			 	 margin-left: auto;}
			
			.search-container, .brand-container {
			    display: flex;
			    justify-content: space-between;
			    align-items: center;
			}
			
			.btn{margin-left: 10px;}
			
        </style>
        
        <script>
        function submit_param() {
            let f1 = document.getElementById("selected");
            f1.action = "product_check.do?optional=${param.optional}";
            f1.submit();
        }
        function brand_check() {
            let f1 = document.getElementById("selected");
            f1.action = "product_check.do?optional=${param.optional}";
            f1.submit();
        }
        </script>
    </head>
    
    <body>
        <form id="selected" action="product_check.do" method="get">
            <table border="1" align="center">
                <tr>
                    <th>제품명 검색</th>
                    <td>
                   		<div class="search-container">
			                <input placeholder="제품명을 입력해주세요" name="search" size="20">   
			                <input type="button" class="btn" value="검색" onclick="submit_param();">
			            </div>
                    </td>
                </tr>
                <tr>
                    <th>브랜드</th>
                    <td>
                    	<div class="brand-container">
			                <c:forEach var="vo" items="${ brand }">
			                    <label><input type="checkbox" name="brand" value="${ vo }"> ${ vo }</label>
			                </c:forEach>
			                <input type="button" class="btn" value="검색" onclick="brand_check();">
			            </div>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
