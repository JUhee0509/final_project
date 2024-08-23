<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String includePage = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<% String searhpage = Common.Admin.VIEW_PATH + "admin_product_check.jsp"; %>
<% String checkpage = Common.Admin.VIEW_PATH + "admin_product_check_list.jsp"; %>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 상품 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
    <style>
        th, td {border: 1px solid #000;
            padding: 8px;
            text-align: center;}
        .fixed-header {top: 0;
			           height: 80px;
			           width: 1200px;
			           margin: 0 auto;}
			           
		.reg_btn{text-align: center;}
		
		
		#reg_btn{height: 40px;
				 width: 100px;
				 background: #fff;
				 border-radius: 5px;}
				 
		#reg_btn:hover{color: #fff;
					   background: #158492;}
				 
		button:hover{color: #fff;
					 background: #158492;}
		
		.head{background: #d3d3d3;}
		
		p {text-align: center;
		   color: red;
		   font-weight: bold;
		   font-size: 30px;}
    </style>
    
    <script>
    function modify_Product(p_idx) {
        event.stopPropagation();
        if (confirm('정말 수정하시겠습니까?')) {
            location.href = 'product_modify_form.do?p_idx=' + p_idx;
        }
    }

    function delete_Product(p_idx) {
        event.stopPropagation();
        if (confirm('정말 삭제하시겠습니까?')) {
            location.href = 'product_delete.do?p_idx=' + p_idx;
        }
    }
    </script>
</head>
<body>
    <div class="fixed-header">
        <jsp:include page="<%= includePage %>" />
    </div>
    <div class="data">
    <jsp:include page="<%= checkpage %>" />
    </div>
    <jsp:include page="<%= searhpage %>" />
    <br>
    <div class="reg_btn">
    <input type="button" id="reg_btn" value="제품등록" onclick="location.href='product_insert_form.do'">
    </div>
    <br>
    <c:choose>
        <c:when test="${empty list}">
            <p>상품이 등록되어 있지 않습니다.</p>
        </c:when>
        <c:otherwise>
	    <table border="1" align="center">
	            <tr class="head">
	                <th>브랜드</th>
	                <th>상품명</th>
	                <th>대표사진</th>
	                <th>용량(ML)</th>
	                <th>재고</th>
	                <th>판매상황</th>
	                <th>시중가</th>
	                <th>할인율</th>
	                <th>가격</th>
	                <th>성별</th>
	                <th>비고</th>
	            </tr>
	            <c:forEach var="vo" items="${list}">
	                <tr onclick="location.href='adminProductList.do?p_idx=${vo.p_idx}'">
	                    <td>${vo.brand}</td>
	                    <td>${vo.p_name}</td>
	                    <td><img src="/store/resources/upload/${vo.s_image}" width="100"></td>
	                    <td>${vo.volume}ml</td>
	                    <td>${vo.stock}개</td>
	                    <td>
	                        <c:choose>
	                            <c:when test="${vo.stock > 0}">
	                                판매중
	                            </c:when>
	                            <c:otherwise>
	                                판매완료
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	                    <td><fmt:formatNumber value="${vo.price}" type="number"/>원</td>
	                    <td>${vo.p_rate}%</td>
	                    <td><fmt:formatNumber value="${vo.sale_price}" type="number"/>원</td>
	                    <td>
	                    	<c:choose>
	                            <c:when test="${vo.gender == 'f'}">
	                                여성
	                            </c:when>
	                            <c:when test="${vo.gender == 'm'}">
	                                남성
	                            </c:when>
	                            <c:otherwise>
	                                기타
	                            </c:otherwise>
	                        </c:choose>
	                   </td>
	                    <td>
	                        <button type="button" onclick="modify_Product(${vo.p_idx}); event.stopPropagation();">수정</button>
	                        <button type="button" onclick="delete_Product(${vo.p_idx}); event.stopPropagation();">삭제</button>
	                    </td>
	                </tr>
	            </c:forEach>
	                   <tr>
							<td colspan="11" align="center">
								${ pageMenu }
							</td>
						</tr>
	    </table>
    </c:otherwise>
    </c:choose>
</body>
</html>
