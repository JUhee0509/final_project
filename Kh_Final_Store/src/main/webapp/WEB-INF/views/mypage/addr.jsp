<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주소지 등록</title>
	
	<style>
		.btn{margin:0 40%;
			 width: 70px;}
		
		input {font-size: 15px;
				padding: 4px;
				}
	</style>
	
	<script>
	function send(f) {
		f.action = "addr_reg.do";
		
		f.submit();
		
	}
	
	
	function add() {
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	        	var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                 
                } 

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
	            
	        }
	    }).open();
	}
	</script>
	<!-- 주소 링크 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	</head>
	<body>	
		<h3 align="center">배송지 추가</h3>
		<form>
			<input type="hidden" value="${c_id }" name="c_id">
			<input type="text" size="25" id="sample6_postcode" placeholder="우편번호">
			<input type="button" onclick="add()" value="우편번호 찾기"><br>
			<input type="text" size="30" id="addr" placeholder="주소" name="addr"><br>
			<input type="text" size="30" id="sample6_detailAddress" placeholder="상세주소"><br>
			<input type="text" size="30" placeholder="명칭" name="a_name"><br>
			<input type="text" size="30" placeholder="요청사항" name="request"><br><br>
			<input type="button" class="btn" value="등록" onclick="send(this.form)">
		</form>		
	</body>
</html>