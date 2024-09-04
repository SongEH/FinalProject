<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
	body {
		font-family: Arial, sans-serif;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		margin: 0;
		background-color: #f9f9f9;
	}
	.login-container {
		width: 300px;
		padding: 20px;
		background-color: white;
		border-radius: 8px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		text-align: center;
	}
	.login-container h1 {
		color: #F0A8D0;
		margin-bottom: 20px;
	}
	.login-container input[type="email"], .login-container input[type="password"] {
		width: 100%;
		padding: 10px;
		margin: 10px 0;
		border: 1px solid #ddd;
		border-radius: 4px;
	}
	.login-container button, .login-container .btn {
		width: 100%;
		padding: 10px;
		background-color: #F0A8D0;
		border: none;
		border-radius: 4px;
		color: white;
		font-size: 16px;
		cursor: pointer;
		margin-top: 10px;
	}
	.login-container button:hover, .login-container .btn:hover {
		background-color: #F0A8D0;
	}
	.login-container .link {
		margin-top: 20px;
		font-size: 14px;
	}
	.login-container .link a {
		color: #F0A8D0;
		text-decoration: none;
	}
</style>
<script type="text/javascript">
      function send(f) {
        let riders_email = f.riders_email.value.trim();
        let riders_pwd = f.riders_pwd.value.trim();

        if (riders_email == "") {
          alert("아이디를 입력하세요!!");
          f.riders_email.value = "";
          f.riders_email.focus();
          return;
        }

        if (riders_pwd == "") {
          alert("비밀번호를 입력하세요!!");
          f.riders_pwd.value = "";
          f.riders_pwd.focus();
          return;
        }

        f.action = "login.do"; // MemberLoginAction
        f.submit();
      } //end:send()
    </script>

    <script type="text/javascript">
      //javascript 초기화
      //window.onload = function(){};

      //jQuery 초기화
      $(document).ready(function () {
        //showMessage();
        setTimeout(showMessage, 100); //0.1초후에 메시지 띄워라
      });

      function showMessage() {
        // /member/login_form.do?reason=fail_id => "true"
        if ("${ param.reason == 'fail_id'}" == "true") {
          alert("아이디가 틀립니다");
        }

        // /member/login_form.do?reason=fail_pwd => "true"
        if ("${ param.reason == 'fail_pwd'}" == "true") {
          alert("비밀번호가 틀립니다");
        }

        // /member/login_form.do?reason=session_timeout
        if ("${ param.reason == 'session_timeout'}" == "true") {
          alert("로그아웃되었습니다\n로그인을 해주세요");
        }
      }
    </script>
  </head>
  <body>
    <form
    action="${pageContext.request.contextPath}/riders/login.do"
    method="post">
<div class="login-container">
<h1>RIDER LOGIN</h1>
  <input id="riders_email" type="email" name="riders_email" placeholder="이메일" required>
  <input id="riders_pwd" type="password" name="riders_pwd" placeholder="비밀번호" required>
  <button type="submit" onclick="sendLogin();">로그인</button>

<div class="link">
  <input class="btn btn-info" type="button" value="회원가입" 
  onclick="location.href='insert_form.do'">
</div>
</div>
</form>	
  </body>
</html>