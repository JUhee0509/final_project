<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 결과</title>
    <script src="/store/resources/js/httpRequest.js"></script>
    <style>
        body {
            text-align: center;
            font-family: 'Arial', sans-serif;
            padding: 20px;
        }
        .box {
            width: 300px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
        }
        .message {
            font-size: 18px;
            padding: 5px;
            margin-bottom: 10px;
        }
        .login_btn {
            margin-top: 20px;
        }
        .login_btn input {
            background-color: #004d00;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 3px;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .login_btn input:hover {
            background-color: #003a00;
        }
    </style>
</head>
<body>
    <div class="fixed-top">
        <jsp:include page="<%= includePage %>"/>
    </div>
    <h2 align="center">회원 아이디</h2>
    <div class="box">
    <h3 align="center">회원님의 이메일로 가입된 아이디가 있습니다.</h3>
        <div class="message">
         아이디 : ${ storeuser.c_id }
        </div>	
        <div class="login_btn">
            <input type="button" value="회원 로그인" onclick="location.href='login_form.do?c_id=${ storeuser.c_id }'"><!-- 로그인 이동 -->
        </div>
    </div>
</body>
</html>
