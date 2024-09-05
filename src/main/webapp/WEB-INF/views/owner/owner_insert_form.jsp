<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Insert title here</title>
    <!--  Bootstrap  3.x  -->
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">
      function check_id() {
        //회원가입 버튼은 비활성화
        // <input id="btn_register" type="button" ...  disabled="disabled">
        $("#btn_register").prop("disabled", true);

        //           document.getElementById("mem_id").value
        let owner_accountId = $("#owner_accountId").val();

        if (owner_accountId.length == 0) {
          $("#id_msg").html("");
          return;
        }

        if (owner_accountId.length < 5) {
          $("#id_msg")
            .html("아이디는 5자리 이상 입력하세요")
            .css("color", "red");
          return;
        }

        $.ajax({
          url: "check_id.do",
          data: {
            owner_accountId: owner_accountId,
          },
          dataType: "json",
          success: function (res_data) {
            if (res_data.result) {
              $("#id_msg")
                .html("사용가능한 아이디 입니다")
                .css("color", "blue");

              $("#btn_register").prop("disabled", false);
            } else {
              $("#id_msg")
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
      function formatPhoneNumber(input) {
          let owner_phone = input.value.replace(/\D/g, ''); // 숫자만 남기기
          if (owner_phone.length > 11) {
            owner_phone = owner_phone.slice(0, 10); // 10자리까지만
          }
          if (owner_phone.length > 6) {
              input.value = owner_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
          } else if (owner_phone.length > 3) {
              input.value = owner_phone.replace(/(\d{3})(\d{0,3})/, '$1-$2');
          } else {
              input.value = owner_phone;
          }
      }

      // 사업자등록번호 포맷팅 함수
      function formatLicense(input) {
          let owner_license = input.value.replace(/\D/g, ''); // 숫자만 남기기
          if (owner_license.length > 10) {
            owner_license = owner_license.slice(0, 10); // 10자리까지만
          }
          if (owner_license.length > 6) {
              input.value = owner_license.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');
          } else if (owner_license.length > 3) {
              input.value = owner_license.replace(/(\d{3})(\d{0,3})/, '$1-$2');
          } else {
              input.value = owner_license;
          }
      }

      function send(f) {
        let owner_name = f.owner_name.value.trim();
        let owner_accountId = f.owner_accountId.value.trim();
        let owner_pwd = f.owner_pwd.value.trim();
        let owner_phone = f.owner_phone.value.trim();
        let email_id = $("#email_id").val().trim();
        let email_domain = $("#email_domain").val().trim();
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

        f.action = "insert.do"; 
        f.submit(); //전송
      } //end:send()
    </script>

    <script type="text/javascript">
      function setEmailDomain(domain) {
        // '직접입력'을 선택한 경우, 도메인 입력 필드를 비웁니다.
        if (domain === "직접입력") {
          document.getElementById("email_domain").value = "";
        } else {
          // 선택된 도메인 값을 도메인 입력 필드에 설정합니다.
          document.getElementById("email_domain").value = domain;
        }
      }

      function setBank(bank) {
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

      function passConfirm() {
        var password = $("#owner_pwd").val();
        var passwordConfirm = $("#passwordConfirm").val();
        var confirmMsg = $("#confirmMsg");
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
    <button id="openModal" data-toggle="modal" data-target="#signupModal">
        사&nbsp;장
      </button>
      <div id="signupModal" class="modal fade" role="dialog">
        <div class="modal-content">
        <div class ="container mx-auto p-6">
          <span class="close-button">&times;</span>
          <h2>사&nbsp;장&nbsp;회&nbsp;원&nbsp;가&nbsp;입</h2>
          <form
            id="signupForm"
            action="${pageContext.request.contextPath}/owner/insert_form.do"
            method="post"
          >
            <input type="hidden" name="owner_email" id="owner_email" />
            <input type="hidden" name="owner_bankbook" id="owner_bankbook" />
              <div class="mb-4">
              <label for="owner_name">이름</label>
              <input
                class="form-control"
                type="text"
                id="owner_name"
                name="owner_name"
              />
            </div>
            <div class="mb-4">
              <label for="owner_accountId">아이디</label>
              <input
                class="form-control"
                type="text"
                id="owner_accountId"
                name="owner_accountId"
                onkeyup="check_id();"
              />
              <span id="id_msg" />
            </div>
            <div class="mb-4">
              <label for="owner_pwd">비밀번호</label>
              <input
                class="form-control"
                type="password"
                id="owner_pwd"
                name="owner_pwd"
              />
            </div>
            <div class="mb-4">
              <label for="owner_pwd">비밀번호 확인</label>
              <input
                class="form-control"
                type="password"
                id="passwordConfirm"
                name="owner_pwd_confirm"
                onkeyup="passConfirm()"
              />
              <span id="confirmMsg"></span>
            </div>
            <div class="mb-4">
              <label for="owner_email"
                >이메일<span class="em_red">*</span></label
              >
              <input
                class="form-control"
                type="text"
                id="email_id"
                name="email_id"
                value=""
                title="이메일 아이디"
                maxlength="18"
              />
              @
              <input
                class="form-control"
                type="text"
                id="email_domain"
                name="email_domain"
                value=""
                title="이메일 도메인"
                maxlength="18"
              />
              <select
                class="select, form-control"
                title="이메일 도메인 주소 선택"
                onclick="setEmailDomain(this.value);return false;"
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
            <div class="mb-4">
              <label for="owner_phone">전화번호</label>
              <input class="form-control" type="text" name="owner_phone" id="owner_phone" oninput="formatPhoneNumber(this);">
            </div>
            <div class="mb-4">
                <label for="owner_license">사업자등록번호</label>
                <input class="form-control" type="text" name="owner_license"
                id="owner_license" oninput="formatLicense(this);">
            </div>
            <div class="mb-4">
                <label for="owner_bankbook">법인통장번호</label>
                <input class="form-control" type="text" id="bank_name" name="bank_name" value="" title="은행">
                <select class="select, form-control" title="은행선택" onclick="setBank(this.value);return false;">
                  <option value="은행선택">-선택-</option>
                  <option value="농협">농협</option>
                  <option value="기업">기업</option>
                  <option value="하나">하나</option>
                  <option value="국민">국민</option>
                  <option value="신한">신한</option>
                  <option value="카카오뱅크">카카오뱅크</option>
                </select>
                <input class="form-control" type="text" id="bank_number" name="bank_number" title="은행계좌번호" maxlength="12">
            </div>
            <div class="flex justify-end">
              <button type="button" onclick="location.href='../main.do'">메인화면</button>
              <button type="button" class="btn btn-primary" onclick="send(this.form);">가입하기</button>
            </div>
          </form>
        </div>
      </div>
  </body>
</html>
