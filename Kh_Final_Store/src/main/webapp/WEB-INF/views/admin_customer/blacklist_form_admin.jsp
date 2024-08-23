<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script src="/store/resources/js/httpRequest.js"></script>
		<script>
			function blacklist_insert(f) {
				let c_id = '${vo.c_id}';
				let reason = f.reason.value;
				let a_id = f.a_id.value;
				
				if(reason == '' || a_id == ''){
					alert("모든 정보를 입력해 주십시오");
					return;
				}
				if(!confirm("정말 블랙리스트에 등록하시겠습니까?\n등록하면 회원이 더 이상 사이트에 접근할 수 없습니다.")){
					return;
				}
				
				let url = "blacklist_insert_form.do"
				let param = "c_id=" + c_id + "&reason=" + reason + "&a_id="+a_id;
				sendRequest(url, param, blacklistFn, "post");
			}
			
			function blacklistFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == "fail"){
						alert("현재 로그인 중인 관리자 아이디를 입력해 주십시오");
						return;
					}else if(json[0].result == "success"){
						
						location.href = "customer_admin.do";
						
					}
				}
			}
		</script>
	</head>
	<body>
	<br>
	<form name="f">
	<table border="1" align="center">
	<caption>회원 정보</caption>
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>이메일</td>
			<td>성별</td>
			<td>보너스 포인트</td>
			<td>블랙리스트</td>
			<td>전화번호</td>
		</tr>
		<tr>
			<td>${ vo.c_id }</td>
			<td>${ vo.name }</td>
			<td>${ vo.email }</td>
			<td>${ vo.gender }</td>
			<td>${ vo.bonus_point }</td>
			<td>${ vo.blacklist }</td>
			<td>${ vo.tel }</td>
		</tr>
	</table>
	<br>
	<table border="1" align="center">
		<caption>블랙리스트 작성 사유</caption>
		<tr>
			<td>아이디</td>
			<td>${ vo.c_id }</td>
		</tr>
		<tr>
			<td>작성사유</td>
			<td>
				<textarea autofocus name="reason" rows="20" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td>관리자 아이디</td>
			<td>
				<input name="a_id" size="41" placeholder="관리자 아이디를 입력해 주세요">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="등록" onclick="blacklist_insert(this.form)" >
				<input type="button" value="취소" onclick="history.go(-1)" >
			</td>
		</tr>
	</table>
	</form>	
	</body>
</html>