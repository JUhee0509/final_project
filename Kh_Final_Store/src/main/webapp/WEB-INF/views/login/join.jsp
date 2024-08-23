<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/store/resources/js/httpRequest.js"></script>
<link rel="stylesheet" href="resources/css/member_join.css"/>
<script>
        let isDuplicateChecked = false;//아이디 중복확인
        let isPwdChecked = false; //비밀번호 인증 확인
        let isNameChecked = false; //이름 인증 확인
        let isEmailChecked = false; //이메일 인증 확인
        let isEmailNumberChecked = false; //이메일 인증번호 확인
        let isTelChecked = false; //휴대폰 번호 확인
		
        function setErrorMessage(elementId, message, isError) {
            let element = document.getElementById(elementId);
            element.textContent = message;
            if (isError) {
                element.classList.remove('success');
                element.classList.add('error');
            } else {
                element.classList.remove('error');
                element.classList.add('success');
            }
        }
        
        function sendUserJoin(f) {
        let c_id = f.c_id.value.trim(); //아이디
    	let pwd = f.pwd.value.trim(); //비밀번호
        let pwd_check = f.pwd_check.value.trim(); //비밀번호 체크
        let name = f.name.value.trim(); //이름
            
        let inputEmail = f.inputEmail.value.trim(); //이메일
        let email_at = '@';
        let selectEmail = f.selectEmail.value.trim(); //이메일 선택 select
            
        let email = inputEmail + email_at + selectEmail; //전체 이메일
            
        let email_check = f.email_check.value.trim(); //인증코드
        let tel = f.tel.value.trim(); //전화번호
        
        let selectGender = f.selectGender.value; //성별 선택
        //경고창을 띄우기 위해 id를 가져오는 코드 
        let idError = document.getElementById("id-error");
        let pwdError = document.getElementById("pwd-error");
        let pwdCheckError = document.getElementById("pwd_check-error");
        let nameError = document.getElementById("name-error");
        let emailError = document.getElementById("email-error");
        let emailCheckError = document.getElementById("email_check-error");
        let telError = document.getElementById("tel-error");
			
        let IDCheck_Every = /^[a-z0-9]+$/;
            
		//---------------------------------아이디 중복확인 체크
		if(!isDuplicateChecked){
			setErrorMessage('id-error', '아이디 중복확인은 필수에요', true);
			return;
		}
		
		//---------------------------------비밀번호 확인 체크
		if(!isPwdChecked){
			setErrorMessage('pwd-error', '비밀번호를 입력해 주세요', true);
			return;
		}

		//---------------------------------이름 확인 체크
        if(!isNameChecked){
			setErrorMessage('name-error', '이름을 입력해 주세요', true);
        	return;
        }  

		let nameCheck = /^[가-힣\s]*$/;
        if(name == '' || !nameCheck.test(name)){
			setErrorMessage('name-error', '올바른 이름을 입력해 주세요', true);
        	return;
        }	
        
		//---------------------------------이메일 인증 확인 체크
		//if(inputEmail == '' || selectEmail == ''){
        	if(!isEmailChecked){
				setErrorMessage('email-error', '이메일 인증확인은 필수에요', true);
    	    	return;
	        }
		//}
        
        if(!isEmailNumberChecked){
			setErrorMessage('email_check-error', '이메일 인증을 위해 확인 버튼을 눌러주세요', true);
        	return;
        } 
		
		//---------------------------------전화번호 입력 확인 체크
        
        let tel1 = '';
		
		if(tel != ''){
	        if(tel.length < 10 || tel.length > 11){//비어있거나 9자리 이하 12자리 이상일 때
				setErrorMessage('tel-error', '번호 형식이 올바르지 않습니다', true);
				return;
			} else if (tel.length == 10 || tel.length == 11) {
		        tel1 = tel.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
			}
		}
		
        if(tel == '' || selectGender == ''){
            if(!confirm("전화번호 또는 성별 정보를 입력하지 않았어요.\n회원가입을 계속 진행할까요?")){
				return;
            } 
        }
        
        //Ajax로 회원가입 성공 띄우기
        let url = "join_insert.do";
        let param = "c_id=" + c_id + "&pwd=" + encodeURIComponent(pwd) + 
					"&name=" + name + "&email=" + encodeURIComponent(email) +
            		"&tel=" + tel1 + "&gender=" + selectGender;
        sendRequest(url, param, joinResult, "post");
        }//sendUserJoin
        
        //----------------------------회원가입 Ajax joinResult 함수 호출
        function joinResult() {
			if(xhr.readyState == 4 && xhr.status == 200){
				let data = xhr.responseText;
				let json = (new Function('return '+data))();
				
				if(json[0].result == 'success'){
					alert(json[0].name + "님 회원가입을 환영합니다");
					location.href = "login_form.do";
					return;
				}
			}
		}
        
      //아이디 중복체크 함수
        function duplicate_checkID(c_id) {
          let idError = document.getElementById("id-error");
          let inputID = f.c_id.value;
			
          // 대문자가 포함되어 있는지 확인
          let IDCheck_EngUpper = /[A-Z]/.test(inputID);
          let IDCheck_Number = /^[0-9]+$/.test(inputID);
          let IDCheck_Every = /^[a-z0-9]+$/.test(inputID);
		
          if (inputID == '') {
        	  setErrorMessage('id-error', '아이디를 입력해 주세요', true);
              return;
          } 

          if (!IDCheck_Every || IDCheck_EngUpper) {
        	  setErrorMessage('id-error', '공백/대문자/특수문자/한글이 포함된 아이디는 사용할 수 없습니다', true);
              return;
          } else if(IDCheck_Number){
        	  setErrorMessage('id-error', '숫자로만 입력한 아이디는 사용할 수 없습니다', true);
             return;
          } else if (inputID.length < 4  || inputID.length > 14 ) {
        	  setErrorMessage('id-error', '아이디는 영문 소문자/숫자 포함 4~14자로 입력해주세요', true);
        	  return;
          } 

          let url = "duplicate_checkID.do";
          let param = "c_id=" + inputID;
          sendRequest(url, param, checkID, "post");
      }

        //아이디 중복체크 Ajax함수 호출
        function checkID() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let data = xhr.responseText;
                let json = (new Function('return ' + data))();
                let idError = document.getElementById("id-error");

                if (json[0].param == 'fail') {
		        	setErrorMessage('id-error', '이미 사용중인 아이디 입니다', true);
                    c_id.value = '';  // 아이디 입력 창 비우기
                } else if (json[0].param == 'success') {
		        	setErrorMessage('id-error', '사용 가능한 아이디 입니다', false);
                    isDuplicateChecked = true;
                }
            }
        }//checkID
        
        //-----------------------------아이디 감지하는 ONINPUT함수
        function resetAndCheckID() {
            isDuplicateChecked = false;
            let idError = document.getElementById("id-error");
            idError.textContent = "";
            let c_id = document.getElementById("c_id").value;
           
            if (c_id == '' || c_id != null) {
                return; // 아이디가 비어있으면 체크하지 않음
            }
            // 중복 체크 함수 호출
        }
        
        //-----------------------------비밀번호 감지하는 ONINPUT함수
        function resetAndCheckPWD() {
        	let pwd = f.pwd.value.trim(); //비밀번호
            let pwd_check = f.pwd_check.value.trim(); //비밀번호 체크
            let c_id = f.c_id.value.trim();
            
            let pwdError = document.getElementById("pwd-error");
            let pwdCheckError = document.getElementById("pwd_check-error");
        	
        	//비밀번호 유효성 체크 정규식
            let pwdCheck = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9!@#$%^&*()\-_=+\\|\[\]{};:'",.<>\/?]{5,20}$/;
            let pwdEmptyCheck = /^\S+$/;
            
            if(pwd == ''){
		        setErrorMessage('pwd-error', '비밀번호를 입력해 주세요', true);
            	return;
            }
            
        	if (pwd != pwd_check) {
		        setErrorMessage('pwd_check-error', '비밀번호가 일치하지 않습니다', true);
                return;
            } else{
            	//비밀번호는 같지만 조건식에 맞지 않을 때 초기화 시켜줌.
                pwdCheckError.textContent = "";
            }
            
            if (pwd == '' || pwd.length < 5 || pwd.length > 20 || !pwdCheck.test(pwd)) {
		        setErrorMessage('pwd-error', '영문 대소문자/특수문자/숫자 중 2가지 조합하여 5~20자', true);
                return;
            } else{
            	//비밀번호가 비어있지 않고 6~19자리 사이에 있을경우 초기화 시켜줌.
                pwdError.textContent = "";
            }
            	//비밀번호 같고 조건 맞으면 비워둠.
	            pwdError.textContent = "";
	            pwdCheckError.textContent = ""
	            isPwdChecked = true;
            
        }//--------------resetAndCheckPWD
        
      //-----------------------------이름 감지하는 ONINPUT함수
        function resetAndCheckNAME() {
            let name = f.name.value.trim(); //이름
        	let nameError = document.getElementById("name-error");
            let nameCheck = /^[가-힣\s]*$/; 
    			
    		if(name == '' || !nameCheck.test(name)){
    			setErrorMessage('name-error', '올바른 이름을 입력해 주세요', true);
    			return;
    		} else if(name.length > 5 ){
    			setErrorMessage('name-error', '이름은 3~4글자 입니다', true);
            	return;
            } else{
    			nameError.textContent = "";
    			isNameChecked = true;
    		}
		}//-----------resetAndCheckNAME
        
        //-------------------------------email 인증 함수 호출 
        
      	function mailCheck(f) {
			let inputEmail = f.inputEmail.value.trim(); //이메일
		    let email_at = '@';
		    let selectEmail = f.selectEmail.value.trim(); //이메일 선택 select
		    let email = inputEmail + email_at + selectEmail; //전체 이메일
     
    		let emailError = document.getElementById("email-error");
    		let emailCheck_Every = /^[a-z0-9]+$/.test(inputEmail);
    		
    		//이메일 유효성 체크
    		if(inputEmail == '' || selectEmail == '' || !emailCheck_Every){
    			setErrorMessage('email-error', '올바른 메일 주소를 입력해 주세요', true);
    			return;
    		}else {
    			emailError.textContent = "";
	    		let url = "mailCheck.do";
	    		let param = "email=" + encodeURIComponent(email);
	    		sendRequest(url, param, checkEmailCertify, "post");
    			return;
    		}
		}

		let res;

		//인증함수 호출 Ajax
		function checkEmailCertify() {
        		let email_check = document.getElementsByName("email_check")[0];
        		let emailError = document.getElementById("email-error");
    		if(xhr.readyState == 4 && xhr.status == 200){
        		let data = xhr.responseText;
        		let json = (new Function('return '+data))();
        		
        		if(json[0].result == "fail"){
	    			setErrorMessage('email-error', '이미 사용 중인 이메일 주소입니다.\n다른 이메일을 입력해 주세요', true);
        			return;
        			
        		} else if(json[0].result == "success"){
	        		alert("인증코드가 입력하신 이메일로 전송 되었습니다.");
	        		email_check.disabled = false;
	        		res = json[0].res;
        		}
    		}
		}//checkEmailCertify

		function check_certify() {
    		let email_check = document.getElementsByName("email_check")[0].value;
    		let emailCheckError = document.getElementById("email_check-error");

    		if(email_check == res){
	    		setErrorMessage('email_check-error', '인증번호가 일치합니다', false);
       		 	isEmailChecked = true;
       		 	isEmailNumberChecked = true;
    		}else{
	    		setErrorMessage('email_check-error', '인증번호가 일치하지 않습니다', true);
       		 	isEmailChecked = false;
       		 	isEmailNumberChecked = false;
    		}
		}
		
        //-----------------------------이메일 감지하는 ONINPUT함수
        function resetAndCheckEmail() {
        	let email_check = document.getElementsByName("email_check")[0];
            let emailCheckError = document.getElementById("email_check-error");
            let emailError = document.getElementById("email-error");
            
            // 경고 메시지 비우기
            emailCheckError.textContent = "";
            emailError.textContent = "";
			// 이메일 입력시 인증번호 input 지우기
            email_check.value = "";
            
            // 인증 상태 초기화
            isEmailChecked = false;
         	// 이메일 인증 번호 상태 초기화
            isEmailNumberChecked = false;
		}
        //-----------------------------이메일 인증 번호 감지하는 ONINPUT함수  
        function resetAndCheckEmailNumber() {
            let emailCheckError = document.getElementById("email_check-error");
            let emailError = document.getElementById("email-error");
			
            // 경고 메시지 비우기
            emailCheckError.textContent = "";
            emailError.textContent = "";
			
            // 인증 상태 초기화
            isEmailChecked = false;
            // 이메일 인증 번호 상태 초기화
            isEmailNumberChecked = false;
		}

        //-----------------------------전화번호 감지하는 ONINPUT함수
		function resetAndCheckTEL() {
	        let tel = f.tel.value.trim(); //전화번호
			let telError = document.getElementById("tel-error");
         	// 숫자만 입력되도록 하고 11자리로 제한
            let filteredTelValue = tel.replace(/[^0-9]/g, '').slice(0, 11);

            // 값이 변경된 경우 업데이트
            if (tel != filteredTelValue) {
                f.tel.value = filteredTelValue;
            }
            
            if(f.tel.value == ''){
            	setErrorMessage('tel-error', '휴대전화 번호를 입력해 주세요', true);
            } else if (tel.length == 10 || tel.length == 11) {
		        tel.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
		    			
			} else if(tel.length < 10 || tel.length > 11){//비어있거나 9자리 이하 12자리 이상일 때
            	setErrorMessage('tel-error', '번호 형식이 올바르지 않습니다', true);
				return;
			}
				telError.textContent = "";
				return;
		}
    </script>
