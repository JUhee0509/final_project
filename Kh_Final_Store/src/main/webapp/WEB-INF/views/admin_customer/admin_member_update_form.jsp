<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "admin_index.jsp"; %>   
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
		<script src="/store/resources/js/httpRequest.js"></script>
		<script>
			function send_modify(f) {
				let c_id = '${vo.c_id}';
				let name = f.name.value; //이름
				let pwd = '${vo.pwd}'; //비밀번호
				let email = f.email.value; //이메일 선택 select
				let gender = f.gender.value; //성별 선택 
				let bonus_point = f.bonus_point.value; //보너스 포인트 
				let blacklist = '${ vo.blacklist }'; //블랙리스트 
				let del_info = f.del_info.value; //삭제여부 
				let tel = f.gender.value; //전화번호 
				
				if(!confirm("회원 정보를 수정하시겠습니까?")){
					return;
				}
				let url = "update_member_input.do";
				let param = "c_id=" + c_id + "&name=" + name + "&pwd=" + encodeURIComponent(pwd) +
							"&email=" + encodeURIComponent(email) + "&gender=" + gender +
							"&bonus_point=" + bonus_point + "&blacklist="+ blacklist +
							"&del_info" + del_info + "&tel=" + encodeURIComponent(tel) ;
				sendRequest(url, param, modifyUserFn, "post");
			}
			
			function modifyUserFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					
					if(data == "no"){
						alert("수정에 실패했습니다 다시 시도해 주세요.");
						return;
					}else if(data == "yes"){
						alert("회원 정보가 변경 되었습니다.");
						location.href = "customer_admin.do";
					}
				}
			}
		</script>
		<style>
		.fixed-header {top: 0;
			           height: 80px;
			           width: 1200px;
			           margin: 0 auto;}
		.box{width: 800px;
				 margin: 0 auto;}
		
		.row{padding: 5px;}		 
		</style>
	</head>
	<body>
	<div class="fixed-header">
        <jsp:include page="<%= includePage %>"/>
    </div>
    <br>
	<form class="data"><!-- 스타일 적용을 위한 이름 지정 -->
	<br>
	<div class="box text-center">
	<h2>${ vo.c_id }님의 정보 수정 페이지</h2>
	<br>
		<div class="row">
			<div class="col-2">아이디</div>
			<div class="col-10">${ vo.c_id }</div>
		</div>
		<div class="row">
			<div class="col-2">이름</div>
			<div class="col-10"><input name="name" value="${ vo.name }"></div>
		</div>	
		<div class="row">
			<div class="col-2">비밀번호</div>
			<div class="col-10">${ vo.pwd }</div>
		</div>	
		<div class="row">
			<div class="col-2">*이메일</div>
			<div class="col-10"><input name="email" value="${ vo.email }"></div>
		</div>
		<div class="row">
			<div class="col-2">성별</div>
			<div class="col-10"><input name="gender" value="${ vo.gender }"></div>
		</div>	
		<div class="row">
			<div class="col-2">*보너스 포인트</div>
			<div class="col-10"><input name="bonus_point" value="${ vo.bonus_point }"></div>
		</div>	
		<div class="row">
			<div class="col-2">블랙리스트</div>
			<div class="col-10">${ vo.blacklist }</div>
		</div>	
		<div class="row">
			<div class="col-2">*삭제여부</div>
			<div class="col-10"><input name="del_info" value="${ vo.del_info }"></div>
		</div>	
		<div class="row">
			<div class="col-2">*전화번호</div>
			<div class="col-10"><input name="tel" value="${ vo.tel }"></div>
		</div>	
		<br>
		<div class="row">
			<div class="col">
				<input type="button" value="수정" onclick="send_modify(this.form)">
				<input type="button" value="취소" onclick="history.go(-1)">
			</div>
		</div>	
		<br>
	</div>
	
	</form>	
	<div style="text-align: center;" >
		<span style="font-size: smaller;">*만 수정 가능한 부분입니다</span>
	</div>
	</body>
</html>