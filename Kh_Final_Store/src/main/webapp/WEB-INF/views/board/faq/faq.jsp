<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String board = Common.Visit_board.VIEW_PATH + "board.jsp"; %>
<% String mainMenu = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Eclat de Luxe</title>
		<link rel="stylesheet" href="/store/resources/css/board.css">
		
		</style>
		
		<script>
		//페이지 로드 될 때 실행되는 함수.페이지의 모든 요소가 로드된 후 실행됨.
		//DOM 요소에 대한 접근 안전함
		 window.onload = function() {
	            // 모든 질문 영역을 가져옴
	            var questions = document.querySelectorAll('.question');

	            // 각 질문에 대해 클릭 이벤트 핸들러를 등록
	            questions.forEach(function(question) {//question에 대해 반복 실행
	                question.addEventListener('click', function() {
	                	// .addEventListener(event, callback)
	                	//각 질문 요소 클릭시 함수 실행됨 
	                	//클릭된 질문 요소의 다음 형제 요소를 찾아서 변수 answer에 저장합니다. 
	                	//이 다음 요소는 질문에 대한 답변을 나타냅니다.
	                    // 현재 질문의 다음 요소를 찾아서 보이기/감추기를 토글
	                    var answer = this.nextElementSibling;
	                	//this.nextElementSibling : 현재 요소의 다음 형제 요소를 반환
	                	//클릭시 나오는 답변
	                    if (answer.style.display === 'block') {
	                        answer.style.display = 'none'; // 보이는 상태면 숨김
	                    } else {
	                        answer.style.display = 'block'; // 숨겨진 상태면 보이게 함
	                    }
	                });
	            });
	        };
		</script>
		
	</head>
		<body>
		<div class="fixed-header">
        	<jsp:include page="<%= mainMenu %>"/>
    	</div>
    	<!-- board.jsp의 css 적용을 위해 div 적용 -->
	    <div class="board_menu">
	    	<jsp:include page="<%= board %>"/>
	    </div>	
			<!-- faq 페이지 -->
		<div class="text_container">
			<h1>FAQ</h1>
			<h5>자주 묻는 질문</h5>
		</div>
			<div class="faq_container">
				<c:forEach var="vo" items="${ list }">
					<div class="question">Q. ${ vo.question }</div>
					<div class="answer">A. ${ vo.answer }</div>
				</c:forEach>
			</div>
		</body>
</html>