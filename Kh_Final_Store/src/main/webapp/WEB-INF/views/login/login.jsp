<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 로그인</title>
		<link href="resources/css/member_login.css" rel="stylesheet"/>
		<script src="/store/resources/js/httpRequest.js"></script>
		<script>
		//-----------------회원 로그인 하는 함수
			function login(f) {
				let c_id = f.c_id.value;
				let pwd = f.pwd.value;

				if(c_id == '' || pwd == ''){
					alert("아이디/비밀번호를 입력해 주세요");
					return;
				}
				
				let url = "login.do";
				let param = "c_id=" + c_id + "&pwd=" + encodeURIComponent(pwd);
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
						return;
					} else if(json[0].result == "blacklist_user"){
						alert("블랙리스트에 등록된 계정으로는 접속이 불가능합니다.\n문의사항이 있으시면 관리자에게 문의하세요.");
						return;
					}

					if(json[0].result == 'success'){
						alert(json[0].c_id + "님 환영합니다.");
						location.href = "mainPage.do";
					}
				}
			}//LoginFunction
			
			//-----------------------아이디 찾기 함수
		</script>
	</head>
	<body>
	<jsp:include page="<%= includePage %>"/>
		<h2 align="center">로그인</h2>
	<form>
        <div class="box">
            <div class="text-center">
                <div>
                    <input name="c_id" placeholder="아이디" size="35" class="id">
                </div>
                <br>
                <div>
                    <input type="password" name="pwd" placeholder="비밀번호" size="35" class="pwd">
                </div>
            </div>    
            <div class="row text-center">
                <div class="col">
                    <input type="button" value="로그인" class="login_btn" onclick="login(this.form)">
                </div>
            </div>
            <div class="row text-center">
                <div class="col">
                    <a href="storeUserFindIDForm.do" class="id_btn">아이디 찾기</a>
                </div>
                <div class="separator">|&nbsp;&nbsp;</div>
                <div class="col">
                    <a href="storeUserFindPWD.do" class="pwd_btn">비밀번호 찾기</a>
                </div>
                <div class="separator">&nbsp;&nbsp;|</div>
                <div class="col">
                    <a class="join_btn" href="member_join_form.do">회원가입</a>
                </div>
            </div>
            <br>
            <div class="admin">
                <a href="admin_login_main.do">관리자님이신가요?</a>
            </div>
        </div>
    </form>
</body>
</html>