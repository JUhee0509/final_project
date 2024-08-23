<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<!-- <script ref="" type="text/css" href="위치"> 이 형식으로 css파일 참조요망-->
		<style>
	        body {
	            font-family: Arial, sans-serif;
	            line-height: 1.6;
	            margin: 20px;
	            padding: 20px;
	            background-color: #f0f0f0;
	            width:600px;
	        }
	
	        table {
	            width: 200px;
	            margin: auto;
	            background-color: #fff;
	            border-collapse: collapse;
	            border: 1px solid #ddd;
	        }
	
	        table td, table th {
	            border: 1px solid #ddd;
	            padding: 8px;
	            text-align: left;
	        }
	
	        table th {
	            background-color: lightgreen;
	        }
	
	        form {
	            margin-bottom: 10px;
	        }
	
	        label {
	            display: block;
	            margin-bottom: 5px;
	        }
	
	        input[type="checkbox"] {
	            margin-right: 5px;
	        }
	
	        hr {
	            margin-top: 20px;
	            border: none;
	            border-top: 1px solid #ddd;
	        }
    	</style>
    
	    <script>
	    //url
	    window.onload=function(){
			let search = document.getElementByName("search");
			let search_array=['all','subject','name','content','name_subject_content'];//배열에 담기
			for(let i=0;i<search_array.length;i++){
				if(search_array[i] == '${param.search}'){
					//강제로 옵션 고르기
					search[i].selected = true;
					
					let search_text= document.getElementById("search_text");
					search_text.value = '${param.search_text}';
				}
			}
		}
	    
	    
	    	// gender 체크박스 중복 불가
	    	function checkOnce(checkbox){
	    		var checkboxes = document.getElementsByName('gender');
	    	    checkboxes.forEach((item) => {
	    	        if (item !== checkbox) item.checked = false;
	    	    });
	    		
	    	}
	    	
	    	// 분류기준 파라미터 전달
	    	function submit_param(){
	    		
	    		let f1 = document.getElementById("selected");
	    		f1.action = "shop_list.do?optional=${param.optional}";
	    		f1.submit();
	    	}
	    	
	    </script>
    
	</head>
	<body>
		<div class="classify">
		
		
		<table border="1">
		<form id="selected" action="shop_list.do">
			<tr>
			<!-- 향수 이름 검색 -->
				<td>제품명 검색</td>
				<td><input placeholder="제품명을 입력하세요." name="search"></td>
			</tr>
				<tr>
					<td>브랜드</td>
					<td>
			<!--  -->
		<input type="button" value="검색" onclick="submit_param();">
				<c:forEach var="vo" items="${ brand }">
					        <label><input type="checkbox" name="brand" value="${ vo }"> ${ vo }</label><br>
				</c:forEach>
			
					</td>
				</tr>	
				 
				<tr>
					<td>향</td>
					<td>
						<c:forEach var="vo" items="${ scent }">
					        <label><input type="checkbox" name="scent" value="${ vo }"> ${ vo }</label><br>
					    </c:forEach>
				</tr>
				
				<tr>
					<td>가격</td>
					<td>
					<!-- 최종가격이 문자열로 반환됨... -->
						<label><input type="checkbox" name="price" value="under_2">2만원 이하</label>
						
						<c:forEach var="i" begin="4" end="${ price }" step="2">
							<label><input type="checkbox" name="price" value="${i-2}_and_${i}">${i-2}만원 ~ ${i}만원</label>
						</c:forEach>
						</td>
				</tr>
				<!-- 숫자 출력 -->
				<c:forEach var="i" begin="1" end="9">
					${ i }
				</c:forEach>
				
				<tr>
					<td>용량</td>
					<td>
						<c:forEach var="vo" items="${ volume }">
							<label><input type="checkbox" name="volume" value="${ vo }">${ vo } ml</label>
						</c:forEach>
					</td>
				</tr>
						
				<tr>
					<td>성별</td>
					<td>
						<label><input type="checkbox" name="gender" value="남" onclick="checkOnce(this);">남</label><br>
						<label><input type="checkbox" name="gender" value="여" onclick="checkOnce(this);">여</label><br>
					</td></form>
				</tr> 
		</table>
		</div>
	</body>
</html>