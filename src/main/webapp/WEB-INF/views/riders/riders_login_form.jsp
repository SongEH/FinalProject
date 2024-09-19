<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>

    <script type="text/javascript">
      function send(f) {
        let riders_accountId = f.riders_accountId.value.trim();
        let riders_pwd = f.riders_pwd.value.trim();

        if (riders_accountId == "") {
          alert("아이디를 입력하세요!!");
          f.riders_accountId.value = "";
          f.riders_accountId.focus();
          return;
        }

        if (riders_pwd == "") {
          alert("비밀번호를 입력하세요!!");
          f.riders_pwd.value = "";
          f.riders_pwd.focus();
          return;
        }

        f.action = "login.do"; // ridersLoginAction
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
        // /riders/login_form.do?reason=fail_id => "true"
        if ("${ param.reason == 'fail_id'}" == "true") {
          alert("아이디가 틀립니다");
        }

        // /riders/login_form.do?reason=fail_pwd => "true"
        if ("${ param.reason == 'fail_pwd'}" == "true") {
          alert("비밀번호가 틀립니다");
        }

        // /riders/login_form.do?reason=session_timeout
        if ("${ param.reason == 'session_timeout'}" == "true") {
          alert("로그아웃되었습니다\n로그인을 해주세요");
        }
      }
    </script>
  </head>
  <body>
    <div id="openModal" data-toggle="modal" data-target="#loginModal">로&nbsp;그&nbsp;인</div>
    <div id="loginModal" class="modal fade" role="dialog">
      <div class="modal-content">
        <div class="container mx-auto p-6">
        <span class="close-button">&times;</span>
        <h2>로&nbsp;그&nbsp;인</h2>
        <!-- <form id="signupForm"> -->
          <form
				action="${pageContext.request.contextPath}/riders/login_form.do"
				method="post">
          <!-- <input type="hidden" name="riders_accountId" id="riders_accountId" /> -->
          <input type="hidden" name="url" value="${param.url}">
          <div class="mb-4">
            <label for="riders_accountId">이메일 :</label>
            <input class="form-control"
              type="text"
              name="riders_accountId"
              value="${param.riders_accountId}"
            />
          </div>
          <div class="mb-4">
            <label for="riders_pwd">비밀번호 :</label>
            <input class="form-control"
              type="password"
              name="riders_pwd"
              value="${param.riders_pwd}"
            />
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" onclick="send(this.form);">로그인</button>
            <!-- <input
              type="button"
              value="회원가입"
              onclick="location.href='insert_form.do'"
            />
            <input
              type="button"
              value="로그인"
              onclick="send(this.form);"
            /> -->
          </div>
        </form>
      </div>
    </div>
  </body>
</html>