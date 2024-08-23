<%@page import="common.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String classification = Common.index.VIEW_PATH + "index.jsp"; %>
<% String mainMenu = Common.index.VIEW_PATH + "index.jsp"; %>
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Eclat de Luxe</title>
		<script src="/store/resources/js/httpRequest.js"></script>
		<link rel="stylesheet" href="/store/resources/css/shop.css">

		
    <script>
    //제품 검색 후 정렬 가능.
		document.addEventListener('DOMContentLoaded', function() {
	            var select = document.querySelector('select[name="standard"]');
	            select.addEventListener('change', function() {
	                var selectedValue = this.value;
	                var url = document.URL;//+"&optional="+selectedValue; //ajax 구현시 수정가능
	                		
	                if(url.includes('?')){
	                	
		                if (url.includes('optional=')) {
		                    // 기존의 optional 파라미터 값을 대체하는 부분
		                    var regex = /([&?]optional=)[^&]+/; // optional= 다음의 값을 찾는 정규표현식
		                    url = url.replace(regex, '$1' + selectedValue); // 선택된 값으로 대체
		                } else {
		                    // Optional 파라미터가 없는 경우 추가
		                	url = document.URL+"&optional="+selectedValue;
		                }
	                	
	                }else{
	                	url = "shop_list.do?optional="+selectedValue;
	                }
	                
	                location.href = url;
	            });
	        }); 
		 
		 
		</script>
		
		<!-- classification -->
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
	<!-- SHOP 페이지 -->
		<div class="fixed-header">
	        <jsp:include page="<%= mainMenu %>"/>
	   	 </div>
	<!-- 분류 -->

		<div class="board_container">
		
		<div class="search_table">
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
					<c:forEach var="vo" items="${ brand }">
						        <label><input type="checkbox" name="brand" value="${ vo }"> ${ vo }</label>
					</c:forEach>
				
						</td>
					</tr>	
					 
					<tr>
						<td>향</td>
						<td>
							<c:forEach var="vo" items="${ scent }">
						        <label><input type="checkbox" name="scent" value="${ vo }"> ${ vo }</label>
						    </c:forEach>
					</tr>
					
					<tr>
						<td>가격</td>
						<td>
						<!-- 최종가격이 문자열로 반환됨... -->
							<!-- <label><input type="checkbox" name="price" value="under_2">10만원 이하</label> -->
							
							<c:forEach var="i" begin="15" end="${ price }" step="5">
								<label><input type="checkbox" name="price" value="${i-5}_and_${i}">${i-5}만원 ~ ${i}만원</label>
							</c:forEach>
							</td>
					</tr>
					<!-- 숫자 출력 -->
					
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
							<label><input type="checkbox" name="gender" value="m" onclick="checkOnce(this);">남</label>
							<label><input type="checkbox" name="gender" value="f" onclick="checkOnce(this);">여</label>
						</td></form>
					</tr> 
			</table>
					<input type="button" value="검색" onclick="submit_param();">
		</div>
		
		</div>
		<!-- 다시 활성화 -->
		<!-- <input type="button" value="chart" onclick="location.href='chart.do'"> -->
		
		<!-- <input type="button" value="제품등록" onclick="location.href='insert_product_adimin.do'">
		 : 나중에 관리자 페이지로 들어갈 것. 이미지 등록 및 샘플 데이터 삽입 위해 미리 구현함
		<hr> -->
		<div class="product_listing">
		<form>
			<select name="standard" onchange="selectedOption()">
				<option value="normal">기본</option>
				<option value="lower">가격낮은순</option>
				<option value="higher">가격높은순</option>
				<option value="popular">인기순</option>
				<option value="more_review">리뷰많은순</option>
			</select>
		</form>
		</div>
		
	
		<div class="product-container">
			<c:forEach var="vo" items="${ list }">
			<div class="md-item" onclick="location.href='PageProductList.do?p_idx=${vo.p_idx}'">
				<div>
					<%-- <img src="/store/resources/upload/${ vo.s_image }" width="200"> --%>
					<img src="/store/resources/upload/${vo.s_image}">
				</div><br>
					 ${ vo.brand }<br>
					 ${ vo.p_name }<br>
					 ${ vo.p_rate }%<br>
					원가 : <span><ftm:formatNumber value="${ vo.price }" pattern="#,###원"/></span><br>
					할인가 : <ftm:formatNumber value="${ vo.sale_price }" pattern="#,###원"/><br>
					용량 : ${ vo.volume } ml<br>
					향 : ${ vo.scent }<br>
				</div>
			</c:forEach>
		</div>
	</body>
</html>