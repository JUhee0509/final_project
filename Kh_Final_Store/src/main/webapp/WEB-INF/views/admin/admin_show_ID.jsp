<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 결과</title>
    <style>
        body {
            margin: 0;
            padding-top: 60px; /* 상단바 높이만큼 패딩 추가 */
            background-color: #F5F5F5; /* 페이지 배경을 연한 회색으로 */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .fixed-top {
            position: fixed;
            top: 0;
            width: 100%;
            background-color: #ffffff; /* 상단바 배경을 흰색으로 */
            z-index: 1000; /* 상단바가 다른 요소 위에 표시되도록 z-index 설정 */
        }
        .container {
            background-color: #fff;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }
        .title {
            color: #4caf50; /* 타이틀을 초록색으로 */
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        .message {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
        }
        .btn-group {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn-group input[type="button"] {
            background-color: #4caf50; /* 초록색 배경 */
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-group input[type="button"]:hover {
            background-color: #45a049;
        }
    </style>
    <script src="/store/resources/js/httpRequest.js"></script>
</head>
<body>
    <div class="fixed-top">
        <jsp:include page="<%= includePage %>"/>
    </div>
    <div class="container">
        <div class="title">관리자 아이디 찾기</div>
        <div class="message">
            ${ admin.name }님의 아이디는 ${ admin.a_id }입니다.
        </div>
        <div class="btn-group">
            <input type="button" value="로그인 하러 가기" onclick="location.href='login_form.do'"><!-- 로그인 이동 -->
        </div>
    </div>
</body>
</html>
