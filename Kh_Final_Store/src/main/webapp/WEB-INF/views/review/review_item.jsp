<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${vo.p_name}리뷰페이지</title>
    <link href="resources/css/review_item.css" rel="stylesheet"/>
    <script type="text/javascript">
        function maskString(str) {
            if (str.length <= 2) {
                return str;
            }
            var masked = str.charAt(0);
            for (var i = 1; i < str.length - 1; i++) {
                masked += '*';
            }
            masked += str.charAt(str.length - 1);
            return masked;
        }
    </script>
</head>
<body>
    <div class="fixed-header">
        <jsp:include page="<%= includePage %>"/>
    </div>
    <div class="reviews_total">
        <h1>리뷰 페이지</h1>
        <div class="item-container">
            <div class="item" onclick="location.href='PageProductList.do?p_idx=${vo.p_idx}'">
                <img src="/store/resources/upload/${vo.s_image}" class="item-image">
                <div class="item-details">
                    <div>${vo.p_name}</div>
                    <div>${vo.volume}ml</div>
                </div>
            </div>
        </div>
        <div class="reviews">
            <c:forEach var="list" items="${list}">
                <div class="review" onclick="location.href='review_detail.do?p_idx='+${ vo.p_idx }+'&r_idx='+${list.r_idx}">
                    <div class="review-image">
                        <c:if test="${not empty list.image}">
                            <img src="/store/resources/upload/${list.image}">
                        </c:if>
                    </div>
                    <div class="review-rating">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= list.reviewscore}">
                                    ★
                                </c:when>
                                <c:otherwise>
                                    ☆
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="review-id"> 
	                    <script type="text/javascript">
		                	document.write(maskString('${list.c_id}'));
		                </script>
	                </div>
                    <div class="review-content">${list.content}</div>
                    <div class="review-date">${fn:split(list.regdate,' ')[0]}</div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>

