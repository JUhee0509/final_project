<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta>
    <title>관리자 아이디 찾기</title>
    <style>
        body {
		    text-align: center;
		    font-family: Arial, sans-serif;
		}
		.box {
		    width: 350px;
		    margin: 0 auto;
		    padding-top: 20px;
		    text-align: center;
		}
		input {
		    width: 100%;
		    padding: 10px;
		    margin: 17px 0; /* 동일한 간격 설정 */
		    box-sizing: border-box;
		}
		input.name, input.inputEmail {
		    border: none;
		    border-bottom: 1px solid #ccc;
		    outline: none;
		    transition: border-color 0.3s ease; /* 부드러운 전환 효과 추가 */
		}
		input.name:hover, input.inputEmail:hover {
		    border-bottom: 1px solid #004d00; /* 마우스 커서가 올라갔을 때 밑줄 색상 변경 */
		}
		.findId_btn {
		    background-color: #004d00;
		    color: white;
		    width: 100%;
		    padding: 10px;
		    margin: 10px 0; /* 버튼 상단 간격 동일하게 설정 */
		    border: none;
		    border-radius: 3px;
		    box-shadow: 0 0 5px rgba(255, 255, 255, 0.5); /* 흰색 테두리 추가 */
		}
		.findId_btn:hover {
            background-color: #003a00;
        }
		.email-container {
		    display: flex;
		    align-items: center;
		    justify-content: space-between;
		}
		.inputEmail {
		    width: 45%; /* 이메일 입력 크기를 절반으로 줄임 */
		}
		.selectEmail {
		    border: none; /* 테두리 없앰 */
		    border-bottom: 1px solid #ccc;
		    outline: none;
		    padding: 0 0 7px 5px;
		    background-color: transparent; /* 배경색 투명 */
		    transition: border-color 0.3s ease; /* 부드러운 전환 효과 추가 */
		    width: 45%;
		    margin-top: 13px;
		}
		.selectEmail:hover {
		    border-bottom: 1px solid #004d00; /* 마우스 커서가 올라갔을 때 밑줄 색상 변경 */
		}
		.find_PWD {
		    margin-top: 10px;
		}
		.find_PWD a {
		    font-size: 12px;
		    text-decoration: none;
		    color: black;
		    display: inline-block;
		}
		.find_PWD a:hover {
		    color: #004d00;
		}
    </style>
    <script src="/store/resources/js/httpRequest.js"></script>
    <script>
        function findID(f) {
            let inputEmail = f.inputEmail.value.trim();
            let email_at = '@';
            let selectEmail = f.selectEmail.value.trim();
            let name = f.name.value;
            let email = inputEmail + email_at + selectEmail;
            
            if(inputEmail == '' || selectEmail == '' || name == ''){
				alert("올바른 정보를 입력해주세요.");
            	return;
            }
            
            let url = "AdminFindId.do";
            let param = "name=" + name + "&email=" + encodeURIComponent(email);
            sendRequest(url, param, adminFindID, "post");
        }
        
        function adminFindID() {
            if(xhr.readyState == 4 && xhr.status == 200){
                let data = xhr.responseText;
                let json = (new Function('return '+ data))();
                if(json[0].result == 'email_no'){
					alert("입력한 이메일과 일치한 정보가 없습니다.");
                	return;
                } else if(json[0].result == 'user_no'){
					alert("입력한 이름과 일치한 정보가 없습니다.");
                    return;
                } else if(json[0].result == 'user_yes'){
                	location.href = "Admin_show_Name_ID.do?email="+json[0].email;
                }
            }
        }
        
    </script>
</head>
<body>
    <div class="fixed-top">
        <jsp:include page="<%= includePage %>"/>
    </div>
      	<h2 align="center">관리자 아이디 찾기</h2>
        <form>
	    <div class="box">
            <div class="text-center">
            	<div>
                	<input type="text" class="name" name="name" autofocus placeholder="이름">
                </div>
                <div class="email-container">
                    <input type="text" class="inputEmail" name="inputEmail" placeholder="이메일">
                    <span>@</span>
                    <select id="selectEmail" name="selectEmail" class="selectEmail">
                        <option value="">E-Mail 선택</option>
                        <option value="naver.com">naver.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="nate.com">nate.com</option>
                        <option value="empal.com">empal.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="kakao.com">kakao.com</option>
                    </select>
                </div>
            </div>
            <div class="row text-center">
                <input type="button" class="findId_btn" onclick="findID(this.form)" value="아이디 찾기"></input>
            </div>
	    </div>
	    	<div class="find_PWD">
                <a href="admin_find_PWD.do">비밀번호를 잊어버리셨나요?</a>
            </div>
        </form>

</body>
</html>
