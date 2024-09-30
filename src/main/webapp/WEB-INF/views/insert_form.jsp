<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Insert title here</title>
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript">
      function showSignupModal(userType) {
        // Hide all modals

        $("#ownerLoginModal").modal("hide");
        $("#memberLoginModal").modal("hide");

        // Show the selected modal
        if (userType === "owner") {
          $("#ownerSignupModal").modal("show");
        } else if (userType === "member") {
          $("#memberSignupModal").modal("show");
        }
      }
    </script>

    <!-- owner singup -->
    <script type="text/javascript">
      function check_owner_accountId() {
        //회원가입 버튼은 비활성화
        // <input id="btn_register" type="button" ...  disabled="disabled">
        $("#btn_register").prop("disabled", true);

        //           document.getElementById("mem_id").value
        let owner_accountId = $("#owner_accountId").val();

        if (owner_accountId.length == 0) {
          $("#owner_accountId_msg").html("");
          return;
        }

        if (owner_accountId.length < 5) {
          $("#owner_accountId_msg")
            .html("아이디는 5자리 이상 입력하세요")
            .css("color", "red");
          return;
        }

        $.ajax({
          url: "/owner/check_owner_accountId.do",
          data: {
            owner_accountId: owner_accountId,
          },
          dataType: "json",
          success: function (res_data) {
            if (res_data.result) {
              $("#owner_accountId_msg")
                .html("사용가능한 아이디 입니다")
                .css("color", "blue");

              $("#btn_register").prop("disabled", false);
            } else {
              $("#owner_accountId_msg")
                .html("이미 사용중인 아이디 입니다")
                .css("color", "red");
            }
          },
          error: function (err) {
            alert(err.responseText);
          },
        });
      } //end:check_nickname()

      // 전화번호 포맷팅 함수
      function formatOwnerPhoneNumber(input) {
        let owner_phone = input.value.replace(/\D/g, ""); // 숫자만 남기기
        if (owner_phone.length > 11) {
          owner_phone = owner_phone.slice(0, 10); // 10자리까지만
        }
        if (owner_phone.length > 6) {
          input.value = owner_phone.replace(
            /(\d{3})(\d{4})(\d{4})/,
            "$1-$2-$3"
          );
        } else if (owner_phone.length > 3) {
          input.value = owner_phone.replace(/(\d{3})(\d{0,3})/, "$1-$2");
        } else {
          input.value = owner_phone;
        }
      }

      // 사업자등록번호 포맷팅 함수
      function formatOwnerLicense(input) {
        let owner_license = input.value.replace(/\D/g, ""); // 숫자만 남기기
        if (owner_license.length > 10) {
          owner_license = owner_license.slice(0, 10); // 10자리까지만
        }
        if (owner_license.length > 6) {
          input.value = owner_license.replace(
            /(\d{3})(\d{2})(\d{5})/,
            "$1-$2-$3"
          );
        } else if (owner_license.length > 3) {
          input.value = owner_license.replace(/(\d{3})(\d{0,3})/, "$1-$2");
        } else {
          input.value = owner_license;
        }
      }

      function owner_send(f) {
        let owner_name = f.owner_name.value.trim();
        let owner_accountId = f.owner_accountId.value.trim();
        let owner_pwd = f.owner_pwd.value.trim();
        let owner_phone = f.owner_phone.value.trim();
        let email_id = $("#owner_email_id").val().trim();
        let email_domain = $("#owner_email_domain").val().trim();
        let owner_license = f.owner_license.value.trim();
        let bank_name = $("#bank_name").val().trim();
        let bank_number = $("#bank_number").val().trim();

        if (owner_name == "") {
          alert("이름을 입력하시오");
          f.owner_name.value = "";
          f.owner_name.focus();
          return;
        }

        if (owner_accountId == "") {
          alert("아이디을 입력하시오");
          f.owner_accountId.value = "";
          f.owner_accountId.focus();
          return;
        }

        if (owner_pwd == "") {
          alert("비밀번호를 입력하시오");
          f.owner_pwd.value = "";
          f.owner_pwd.focus();
          return;
        }

        if (owner_phone == "") {
          alert("전화번호를 입력하시오");
          f.owner_phone.focus();
          return;
        }

        if (owner_license == "") {
          alert("사업자등록번호를 입력하시오");
          f.owner_license.focus();
          return;
        }

        let owner_email = email_id + "@" + email_domain;
        $("#owner_email").val(owner_email); // email 필드가 있는지 확인하세요
        // alert(owner_email);

        let owner_bankbook = bank_name + "\n" + bank_number;
        $("#owner_bankbook").val(owner_bankbook);

        f.action = "/owner/insert.do";
        f.submit(); //전송
      }
    </script>

    <script type="text/javascript">
      function setOwnerEmailDomain(domain) {
        // '직접입력'을 선택한 경우, 도메인 입력 필드를 비웁니다.
        if (domain === "직접입력") {
          document.getElementById("owner_email_domain").value = "";
        } else {
          // 선택된 도메인 값을 도메인 입력 필드에 설정합니다.
          document.getElementById("owner_email_domain").value = domain;
        }
      }
    </script>

    <script type="text/javascript">
      function setOwnerBank(bank) {
        if (bank === "직접입력") {
          document.getElementById("bank_name").value = "";
        } else {
          // 선택된 도메인 값을 도메인 입력 필드에 설정합니다.
          document.getElementById("bank_name").value = bank;
        }
      }
    </script>

    <script type="text/javascript">
      /* 자바 스크립트 함수 선언(비밀번호 확인) */

      function owner_passConfirm() {
        var password = $("#owner_pwd").val();
        var passwordConfirm = $("#owner_confirmPwd").val();
        var confirmMsg = $("#owner_confirmMsg");
        var correctColor = "blue";
        var wrongColor = "red";

        if (password === passwordConfirm) {
          confirmMsg.css("color", correctColor);
          confirmMsg.html("비밀번호 일치");
        } else {
          confirmMsg.css("color", wrongColor);
          confirmMsg.html("비밀번호 불일치");
        }
      }
    </script>

    <!-- Member Script -->
    <script type="text/javascript">
      function check_member_nickname() {
        //회원가입 버튼은 비활성화
        // <input id="btn_register" type="button" ...  disabled="disabled">
        $("#btn_register").prop("disabled", true);

        //           document.getElementById("mem_id").value
        let member_nickname = $("#member_nickname").val();

        if (member_nickname.length == 0) {
          $("#member_nickname_msg").html("");
          return;
        }

        if (member_nickname.length < 3) {
          $("#member_nickname_msg")
            .html("닉네임는 3자리 이상 입력하세요")
            .css("color", "red");
          return;
        }

        $.ajax({
          url: "/member/check_member_nickname.do",
          data: {
            member_nickname: member_nickname,
          },
          dataType: "json",
          success: function (res_data) {
            if (res_data.result) {
              $("#member_nickname_msg")
                .html("사용가능한 닉네임 입니다")
                .css("color", "blue");

              $("#btn_register").prop("disabled", false);
            } else {
              $("#member_nickname_msg")
                .html("이미 사용중인 닉네임 입니다")
                .css("color", "red");
            }
          },
          error: function (err) {
            alert(err.responseText);
          },
        });
      }

      function check_member_accountId() {
        //회원가입 버튼은 비활성화
        // <input id="btn_register" type="button" ...  disabled="disabled">
        $("#btn_register").prop("disabled", true);

        //           document.getElementById("mem_id").value
        let member_accountId = $("#member_accountId").val();

        if (member_accountId.length == 0) {
          $("#member_accountId_msg").html("");
          return;
        }

        if (member_accountId.length < 5) {
          $("#member_accountId_msg")
            .html("아이디는 5자리 이상 입력하세요")
            .css("color", "red");
          return;
        }

        $.ajax({
          url: "/member/check_member_accountId.do",
          data: {
            member_accountId: member_accountId,
          },
          dataType: "json",
          success: function (res_data) {
            if (res_data.result) {
              $("#member_accountId_msg")
                .html("사용가능한 아이디 입니다")
                .css("color", "blue");

              $("#btn_register").prop("disabled", false);
            } else {
              $("#member_accountId_msg")
                .html("이미 사용중인 아이디 입니다")
                .css("color", "red");
            }
          },
          error: function (err) {
            alert(err.responseText);
          },
        });
      }

      // 전화번호 포맷팅 함수
      function formatMemberPhoneNumber(input) {
        let member_phone = input.value.replace(/\D/g, ""); // 숫자만 남기기
        if (member_phone.length > 11) {
          member_phone = member_phone.slice(0, 10); // 10자리까지만
        }
        if (member_phone.length > 6) {
          input.value = member_phone.replace(
            /(\d{3})(\d{4})(\d{4})/,
            "$1-$2-$3"
          );
        } else if (member_phone.length > 3) {
          input.value = member_phone.replace(/(\d{3})(\d{0,3})/, "$1-$2");
        } else {
          input.value = member_phone;
        }
      }

      function member_send(f) {
        let member_name = f.member_name.value.trim();
        let member_nickname = f.member_nickname.value.trim();
        let member_accountId = f.member_accountId.value.trim();
        let member_pwd = f.member_pwd.value.trim();
        let member_phone = f.member_phone.value.trim();
        let email_id = $("#member_email_id").val().trim();
        let email_domain = $("#member_email_domain").val().trim();

        if (member_name == "") {
          alert("이름을 입력하시오");
          f.member_name.value = "";
          f.member_name.focus();
          return;
        }

        if (member_nickname == "") {
          alert("닉네임을 입력하시오");
          f.member_nickname.value = "";
          f.member_nickname.focus();
          return;
        }

        if (member_accountId == "") {
          alert("아이디을 입력하시오");
          f.member_accountId.value = "";
          f.member_accountId.focus();
          return;
        }

        if (member_pwd == "") {
          alert("비밀번호를 입력하시오");
          f.member_pwd.value = "";
          f.member_pwd.focus();
          return;
        }

        if (member_phone == "") {
          alert("전화번호를 입력하시오");
          f.member_phone.focus();
          return;
        }

        let member_email = email_id + "@" + email_domain;
        $("#member_email").val(member_email); // email 필드가 있는지 확인하세요

        alert(member_email);

        f.action = "/member/insert.do"; //MemberInsertAction
        f.submit(); //전송
      } //end:send()
    </script>

    <script type="text/javascript">
      function setMemberEmailDomain(domain) {
        // '직접입력'을 선택한 경우, 도메인 입력 필드를 비웁니다.
        if (domain === "직접입력") {
          document.getElementById("member_email_domain").value = "";
        } else {
          // 선택된 도메인 값을 도메인 입력 필드에 설정합니다.
          document.getElementById("member_email_domain").value = domain;
        }
      }
    </script>

    <script type="text/javascript">
      /* 자바 스크립트 함수 선언(비밀번호 확인) */

      function member_passConfirm() {
        var password = $("#member_pwd").val();
        var passwordConfirm = $("#member_confirmPwd").val();
        var confirmMsg = $("#member_confirmMsg");
        var correctColor = "blue";
        var wrongColor = "red";

        if (password === passwordConfirm) {
          confirmMsg.css("color", correctColor);
          confirmMsg.html("비밀번호 일치");
        } else {
          confirmMsg.css("color", wrongColor);
          confirmMsg.html("비밀번호 불일치");
        }
      }
    </script>
  </head>
  <body>

    <%@include file="common.jsp" %>

    <%@include file="header.jsp" %>

    

    <main id="main" class="main">

    <div class="container mt-4">
      
      <div class="row">
        <div class="col-md-4">
          <div class="card" style="width: 18rem">
            <!-- <img class="card-img-top" src="owner.jpg" alt="Owner Login" /> -->
            <div class="card-body">
              <h5 class="card-title">Owner Singup</h5>
              <button
                class="button_style"
                onclick="showSignupModal('owner')"
              >
                Sign Up as Owner
              </button>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card" style="width: 18rem">
            <!-- <img class="card-img-top" src="owner.jpg" alt="Owner Login" /> -->
            <div class="card-body">
              <h5 class="card-title">Member Singup</h5>
              <button
                class="button_style"
                onclick="showSignupModal('member')"
              >
                Sign Up as Member
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Owner Signup Modal -->
    <div
      class="modal fade"
      id="ownerSignupModal"
      tabindex="-1"
      role="dialog"
      aria-labelledby="ownerSignupModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="ownerSignupModalLabel">Owner Signup</h5>          
          </div>
          <div class="modal-body">
            <form
              action="${pageContext.request.contextPath}/insert_form.do"
              method="post"
            >
              <input type="hidden" name="owner_email" id="owner_email" />
              <input type="hidden" name="owner_bankbook" id="owner_bankbook" />
              <div class="form-group">
                <label for="owner_name">이름:</label>
                <input
                  type="text"
                  class="form-control"
                  id="owner_name"
                  name="owner_name"
                  required
                />
              </div>
              <div class="form-group">
                <label for="owner_accountId">아이디:</label>
                <input
                  type="text"
                  class="form-control"
                  id="owner_accountId"
                  name="owner_accountId"
                  onkeyup="check_owner_accountId();"
                  required
                />
                <span id="owner_accountId_msg" />
              </div>
              <div class="form-group">
                <label for="owner_pwd">비밀번호:</label>
                <input
                  type="password"
                  class="form-control"
                  id="owner_pwd"
                  name="owner_pwd"
                  required
                />
              </div>
              <div class="form-group">
                <label for="owner_confirmPwd">비밀번호 확인:</label>
                <input
                  type="password"
                  class="form-control"
                  id="owner_confirmPwd"
                  name="owner_confirmPwd"
                  onkeyup="owner_passConfirm()"
                  required
                />
                <span id="owner_confirmMsg"></span>
              </div>
              <div class="form-group row">
                <label for="owner_email" class="col-form-label">이메일<span class="em_red">*</span></label>
                <div class="col-sm-4">
                  <input
                    class="form-control"
                    type="text"
                    id="owner_email_id"
                    name="owner_email_id"
                    value=""
                    title="이메일 아이디"
                    maxlength="18"
                    required
                  />
                </div>
                @
                <div class="col-sm-4">
                  <input
                    class="form-control"
                    type="text"
                    id="owner_email_domain"
                    name="owner_email_domain"
                    value=""
                    title="이메일 도메인"
                    maxlength="18"
                    required
                  />
                </div>
                <div class="col-sm-3">
                  <select
                    class="form-control"
                    title="이메일 도메인 주소 선택"
                    onclick="setOwnerEmailDomain(this.value);return false;"
                  >
                    <option value="직접입력">-선택-</option>
                    <option value="naver.com">naver.com</option>
                    <option value="google.com">google.com</option>
                    <option value="hanmail.net">hanmail.net</option>
                    <option value="daum.net">daum.net</option>
                    <option value="kakao.com">kakao.com</option>
                    <option value="nate.com">nate.com</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label for="owner_phone">전화번호</label>
                <input
                  class="form-control"
                  type="text"
                  name="owner_phone"
                  id="owner_phone"
                  required
                  oninput="formatOwnerPhoneNumber(this);"
                />
              </div>
              <div class="form-group">
                <label for="owner_license">사업자등록번호</label>
                <input
                  class="form-control"
                  type="text"
                  name="owner_license"
                  id="owner_license"
                  required
                  oninput="formatOwnerLicense(this);"
                />
              </div>
              <div class="form-group row">
                <label for="owner_bankbook">법인통장번호</label>
                <div class="col-sm-3">
                  <input
                    class="form-control"
                    type="text"
                    id="bank_name"
                    name="bank_name"
                    value=""
                    title="은행"
                    required
                  />
                </div>
                <div class="col-sm-6">
                  <input
                    class="form-control"
                    type="text"
                    id="bank_number"
                    name="bank_number"
                    title="은행계좌번호"
                    maxlength="12"
                    required
                  />
                </div>
                <div class="col-sm-3">
                  <select
                    class="form-control"
                    title="은행선택"
                    onclick="setOwnerBank(this.value);return false;"
                  >
                    <option value="은행선택">-선택-</option>
                    <option value="농협">농협</option>
                    <option value="기업">기업</option>
                    <option value="하나">하나</option>
                    <option value="국민">국민</option>
                    <option value="신한">신한</option>
                    <option value="카카오뱅크">카카오뱅크</option>
                  </select>
                </div>
              </div>
              <button
                type="button"
                class="button_style"
                onclick="location.href='/main/display.do'"
              >
                메인화면
              </button>
              <button
                type="button"
                class="button_style"
                onclick="owner_send(this.form);"
              >
                가입하기
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- MemberSignup -->

    <div
      class="modal fade"
      id="memberSignupModal"
      tabindex="-1"
      role="dialog"
      aria-labelledby="memberSignupModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="memberSignupModalLabel">
              Member Signup
            </h5>
          </div>
          <div class="modal-body">
            <form
              action="${pageContext.request.contextPath}/insert_form.do"
              method="post"
            >
              <input type="hidden" name="member_email" id="member_email" />
              <div class="form-group">
                <label for="member_name">이름:</label>
                <input
                  class="form-control"
                  type="text"
                  id="member_name"
                  name="member_name"
                  required
                />
              </div>
              <div class="form-group">
                <label for="member_nickname">닉네임:</label>
                <input
                  class="form-control"
                  type="text"
                  id="member_nickname"
                  name="member_nickname"
                  onkeyup="check_member_nickname();"
                  required
                />
                <span id="member_nickname_msg" />
              </div>
              <div class="form-group">
                <label for="member_accountId">아이디:</label>
                <input
                  type="text"
                  class="form-control"
                  id="member_accountId"
                  name="member_accountId"
                  onkeyup="check_member_accountId();"
                  required
                />
                <span id="member_accountId_msg" />
              </div>
              <div class="form-group">
                <label for="member_pwd">비밀번호:</label>
                <input
                  type="password"
                  class="form-control"
                  id="member_pwd"
                  name="member_pwd"
                  required
                />
              </div>
              <div class="form-group">
                <label for="member_confirmPwd">비밀번호 확인:</label>
                <input
                  type="password"
                  class="form-control"
                  id="member_confirmPwd"
                  name="member_confirmPwd"
                  onkeyup="member_passConfirm()"
                  required
                />
                <span id="member_confirmMsg"></span>
              </div>
              <div class="form-group row">
                <label for="member_email"
                  >이메일<span class="em_red">*</span></label
                >
                <div class="col-sm-4">
                  <input
                    class="form-control"
                    type="text"
                    id="member_email_id"
                    name="member_email_id"
                    value=""
                    title="이메일 아이디"
                    maxlength="18"
                    required
                  />
                </div>
                @
                <div class="col-sm-4">
                  <input
                    class="form-control"
                    type="text"
                    id="member_email_domain"
                    name="member_email_domain"
                    value=""
                    title="이메일 도메인"
                    maxlength="18"
                    required
                  />
                </div> 
                <div class="col-sm-3">
                  <select
                    class="select, form-control"
                    title="이메일 도메인 주소 선택"
                    onclick="setMemberEmailDomain(this.value);return false;"
                  >
                    <option value="직접입력">-선택-</option>
                    <option value="naver.com">naver.com</option>
                    <option value="google.com">google.com</option>
                    <option value="hanmail.net">hanmail.net</option>
                    <option value="daum.net">daum.net</option>
                    <option value="kakao.com">kakao.com</option>
                    <option value="nate.com">nate.com</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label for="member_phone">전화번호</label>
                <input
                  class="form-control"
                  type="text"
                  name="member_phone"
                  id="member_phone"
                  required
                  oninput="formatMemberPhoneNumber(this);"
                />
              </div>

              <button
                type="button"
                class="button_style"
                onclick="location.href='/main/display.do'"
              >
                메인화면
              </button>
              <button
                type="button"
                class="button_style"
                onclick="member_send(this.form);"
              >
                가입하기
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
    </main>
    <!-- end -->
  </body>
</html>
