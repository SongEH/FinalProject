<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript">
      function showLoginModal(userType) {
        
        $("#adminLoginModal").modal("hide");
        $("#ownerLoginModal").modal("hide");
        $("#memberLoginModal").modal("hide");

        if (userType === "admin") {
          $("#adminLoginModal").modal("show");
        } else if (userType === "owner") {
          $("#ownerLoginModal").modal("show");
        } else if (userType === "member") {
          $("#memberLoginModal").modal("show");
        }
      }
    </script>

    <script type="text/javascript">
      function admin_send(f) {
        let admin_accountId = f.admin_accountId.value.trim();
        let admin_pwd = f.admin_pwd.value.trim();

        if (admin_accountId == "") {
          alert("아이디를 입력하세요!!");
          f.admin_accountId.value = "";
          f.admin_accountId.focus();
          return;
        }

        if (admin_pwd == "") {
          alert("비밀번호를 입력하세요!!");
          f.admin_pwd.value = "";
          f.admin_pwd.focus();
          return;
        }

        f.action = "/admin/login.do";
        f.submit();
      }
    </script>
    <script type="text/javascript">
      function owner_send(f) {
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

        f.action = "/owner/login.do";
        f.submit();
      }
    </script>
    <script type="text/javascript">
      function member_send(f) {
        let member_accountId = f.member_accountId.value.trim();
        let member_pwd = f.member_pwd.value.trim();

        if (member_accountId == "") {
          alert("아이디를 입력하세요!!");
          f.member_accountId.value = "";
          f.member_accountId.focus();
          return;
        }

        if (member_pwd == "") {
          alert("비밀번호를 입력하세요!!");
          f.member_pwd.value = "";
          f.member_pwd.focus();
          return;
        }

        f.action = "/member/login.do";
        f.submit();
      }
    </script>
    <script>
      $(document).ready(function(){

        setTimeout(showMessage, 100);

      });

      function showMessage(){
        
        if("${param.reason=='pending'}" =="true"){
        alert("관리자로부터 승인이 완료되지 않아 로그인 할 수 없습니다. ")
      }
      }
    </script>
    <style>

      .background-image {
        position: absolute;
        top: 60%;
        left: 46%;
        transform: translate(-50%, -50%);
        opacity: 0.5; 
        z-index: -1; 
        max-width: 100%; 
        height: auto;
      }

      .card-container {
        display: flex;
        justify-content: center;
        gap: 30px; 
      }

      .card {
        width: 18rem;
      }

      .main {
        margin-top: 100px;
      }

    </style>
    
  </head>
  <body>

    <%@include file="common.jsp" %>

    <%@include file="header.jsp" %>

    

    <main id="main" class="main" style="margin: auto; margin-top: 10%;">
    <img
        class="background-image"
        src="/resources/assets/img/notextlogo.png"
        alt="Final Logo"
      />
    <div class="container mt-5">
    
     

      <div class="row">
        <div class="col-md-4">
          <div class="card" style="width: 18rem">
            <div class="card-body">
              <h5 class="card-title">Admin Login</h5>
              <button class="button_style" onclick="showLoginModal('admin')">
                Login as Admin
              </button>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card" style="width: 18rem">
            <div class="card-body">
              <h5 class="card-title">Owner Login</h5>
              <button class="button_style" onclick="showLoginModal('owner')">
                Login as Owner
              </button>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card" style="width: 18rem">
            <div class="card-body">
              <h5 class="card-title">Member Login</h5>
              <button
                class="button_style"
                onclick="showLoginModal('member')"
              >
                Login as Member
              </button>
            </div>
          </div>
        </div>
      </div>

      <div
        class="modal fade"
        id="adminLoginModal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="adminLoginModalLabel"
        aria-hidden="true"
      >
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="adminLoginModalLabel">Admin Login</h5>          
            </div>
            <div class="modal-body">
              <form
                action="${pageContext.request.contextPath}/admin/login_form.do"
                method="post"
              >
                <input type="hidden" name="url" value="${param.url}" />
                <div class="form-group">
                  <label for="admin_accountId">ID:</label>
                  <input
                    type="text"
                    class="form-control"
                    id="admin_accountId"
                    name="admin_accountId"
                    value="${param.admin_accountId}"
                    required
                  />
                </div>
                <div class="form-group">
                  <label for="admin_pwd">Password:</label>
                  <input
                    type="password"
                    class="form-control"
                    id="admin_pwd"
                    name="admin_pwd"
                    value="${param.admin_pwd}"
                    required
                  />
                </div>
                <button
                  type="button"
                  class="button_style"
                  onclick="admin_send(this.form);"
                >
                  로그인
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>

      <div
        class="modal fade"
        id="ownerLoginModal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="ownerLoginModalLabel"
        aria-hidden="true"
      >
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="ownerLoginModalLabel">Owner Login</h5>                  
            </div>
            <div class="modal-body">
              <form
                action="${pageContext.request.contextPath}/owner/login_form.do"
                method="post"
              >
                <input type="hidden" name="url" value="${param.url}" />
                <div class="form-group">
                  <label for="owner_accountId">ID:</label>
                  <input
                    type="text"
                    class="form-control"
                    id="owner_accountId"
                    name="owner_accountId"
                    value="${param.owner_accountId}"
                    required
                  />
                </div>
                <div class="form-group">
                  <label for="owner_pwd">Password:</label>
                  <input
                    type="password"
                    class="form-control"
                    id="owner_pwd"
                    name="owner_pwd"
                    value="${param.owner_pwd}"
                    required
                  />
                </div>
                <button
                  type="button"
                  class="button_style"
                  onclick="owner_send(this.form);"
                >
                  로그인
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>

      <div
        class="modal fade"
        id="memberLoginModal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="memberLoginModalLabel"
        aria-hidden="true"
      >
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="memberLoginModalLabel">
                Member Login
              </h5>
            </div>
            <div class="modal-body">
              <form
                action="${pageContext.request.contextPath}/member/login_form.do"
                method="post"
              >
                <input type="hidden" name="url" value="${param.url}" />
                <div class="form-group">
                  <label for="member_accountId">ID:</label>
                  <input
                    type="text"
                    class="form-control"
                    id="member_accountId"
                    name="member_accountId"
                    value="${param.member_accountId}"
                    required
                  />
                </div>
                <div class="form-group">
                  <label for="member_pwd">Password:</label>
                  <input
                    type="password"
                    class="form-control"
                    id="member_pwd"
                    name="member_pwd"
                    value="${param.member_pwd}"
                    required
                  />
                </div>
                <button
                  type="button"
                  class="button_style"
                  onclick="member_send(this.form);"
                >
                  로그인
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    </main>

  </body>
</html>
