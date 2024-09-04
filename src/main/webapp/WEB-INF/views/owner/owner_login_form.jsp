<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>

    <!--  Bootstrap  3.x  -->
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <script type="text/javascript">
      function send(f) {
        let owner_accountId = f.owner_accountId.value.trim();
        let owner_pwd = f.owner_pwd.value.trim();

        if (owner_accountId == "") {
          alert("아이디를 입력하세요!!");
          f.owner_accountId.value = "";
          f.owner_accountId.focus();
          return;
        }

        if (owner_pwd == "") {
          alert("비밀번호를 입력하세요!!");
          f.owner_pwd.value = "";
          f.owner_pwd.focus();
          return;
        }

        f.action = "login.do";
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
       
        if ("${ param.reason == 'fail_id'}" == "true") {
          alert("아이디가 틀립니다");
        }

        
        if ("${ param.reason == 'fail_pwd'}" == "true") {
          alert("비밀번호가 틀립니다");
        }

        
        if ("${ param.reason == 'session_timeout'}" == "true") {
          alert("로그아웃되었습니다\n로그인을 해주세요");
        }
      }
    </script>
  </head>
  <body>
    <button id="openModal" data-toggle="modal" data-target="#ownerLoginModal">로&nbsp;그&nbsp;인</button>
    <div id="ownerLoginModal" class="modal fade" role="dialog">
      <div class="modal-content">
        <div class="container mx-auto p-6">
        <span class="close-button">&times;</span>
        <h2>로&nbsp;그&nbsp;인</h2>
        <!-- <form id="signupForm"> -->
          <form
				action="${pageContext.request.contextPath}/owner/login_form.do"
				method="post">
          <!-- <input type="hidden" name="member_accountId" id="member_accountId" /> -->
          <input type="hidden" name="url" value="${param.url}">
          <div class="mb-4">
            <label for="owner_accountId">아이디 :</label>
            <input class="form-control"
              type="text"
              name="owner_accountId"
              value="${param.owner_accountId}"
            />
          </div>
          <div class="mb-4">
            <label for="owner_pwd">비밀번호 :</label>
            <input class="form-control"
              type="password"
              name="owner_pwd"
              value="${param.owner_pwd}"
            />
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" onclick="send(this.form);">로그인</button>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>
