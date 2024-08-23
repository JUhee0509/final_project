<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>관리자 로그인</title>
		<link href="resources/css/admin_login.css" rel="stylesheet"/>
		<script src="/store/resources/js/httpRequest.js"></script>
		
		<script>
		//-----------------회원 로그인 하는 함수
			function admin_login(f) {
				let a_id = f.a_id.value;
				let pwd = f.pwd.value;
				if(a_id == '' || pwd == ''){
					alert("아이디/비밀번호를 입력해 주세요");
					return;
				}
				
				let url = "admin_login.do";
				let param = "a_id=" + a_id + "&pwd=" + encodeURIComponent(pwd);
				sendRequest(url, param,  LoginFunction, "post");
			}
			//-----------------회원 로그인 함수 Ajax
			function LoginFunction() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+ data))();
					
					if(json[0].result == "no_id"){
						alert("아이디가 존재하지 않습니다.");
						
						if(!confirm("회원가입 화면으로 이동하시겠습니까?")){
							return;
						}
						location.href = "member_join_form.do";
						return;
						
					} else if(json[0].result == "no_pwd"){
						alert("비밀번호가 일치하지 않습니다.");
					} 
					
					if(json[0].result == 'success'){
						alert(json[0].a_id + "님 환영합니다.");
						location.href = "admin_mainPage.do";
					}
				}
			}//LoginFunction
			
			//-----------------------아이디 찾기 함수
		</script>
	</head>
	<body>
	<jsp:include page="<%= includePage %>"/>
		<h2 align="center">관리자 로그인</h2>
	<form>
		<div class="box">
			<div class="text-center">
				<div>
					<input name="a_id" placeholder="아이디" size=35 class="id">
				</div>
				<br>
				<div>
					<input type="password" name="pwd" placeholder="비밀번호" size=35 class="pwd">
				</div>
			</div>	
			<div class="row text-center">
				<div class="col">
					<input type="button" value="로그인" class="login_btn" onclick="admin_login(this.form)">
				</div>
			</div>
			
			<div class="row text-center">
                <div class="col">
                    <a href="admin_find_ID.do" class="id_btn">아이디 찾기</a>
                </div>
                <div class="separator">|&nbsp;&nbsp;</div>
                <div class="col">
                    <a href="admin_find_PWD.do" class="pwd_btn">비밀번호 찾기</a>
                </div>
                <div class="separator">&nbsp;&nbsp;|</div>
                <div class="col">
                    <a class="join_btn" href="admin_join_form.do">회원가입</a>
                </div>
            </div>
            <br>
		</div>
	</form>
	</body>
</html>