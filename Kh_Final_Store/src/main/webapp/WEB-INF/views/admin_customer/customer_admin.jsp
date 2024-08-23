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
			function modify_member(c_id){
				location.href = "user_modifyForm_admin.do?c_id="+c_id;
			}
		
			function delete_member(c_id) {
				
				if(!confirm("정말 삭제하시겠습니까? 삭제된 회원정보는 복구할 수 없습니다.")){
					return;									
				}
				let url = "user_deleteForm_admin.do";
				let param = "c_id="+c_id;
				sendRequest(url, param, userDelFn, "post");
			}//delete_member
			
			function userDelFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					
					if(data == "no"){
						alert("삭제 실패");
						return;
					}else if(data == "yes"){
						alert("삭제 완료");
						location.href="customer_admin.do";
						return;
					}else{
						alert("알 수 없는 오류가 발생했습니다.");
						return;
					}
				}
			}//userDelFn
			
			function blacklist(c_id) {
				if(!confirm("블랙리스트 사유를 작성하시겠습니까?")){
					return;
				} 
				location.href = "member_black_form.do?c_id="+c_id;
			}
		</script>
		<style>
		.fixed-header {top: 0;
			           height: 80px;
			           width: 1200px;
			           margin: 0 auto;}
		
		h3{font-weight: bold;
			   margin-left: 10%;}
		
		.box{width: 1800px;
				 margin: 0 auto;
				 }
		
		.title{
			   background: #DCDCDC;}
		
		.row{border: 1px solid #3d3d3d;}
		
		#table{border-right: 1px solid #3d3d3d;
			   padding: 5px;
			   border-bottom: 1px solid #3d3d3d;}
			   
		#table1{padding: 5px;
				border-bottom: 1px solid #3d3d3d;}
		
		.bttn{background: #fff;
			  border-radius: 5px;
			  border-color: #158792;}
			  
		.bttn:hover{color: #fff;
					background: #158792;}
		
		</style>
	</head>
	<body>
	<div class="fixed-header">
        <jsp:include page="<%= includePage %>"/>
    </div>
    <br>
		<h3>고객 관리</h3>
	<form name="f" class="data"><!-- 스타일 적용을 위한 이름 지정 -->
	
	<div class="box text-center">
	<br>
	
		<div class="row title border-bottom-0" >
			<div class="col-1" id="table">아이디</div>
			<div class="col-1" id="table">이름</div>
			<div class="col-3" id="table">비밀번호</div>
			<div class="col-1" id="table">이메일</div>
			<div class="col-1" id="table">성별</div>
			<div class="col-1" id="table">보너스 포인트</div>
			<div class="col-1" id="table">블랙리스트</div>
			
			<div class="col-1" id="table">전화번호</div>
			<div class="col-2" id="table1">비고</div>
		</div>
		<div class="row aa">
		<c:forEach var="vo" items="${ list }">
		
			<div class="col-1" id="table">${ vo.c_id }</div>
			<div class="col-1" id="table">${ vo.name }</div>
			<div class="col-3 text-break" id="table">${ vo.pwd }</div>
			<div class="col-1 text-break" id="table">${ vo.email }</div>
			<div class="col-1" id="table">${ vo.gender }</div>
			<div class="col-1" id="table">${ vo.bonus_point }</div>
			<div class="col-1" id="table">${ vo.blacklist }</div>
			
			<div class="col-1" id="table">${ vo.tel }</div>
			<div class="col-2" id="table1">

				<input type="button" value="수정" class="bttn"
					   onclick="modify_member('${vo.c_id}')">
				<input type="button" value="삭제" class="bttn"
					   onclick="delete_member('${vo.c_id}')">
				<input type="button" value="블랙 등록" class="bttn"
					   onclick="blacklist('${vo.c_id}')">
			</div>
		
		</c:forEach>
		</div>
	</div>
	</form>	
	
	</body>
</html>