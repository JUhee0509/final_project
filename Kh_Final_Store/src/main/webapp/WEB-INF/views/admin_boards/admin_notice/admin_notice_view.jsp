<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String adminMenu = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<% String adminBoard = Common.VisitAdminBoard.VIEW_PATH + "admin_board.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Eclat de Luxe</title>
		<script src="/store/resources/js/httpRequest.js"></script>
		<link rel="stylesheet" href="/store/resources/css/board.css">
		
		<script>
			function delete_notice() {
				
				if(!confirm("삭제하시겠습니까?")){
					return;
				}
				
				let url = "admin_delete_notice.do";
				let param = "idx=${vo.idx}";
				alert("url : " + url + ", param : " + param);
				
				sendRequest(url, param, modifyFn, "POST");
			}
			
			//삭제후
			function modifyFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					
					if(data == 'complete'){
						alert("삭제됬습니다.");
						location.href="admin_notice.do";
					}else{
						alert("삭제 실패했습니다.");
					}
				}
			}
			
		</script>
	</head>
	
	<body>
	
	<%-- <div class="fixed-header">
		<jsp:include page="<%= adminMenu %>"/>
	</div> --%>
	
	<div class="fixed-header">
		<jsp:include page="<%= adminMenu %>"/>
	</div>
	
	 <div class="board_menu">
		<jsp:include page="<%= adminBoard %>"/>	
	</div>
		
		<div class="text_container">
			<h1>NOTICE</h1>
			<h5>공지사항</h5>
		</div>
		
		<div class="notice-details">
        <table class="notice-table">
            <tr>
                <td>제목</td>
                <td>${ vo.title }</td>
            </tr>
            <tr>
                <td>게시일</td>
                <td>${ vo.regdate }</td>
            </tr>
            <tr>
                <td>작성자</td>
                <td>관리자</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><pre>${ vo.content }</pre></td>
            </tr>
        </table>
       <input type="button" value="수정" onclick="location.href='admin_modify_notice.do?idx=${vo.idx}'">
       <input type="button" value="삭제" onclick="delete_notice();">
        <input type="button" value="목록보기" onclick="history.go(-1);">
    </div>
    
	</body>
</html>