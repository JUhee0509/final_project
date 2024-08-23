<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eclat de Luxe</title>
    <script src="/store/resources/js/ad.js"></script>
    <link href="resources/css/consumer_mainpage.css" rel="stylesheet"/>
    <link href="resources/css/product_item.css" rel="stylesheet"/>
    <script>
        /* 추천 상품 더보기 버튼 설정 */
        function moreItems() {
            var items = document.querySelectorAll('.md-item');
            var button = document.getElementById('more-Button');
            var isShowingAll = button.textContent === '닫기';

            items.forEach(function(item, index) {
                if (index >= 4) {
                    item.classList.toggle('visible', !isShowingAll);
                }
            });

            button.textContent = isShowingAll ? '더보기' : '닫기';
        }
    </script>
</head>

<body>
    <div class="fixed-header">
        <jsp:include page="<%= includePage %>"/>
    </div><!-- 메인메뉴 받음 -->
    <!-- 광고 이동 페이지 -->
    <div class="wrap">
        <div class="img_header">
            <div class="img_inner"><!-- 메인페이지 사진광고 -->
                <div class="img s1"><img alt="img1" src="resources/img/main_title_img/home1.png"></div>
                <div class="img s2"><img alt="img2" src="resources/img/main_title_img/home2.png"></div>
                <div class="img s3"><img alt="img3" src="resources/img/main_title_img/home3.png"></div>
                <!--  <div class="img s4"><img alt="img4" src="resources/img/main_title_img/home4.png"></div> -->
            </div>
        </div>
        <div class="slider_dot"><!-- 메인메뉴 현재 사진 이동 버튼 -->
        </div>
    </div>
    <div class="md_pick">🏆 MD pick!</div>
    <div class="popular_product">인기 아이템</div>
    <div class="md_total">
        <div class="md-container">
            <c:choose>
                <c:when test="${not empty list and list.size() >= 4}">
                    <c:forEach var="vo" items="${list}" varStatus="status">
                        <div class="md-item <c:if test="${status.index < 4}">visible</c:if>" onclick="location.href='PageProductList.do?p_idx=${vo.p_idx}'">
                            <div class="md">
                                <img src="/store/resources/upload/${vo.s_image}" width="200px">
                            </div>
                            <div class="brand">${vo.brand}</div>
                            <div class="product-name">${vo.p_name}</div>
                            <c:choose>
                                <c:when test="${vo.p_rate <= 0}">
                                    <div>${vo.price}</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="sale_price"><fmt:formatNumber value="${vo.price - (vo.price * vo.p_rate / 100)}"/>원</div>
                                    <div class="p_rate">${vo.p_rate}%</div>
                                    <div class="price"><fmt:formatNumber value="${vo.price}"/></div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                   
                </c:when>
                <c:otherwise>
                    <c:forEach var="vo" items="${list}" varStatus="status">
                        <div class="md-item <c:if test="${status.index < 4}">visible</c:if>" onclick="location.href='PageProductList.do?p_idx=${vo.p_idx}'">
                            <div class="md">
                                <img src="/store/resources/upload/${vo.s_image}" width="200px">
                            </div>
                            <div class="brand">${vo.brand}</div>
                            <div class="product-name">${vo.p_name}</div>
                            <c:choose>
                                <c:when test="${vo.p_rate <= 0}">
                                    <div>${vo.price}</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="sale_price"><fmt:formatNumber value="${vo.price - (vo.price * vo.p_rate / 100)}"/>원</div>
                                    <div class="p_rate">${vo.p_rate}%</div>
                                    <div class="price"><fmt:formatNumber value="${vo.price}"/></div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
                    <c:if test="${list.size() >= 5}">
                        <div id="more-Button" onclick="moreItems()">더보기</div>
                    </c:if>
</body>
</html>
