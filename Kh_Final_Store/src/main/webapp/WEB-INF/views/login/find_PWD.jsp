<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String includePage = Common.index.VIEW_PATH + "index.jsp"; %>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <script src="/store/resources/js/httpRequest.js"></script>
    <script>
        function find_Pwd(f) {
            let c_id = f.c_id.value;
            let name = f.name.value;
            let inputEmail = f.inputEmail.value.trim();
            let email_at = '@';
            let selectEmail = f.selectEmail.value.trim();
            let email = inputEmail + email_at + selectEmail;
            
            if (c_id === '' || name === '' || inputEmail === '' || selectEmail === '') {
            	alert("올바른 정보를 입력해주세요");
            	return;
            }
            
            let url = "storeUserFindPwd.do";
            let param = "c_id=" + c_id + "&name=" + name + "&email=" + encodeURIComponent(email);
            sendRequest(url, param, userFindPWD, "post");
        }
        
        let res;
        
        function userFindPWD() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let data = xhr.responseText;
                let json = (new Function('return ' + data))();
                if (json[0].result == "c_id_no") {
                	alert("입력한 아이디와 일치하는 정보가 없습니다.");
                    return;
                } else if (json[0].result == "name_no") {
                	alert("입력한 이름과 일치하는 정보가 없습니다.");
                    return;
                } else if (json[0].result == "email_no") {
                	alert("입력한 이메일과 일치하는 정보가 없습니다.");
                    return;
                } else if (json[0].result == "user_exist") {
                    if (json[0].res > 0) {
                        res = json[0].findPWD;
	                	alert("이메일로 임시 비밀번호를 발급하였습니다\n마이페이지에서 비밀번호 수정 바랍니다.");
	                	
		            let form = document.createElement("form");
		            form.setAttribute("method", "post");
		            form.setAttribute("action", "login_main.do");
		
		            let input = document.createElement("input");
		            input.setAttribute("type", "hidden");
		            input.setAttribute("name", "temporaryPassword");
		            input.setAttribute("value", res);
		
		            form.appendChild(input);
		            document.body.appendChild(form);
		            form.submit();
                    }
                }
            }
        }
    </script>
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
            margin: 17px 0;
            box-sizing: border-box;
        }
        input.id, input.name, input.inputEmail {
            border: none;
            border-bottom: 1px solid #ccc;
            outline: none;
            transition: border-color 0.3s ease; /* 부드러운 전환 효과 추가 */
        }
        input.id:hover, input.name:hover, input.inputEmail:hover {
            border-bottom: 1px solid #004d00; /* 마우스 커서가 올라갔을 때 밑줄 색상 변경 */
        }
        .findPWD_btn {
		    background-color: #004d00;
		    color: white;
		    width: 100%;
		    padding: 10px;
		    margin: 10px 0; /* 버튼 상단 간격 동일하게 설정 */
		    border: none;
		    border-radius: 3px;
		    box-shadow: 0 0 5px rgba(255, 255, 255, 0.5); /* 흰색 테두리 추가 */
		}
		.findPWD_btn:hover {
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
		.find_ID {
		    margin-top: 10px;
		}
		.find_ID a {
		    font-size: 12px;
		    text-decoration: none;
		    color: black;
		    display: inline-block;
		}
		.find_ID a:hover {
		    color: #004d00;
		}
    </style>
</head>
<body>
    <div class="fixed-top">
        <jsp:include page="<%= includePage %>"/>
    </div>
		<h2 align="center">비밀번호 찾기</h2>
        <form>
	    <div class="box">
            <div class="text-center">
            	<div>
                	<input type="text" class="id" name="c_id" autofocus placeholder="아이디">
                </div>
            	<div>
	                <input type="text" class="name" name="name" placeholder="이름">
                </div>
                <div class="email-container">
                    <input type="text" class="inputEmail" name="inputEmail" placeholder="이메일">
                    <span>@</span>
                    <select class="selectEmail" name="selectEmail">
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
                <input type="button" class="findPWD_btn" onclick="find_Pwd(this.form)" value="비밀번호 찾기"></input>
            </div>
	    </div>
	    	<div class="find_ID">
                <a href="storeUserFindIDForm.do">아이디를 잊어버리셨나요?</a>
            </div>
        </form>
</body>
</html>