</head>
<body>
    <div class="fixed-top">
        <jsp:include page="<%= includePage %>"/>
    </div>
    <h2 align="center">Eclat de Luxe 회원가입</h2>
    <form name="f">
        <div class="box">
            <div class="text-center">
                <div class="id-input input-group">
                    <input autofocus class="id" name="c_id" placeholder="* 아이디" id="c_id" oninput="resetAndCheckID()">
                    <input type="button" value="중복 확인" class="check_id" onclick="duplicate_checkID(c_id)"></input>
                </div>
                <span id="id-error" class="error-message"></span>
            </div>
            <div class="text-center input-group">
                <input name="pwd" class="pwd" type="password" placeholder="* 비밀번호" oninput="resetAndCheckPWD()">
                <span id="pwd-error" class="error-message"></span>
            </div>
            <div class="text-center input-group">
                <input name="pwd_check" class="password" type="password" placeholder="* 비밀번호 확인" oninput="resetAndCheckPWD()">
                <span id="pwd_check-error" class="error-message"></span>
            </div>
            <div class="text-center input-group">
                <input name="name" class="name" placeholder="* 이름" oninput="resetAndCheckNAME()">
                <span id="name-error" class="error-message"></span>
            </div>
            <div class="text-center input-group">
                <div class="email-container">
                    <input name="inputEmail" class="inputEmail" placeholder="* 이메일" oninput="resetAndCheckEmail()"> 
                    <span>@</span>
                    <select name="selectEmail" class="selectEmail" oninput="resetAndCheckEmail()">
                        <option value="">E-Mail 선택</option>
                        <option value="naver.com">naver.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="nate.com">nate.com</option>
                        <option value="empal.com">empal.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="kakao.com">kakao.com</option>
                    </select> 
                    <input type="button" class="email_checkbtn" onclick="mailCheck(this.form)" value="이메일 인증"></input>
                </div>
                <span id="email-error" class="error-message"></span>
            </div>
            <div class="text-center input-group">
                <input name="email_check" class="email_check" placeholder="인증번호" oninput="resetAndCheckEmailNumber()">
                <input type="button" class="email_checkbtn" value="확인" onclick="check_certify()"></input>
                <span id="email_check-error" class="error-message"></span>
            </div>
            <div class="text-center input-group">
                <input name="tel" class="tel" placeholder="'-'를 제외한 전화번호" maxlength="11" pattern="010[0-9]{7,8}" oninput="resetAndCheckTEL()">
                <span id="tel-error" class="error-message"></span>
            </div>
            <div class="text-center input-group">
                <label for="selectGender" class="gender">성별</label>
                <div class="gender-options">
                    <input type="radio" class="btn-check" name="selectGender" id="btnradio1" autocomplete="off" value="남">
                    <label class="btn male" for="btnradio1">남</label>
                    <input type="radio" class="btn-check" name="selectGender" id="btnradio2" autocomplete="off" value="여">
                    <label class="btn female" for="btnradio2">여</label>
                </div>
            </div>

            <div class="row text-center input-group">
                <input value="가입하기" class="join_btn" type="button" onclick="sendUserJoin(this.form)"></input>
            </div>
        </div>
    </form>
</body>
</html>