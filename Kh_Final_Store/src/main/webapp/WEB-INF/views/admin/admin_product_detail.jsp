<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String includePage = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="common.Common" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 상세 페이지</title>
    <link href="resources/css/product_detail.css" rel="stylesheet"/>
    <script type="text/javascript">
        function LogincheckAction(message, url) {
            var isLoggedIn = '<%= (session.getAttribute("user") != null) %>';
            if (isLoggedIn == 'true') {
                ShowAction(message, url);
            } else {
                alert("로그인이 필요합니다.");
                window.location.href = 'login_main.do';
            }
        }

        function ShowAction(message, url) {
            alert(message);
            window.location.href = url;
        }

        function toggleDetailSection() {
            var detailSection = document.getElementById("detail-section");
            var moreButton = document.getElementById("more-button");
            if (detailSection.classList.contains("expanded")) {
                detailSection.classList.remove("expanded");
                moreButton.innerText = "더 보기";
            } else {
                detailSection.classList.add("expanded");
                moreButton.innerText = "접기";
            }
        }
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
        window.addEventListener('scroll', function() {
            var mainContainer = document.querySelector('.main-container');
            var miniContainer = document.querySelector('.mini-container');
            var mainContainerBottom = mainContainer.getBoundingClientRect().bottom;

            if (mainContainerBottom < 0) {
                miniContainer.style.display = 'block';
            } else {
                miniContainer.style.display = 'none';
            }
        });
    </script>
</head>
<body>
    <div class="fixed-header">
        <jsp:include page="<%= includePage %>"/>
    </div>

    <div class="mini-container">
        <div class="Second_view">
            <img class="Second_img" src="/store/resources/upload/${vo.l_image}">
            <div class="Second_Detail">
                <div class="mini_p_name">${vo.p_name}</div>
                <div class="mini_sale_price"><fmt:formatNumber value="${vo.sale_price}" type="number"/>원</div>
            </div>
            <div class="mini_volume_form"><button class="mini_volume selected">${vo.volume}ml</button></div>
                <div class="mini_Payment_button">
                    <c:choose>
                        <c:when test="${not empty pick}">
                            <button class="pick_check" onclick="LogincheckAction('찜 취소', 'pick_del.do?p_idx=${ vo.p_idx }')">♥</button>
                        </c:when>
                        <c:otherwise>
                            <button class="pick_check" onclick="LogincheckAction('찜에 담겼습니다', 'pick_check.do?p_idx=${ vo.p_idx }')">♡</button>
                        </c:otherwise>
                    </c:choose>
                    <button class="cart" onclick="LogincheckAction('카트에 담았습니다', 'cart.do?p_idx=${ vo.p_idx }')">🛒</button>
                    <button class="buy" onclick="LogincheckAction('구매 페이지로 이동합니다', 'product_order_sheet.do?p_idx=${ vo.p_idx }&c_id=${ c_id }')">구매하기</button>
                </div>
        </div>
    </div>

    <div class="main-container">
        <div class="first_view">
            <img class="first_img" src="/store/resources/upload/${vo.l_image}">
            <hr>
            <div class="first_Detail">
                <div class="brand">${vo.brand}</div>
                <div class="p_name">${vo.p_name}</div>
                <c:if test="${vo.stock < 20}">
		            <div class="stock">${vo.stock}개 남음</div>
		        </c:if>
                <div class="Payment">
                    <c:if test="${vo.p_rate != 0}">
                        <div class="p_rate">${vo.p_rate}%</div>
                    </c:if>
                    <div class="sale_price"><fmt:formatNumber value="${vo.sale_price}" type="number"/>원</div>
                </div>
                <c:if test="${vo.p_rate != 0}">
                    <div class="price"><fmt:formatNumber value="${vo.price}" type="number"/></div>
                </c:if>
                <hr>
                <div>
                    <button class="volume selected">${vo.volume}ml</button>
                </div>
                <hr>
                <div class="scent">시향: ${vo.scent}</div>
                <hr>
                <div class="Payment_button">
                    <c:choose>
                        <c:when test="${not empty pick}">
                            <button class="pick_check" onclick="LogincheckAction('찜 취소', 'pick_del.do?p_idx=${ vo.p_idx }')">♥</button>
                        </c:when>
                        <c:otherwise>
                            <button class="pick_check" onclick="LogincheckAction('찜에 담겼습니다', 'pick_check.do?p_idx=${ vo.p_idx }')">♡</button>
                        </c:otherwise>
                    </c:choose>
                    <button class="cart" onclick="LogincheckAction('카트에 담았습니다', 'cart.do?p_idx=${ vo.p_idx }')">🛒</button>
                    <button class="buy" onclick="LogincheckAction('구매 페이지로 이동합니다', 'product_order_sheet.do?p_idx=${ vo.p_idx }&c_id=${ c_id }')">구매하기</button>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <div class="navigation_button">
        <button onclick="location.href='#detail-section'">상세 페이지</button>
        <c:if test="${not empty list}">
            <button onclick="location.href='#review-section'">리뷰 ${fn:length(list)}</button>
        </c:if>
        <button onclick="location.href='product_check.do'">목록으로</button>
    </div>
    <div id="detail-section">
        <img class="ad_img" src="/store/resources/upload/${vo.ad_image}">
    </div>
    <div id="more-button" onclick="toggleDetailSection()">더 보기</div>
    <c:if test="${not empty list}">
        <div class="review-title">
            <div class="review-count">총 리뷰 수: ${fn:length(list)}</div>
            <div id="review-section">
                <c:forEach var="item" items="${list}" varStatus="status">
                    <c:if test="${status.index < 4 && not empty item.image}">
                        <div class="review-item" onclick="location.href='review_detail.do?p_idx=${vo.p_idx}&r_idx=${item.r_idx}'">
                            <div><img src="/store/resources/upload/${item.image}" width="100"></div>
                            <div class="review-rating">
		                        <c:forEach begin="1" end="5" var="i">
		                            <c:choose>
		                                <c:when test="${i <= item.reviewscore}">
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
		                    		document.write(maskString('${item.c_id}'));
		                		</script>
	                		</div>
		                    <div class="review-content">${item.content}</div>
		                    <div class="review-date">${fn:split(item.regdate,' ')[0]}</div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="review_button">
            <button onclick="location.href='review_check.do'">상세보기</button>
        </div>
    </c:if>
</body>
</html>
