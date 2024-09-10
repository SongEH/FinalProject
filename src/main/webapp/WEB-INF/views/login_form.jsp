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
        // Hide all modals
        $("#adminLoginModal").hide();
        $("#ownerLoginModal").hide();
        $("#memberLoginModal").hide();

        // Show the selected modal
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
  </head>
  <body>
    <div class="container mt-5">
      <h2>Login Page</h2>
      <div class="row">
        <div class="col-md-4">
          <div class="card" style="width: 18rem">
            <!-- <img class="card-img-top" src="admin.jpg" alt="Admin Login" /> -->
            <div class="card-body">
              <h5 class="card-title">Admin Login</h5>
              <button class="btn btn-primary" onclick="showLoginModal('admin')">
                Login as Admin
              </button>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card" style="width: 18rem">
            <!-- <img class="card-img-top" src="owner.jpg" alt="Owner Login" /> -->
            <div class="card-body">
              <h5 class="card-title">Owner Login</h5>
              <button class="btn btn-primary" onclick="showLoginModal('owner')">
                Login as Owner
              </button>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card" style="width: 18rem">
            <!-- <img class="card-img-top" src="member.jpg" alt="Member Login" /> -->
            <div class="card-body">
              <h5 class="card-title">Member Login</h5>
              <button
                class="btn btn-primary"
                onclick="showLoginModal('member')"
              >
                Login as Member
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Admin Login Modal -->
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
              <button
                type="button"
                class="close"
                data-dismiss="modal"
                aria-label="Close"
              >
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <form
                action="${pageContext.request.contextPath}/login_form.do"
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
                  class="btn btn-primary"
                  onclick="admin_send(this.form);"
                >
                  로그인
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>

      <!-- Owner Login Modal -->
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
              <button
                type="button"
                class="close"
                data-dismiss="modal"
                aria-label="Close"
              >
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <form
                action="${pageContext.request.contextPath}/login_form.do"
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
                  class="btn btn-primary"
                  onclick="owner_send(this.form);"
                >
                  로그인
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>

      <!-- Member Login Modal -->
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
              <button
                type="button"
                class="close"
                data-dismiss="modal"
                aria-label="Close"
              >
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <form
                action="${pageContext.request.contextPath}/login_form.do"
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
                  class="btn btn-primary"
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
  </body>
</html>
