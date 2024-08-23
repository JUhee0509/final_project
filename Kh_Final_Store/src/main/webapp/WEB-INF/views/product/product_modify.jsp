<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String includePage = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<%@ page import="common.Common" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		
		
		<script>
		function send(f) {
	        // 폼 유효성 체크
	        if (f.brand.value == "" || f.p_name.value == "" || f.scent.value == "" || f.price.value == "" || f.p_rate.value == "" || f.volume.value == "" || f.stock.value == "" || f.sales.value == "" || f.gender.value == "") {
	            alert("모든 내용를 입력해주세요.");
	            return false;
	        }
	        if (isNaN(f.price.value) || f.price.value <= 0) {
	            alert("가격은 숫자로 입력해야 하며 가격은 0보다 커야 합니다.");
	            return false;
	        }
	        if (isNaN(f.p_rate.value) || f.p_rate.value < 0 || f.p_rate.value > 100) {
	            alert("할인률은 숫자로 입력해야 하며 할인률은 0과 100 사이의 값이어야 합니다.");
	            return false;
	        }
	        if (isNaN(f.volume.value) || f.volume.value <= 0) {
	            alert("용량은 숫자로 입력해야 하며 0ml 이상으로 입력해야 합니다.");
	            return false;
	        }
	        if (isNaN(f.stock.value) || f.stock.value <= 0) {
	            alert("재고는 숫자로 입력해야 하며 재고는 0보다 커야 합니다.");
	            return false;
	        }
	        if (isNaN(f.sales.value) || f.sales.value < 0 || f.sales.value >= 1) {
	            alert("판매량은 기본이 0이며 숫자로 입력해야 합니다.");
	            return false;
	        }
	        if (f.s_image_url.files.length == 0 || f.l_image_url.files.length == 0 || f.ad_image_url.files.length == 0) {
	            alert("모든 이미지 파일을 선택하세요.");
	            return false;
	        }
	        if (!confirm("등록하시겠습니까?")) {
	            return false;
	        }
	        f.action = "product_modify.do";
	        f.submit();
	    }
		</script>
		
		<style>
    		.box{margin: 0 auto;
    			 width: 500px;
    			 border: 1px solid #3d3d3d;}
    	
    		.bttn{width: 120px;
    			  height: 50px;}
    		
    		.row{padding: 5px;}
    	</style>
	</head>
		<body>
		<div class="fixed-header">
        	<jsp:include page="<%= includePage %>"/>
    	</div>
		<br>
		<h1 align="center">제품 수정</h1>
			<form method="post" enctype="multipart/form-data">
			
			<input type="hidden" name="p_idx" value="${ vo.p_idx }">
				<div class="box text-center">
				<br>
					<div class="row">
					
						<div class="col-3">브랜드명</div>
						<div class="col-9">
							<input name="brand" value="${vo.brand}">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">제품명</div>
						<div class="col-9">
							<input name="p_name" value="${vo.p_name}">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">향</div>
						<div class="col-9">
							<input name="scent" value="${vo.scent}">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">작은 이미지</div>
						<div class="col-2"></div>
						<div class="col-7">
							<input type="file" name="s_image_url">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">큰 이미지</div>
						<div class="col-2"></div>
						<div class="col-7">
							<input type="file" name="l_image_url">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">광고 이미지</div>
						<div class="col-2"></div>
						<div class="col-7">
							<input type="file" name="ad_image_url">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">원가</div>
						<div class="col-9">
							<input name="price" value="${vo.price}">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">할인률</div>
						<div class="col-9">
							<input name="p_rate" value="${vo.p_rate}">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">용량</div>
						<div class="col-9">
							<input name="volume" value="${vo.volume}">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">재고</div>
						<div class="col-9">
							<input name="stock" value="${vo.stock}">
						</div>
					</div>
					
					<div class="row">
						<div class="col-3">판매량</div>
						<div class="col-9">
							<input name="sales" value="${vo.sales}">
						</div>
					</div>
					
					<div class="row">
		                <div class="col-3">성별</div>
		                <div class="col-9">
		                    <select name="gender" required>
		                        <option value="m">남성</option>
		                        <option value="f">여성</option>
		                    </select>
		                </div>
		            </div>
					<br>
					<div class="row">
						
						<div class="col">
							<input type="button" value="수정하기" onclick="send(this.form);">
							<input type="button" value="뒤로가기" onclick="history.go(-1);">
						
						</div>
					</div>
					<br>
				</div>
				</form>
		</body>
</html>