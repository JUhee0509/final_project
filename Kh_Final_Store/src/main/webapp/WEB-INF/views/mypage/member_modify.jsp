<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="common.Common"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
      <title>회원 정보 수정</title>
      <script src="/store/resources/js/httpRequest.js"></script>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
   <script>
        let isPwdChecked = false; //비밀번호 인증 확인
        let isNameChecked = false; //이름 인증 확인
        let isEmailChecked = false; //이메일 인증 확인
        let isEmailNumberChecked = false; //이메일 인증번호 확인
        let isTelChecked = false; //휴대폰 번호 확인

        function sendUserModify(f) {
       let c_id = '${vo.c_id}';
        let pwd = f.pwd.value.trim(); //비밀번호
        let pwd_check = f.pwd_check.value.trim(); //비밀번호 체크
        let name = f.name.value.trim(); //이름
            
        let inputEmail = f.inputEmail.value.trim(); //이메일
        let email_at = '@';
        let selectEmail = f.selectEmail.value.trim(); //이메일 선택 select
            
        let email = inputEmail + email_at + selectEmail; //전체 이메일
            
        let email_check = f.email_check.value.trim(); //인증코드
        let tel = f.tel.value.trim(); //전화번호
        
        //경고창을 띄우기 위해 id를 가져오는 코드 
        
        let pwdError = document.getElementById("pwd-error");
        let pwdCheckError = document.getElementById("pwd_check-error");
        let nameError = document.getElementById("name-error");
        let emailError = document.getElementById("email-error");
        let emailCheckError = document.getElementById("email_check-error");
        let telError = document.getElementById("tel-error");
         
      
      //---------------------------------비밀번호 확인 체크
      if(!isPwdChecked){
         pwdError.textContent = "비밀번호를 입력해 주세요";
         return;
      }


      let nameCheck = /^[가-힣\s]*$/; 
        if(name == '' || !nameCheck.test(name)){
           nameError.textContent = "올바른 이름을 입력해 주세요";
           return;
        }

      //---------------------------------이메일 인증 확인 체크
        if(!isEmailChecked){
           emailError.textContent = "이메일 인증확인은 필수에요!";
           return;
        } 
        
        if(!isEmailNumberChecked){
           emailCheckError.textContent = "이메일 인증을 위해 확인 버튼을 눌러주세요!";
           return;
        } 
      
      //---------------------------------전화번호 입력 확인 체크
        
        let tel1 = '';
      
      if(tel != ''){
           if(tel.length < 10 || tel.length > 11){//비어있거나 9자리 이하 12자리 이상일 때
            telError.textContent = "번호 형식이 올바르지 않습니다.";
            return;
         } else if (tel.length == 10 || tel.length == 11) {
              tel1 = tel.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
         }
      }
      
        if(tel == ''){
            if(!confirm("전화번호 정보를 입력하지 않았어요.\n회원수정을 계속 진행할까요?")){
            return;
            } 
        }
        
        //Ajax로 회원가입 성공 띄우기
        let url = "member_modify.do";
        let param = "c_id=" + c_id + "&pwd=" + encodeURIComponent(pwd) + 
               "&name=" + name + "&email=" + encodeURIComponent(email) +
                  "&tel=" + tel1;
        sendRequest(url, param, joinResult, "post");
            
        }//sendUserJoin
        
        //----------------------------회원가입 Ajax joinResult 함수 호출
        function joinResult() {
         if(xhr.readyState == 4 && xhr.status == 200){
            let data = xhr.responseText;
            let json = (new Function('return '+data))();
            
            if(json[0].result == 'success'){
               alert(json[0].name + "님 회원 정보 수정 되었습니다.");
               location.href = "mainPage.do";
               return;
            }
         }
      }
       
        //-----------------------------비밀번호 감지하는 ONINPUT함수
        function resetAndCheckPWD() {
           let pwd = f.pwd.value.trim(); //비밀번호
            let pwd_check = f.pwd_check.value.trim(); //비밀번호 체크
            
            let pwdError = document.getElementById("pwd-error");
            let pwdCheckError = document.getElementById("pwd_check-error");
           
           //비밀번호 유효성 체크 정규식
            let pwdCheck = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9!@#$%^&*()\-_=+\\|\[\]{};:'",.<>\/?]{5,20}$/;
            let pwdEmptyCheck = /^\S+$/;
            
            if(pwd == ''){
              pwdError.textContent = "비밀번호를 입력해 주세요";
               return;
            }
            
           if (pwd != pwd_check) {
                pwdCheckError.textContent = "비밀번호가 일치하지 않습니다";
                return;
            } else{
               //비밀번호는 같지만 조건식에 맞지 않을 때 초기화 시켜줌.
                pwdCheckError.textContent = "";
            }
            
            if (pwd == '' || pwd.length < 5 || pwd.length > 20 || !pwdCheck.test(pwd)) {
                pwdError.textContent = "영문 대소문자/특수문자/숫자 중 2가지 조합하여 5~20자";
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
             nameError.textContent = "올바른 이름을 입력해 주세요";
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
             emailError.textContent = "올바른 메일 주소를 입력해 주세요";
             return;
          }else {
             emailError.textContent = "";
             let url = "modify_user_mailCheck.do";
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
                 emailError.textContent = "가입된 계정의 이메일을 입력해주세요";
                 return;
                 
              } else if(json[0].result == "success"){
                 alert("인증코드가 입력하신 이메일로 전송 되었습니다.");
                 isEmailChecked = true;
                 email_check.disabled = false;
                 res = json[0].res;
              }
              
          }
      }//checkEmailCertify

      function check_certify() {
          let email_check = document.getElementsByName("email_check")[0].value;
          let emailCheckError = document.getElementById("email_check-error");

          if(email_check == res){
                 emailCheckError.textContent = "인증번호가 일치합니다.";
                 isEmailChecked = true;
                 isEmailNumberChecked = true;
          }else{
              emailCheckError.textContent = "인증번호가 일치하지 않습니다.";
          }
      }
      
        //-----------------------------이메일 감지하는 ONINPUT함수
        function resetAndCheckEmail() {
           let email_check = document.getElementsByName("email_check")[0];
            let emailCheckError = document.getElementById("email_check-error");

            // 경고 메시지 비우기
            emailCheckError.textContent = "";

            // 인증 상태 초기화
            isEmailChecked = false;
            // 이메일 인증 번호 상태 초기화
            isEmailNumberChecked = false;
      }

        //-----------------------------전화번호 감지하는 ONINPUT함수
      function resetAndCheckTEL() {
           let tel = f.tel.value.trim(); //전화번호
         let telError = document.getElementById("tel-error");

           if(f.tel.value == ''){
              telError.textContent = "휴대전화 번호를 입력해 주세요.";
            } else if (tel.length == 10 || tel.length == 11) {
              tel.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
                   
         } else if(tel.length < 10 || tel.length > 11){//비어있거나 9자리 이하 12자리 이상일 때
            telError.textContent = "번호 형식이 올바르지 않습니다.";
            return;
         }
            telError.textContent = "";
            return;
      }
    </script>
      <style>
      
      /* 회원가입 정보 경고창 색깔 */
      .error-message {
         color: red;
         font-size: 12px;
      }
      
      .box{width: 500px;
          margin: 0 auto;}
      
      .row{padding: 7px;}
      .fixed-header {position: fixed;
			   			   top: 0;
			               left: 0;
			               width: 100%;
			               background-color: white;
			               z-index: 1000;
			               height: 80px;}
		.data{padding-top: 80px;}
      </style>
   </head>
   
   <body>
	<div class="fixed-header">
        <jsp:include page="<%= includePage %>"/>
    </div>
      <form class="data" name="f">
         <hr>
         <br>
         <div class="text-center box">
            <h1>회원 정보 수정</h1>
            <br>
            <div class="row">
               <div class="col-4">
                  아이디
               </div>
               <div class="col-8">
                  ${vo.c_id}
               </div>
            </div>
            <div class="row">
               <div class="col-4">
                  *비밀번호
               </div>
               <div class="col-8">
                  <input name="pwd" type="password" size="35"
                  placeholder="비밀번호" oninput="resetAndCheckPWD()"> 
                  <br> 
                  <span id="pwd-error" class="error-message"></span> 
               </div>
            </div>
            <div class="row">
               <div class="col-4">
                  *비밀번호 확인
               </div>
               <div class="col-8">
                  <input name="pwd_check" type="password" size="35" 
                  placeholder="비밀번호 확인" oninput="resetAndCheckPWD()">
                  <span id="pwd_check-error" class="error-message"></span>
               </div>
            </div>
            <div class="row">
               <div class="col-4">
                  *이름
               </div>
               <div class="col-8">
                  <input name="name" value="${vo.name }" size="35"
                   oninput="resetAndCheckNAME()" placeholder="*이름"> 
                  <span id="name-error" class="error-message"></span>
               </div>
            </div>
            <div class="row">
               <div class="col-4">
                  *이메일
               </div>
               <div class="col-8">
                  <input name="inputEmail" oninput="resetAndCheckEmail()" value="${vo.email.split('@')[0] }" size="7.5"> 
                  @
                  <select name="selectEmail">
                        <option value="">E-Mail 선택</option>
                        <option value="naver.com" id="naver.com">naver.com</option>
                        <option value="gmail.com" id="gmail.com">gmail.com</option>
                        <option value="nate.com" id="nate.com">nate.com</option>
                        <option value="empal.com" id="empal.com">empal.com</option>
                        <option value="daum.net" id="daum.net">daum.net</option>
                        <option value="hanmail.net" id="hanmail.net">hanmail.net</option>
                        <option value="kakao.com">kakao.com</option>
                  </select> 
                  <input type="button" value="이메일 인증" style="float: right;"
                     onclick="mailCheck(this.form)"> <br> 
                  <span id="email-error" class="error-message"></span>
               </div>
            </div>
            <div class="row">
               <div class="col-4">
                  *인증번호 확인
               </div>
               <div class="col-3">
                  <input name="email_check" size="10" disabled="disabled"
                   placeholder="인증번호" oninput="resetAndCheckEmail()">
               </div>
               <div class="col-5">
                  <input type="button" value="인증번호 확인" onclick="check_certify()">
                  <br> <span id="email_check-error" class="error-message"></span>
               </div>
            </div>
            <div class="row">
               <div class="col-4">
                  전화번호
               </div>
               <div class="col-8">
                  <input name="tel" size="35" placeholder="'-'를 제외한 번호를 입력해주세요" value="${vo.tel}"
                   maxlength="11" pattern="010[0-9]{7,8}" oninput="resetAndCheckTEL()"> <br> 
                  <span id="tel-error" class="error-message"></span>
               </div>
            </div>
            <div class="row">
               <div class="col-4">
                  성별
               </div>
               <div class="col-8">
                  ${ vo.gender }
               </div>
            </div>
         </div>
         <br>
         <div align="center">
            <input type="button" value="수정하기" style="width: 10%;"
               onclick="sendUserModify(this.form)">
         </div>
      </form>
   </body>
</html>