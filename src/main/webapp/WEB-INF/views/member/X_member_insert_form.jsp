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
          url: "check_nickname.do",
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
          url: "check_member_accountId.do",
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
      function formatMmemberPhoneNumber(input) {
          let member_phone = input.value.replace(/\D/g, ''); // 숫자만 남기기
          if (member_phone.length > 11) {
            member_phone = member_phone.slice(0, 10); // 10자리까지만
          }
          if (member_phone.length > 6) {
              input.value = member_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
          } else if (member_phone.length > 3) {
              input.value = member_phone.replace(/(\d{3})(\d{0,3})/, '$1-$2');
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
        let email_id = $("#email_id").val().trim();
        let email_domain = $("#email_domain").val().trim();

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
        var passwordConfirm = $("#member_passwordConfirm").val();
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
    
    <button id="openModal" data-toggle="modal" data-target="#signupModal">
      회&nbsp;원
    </button>
    <div id="signupModal" class="modal fade" role="dialog">
      <div class="modal-content">
      <div class ="container mx-auto p-6">
        <span class="close-button">&times;</span>
        <h2>회&nbsp;원&nbsp;가&nbsp;입</h2>
        <form
          id="signupForm"
          action="${pageContext.request.contextPath}/member/insert_form.do"
          method="post"
        >
          <input type="hidden" name="member_email" id="member_email" />
          <!-- <input type="hidden" name="member_accountId" id="member_accountId" /> -->
          <div class="mb-4">
            <label for="member_name">이름</label>
            <input
              class="form-control"
              type="text"
              id="member_name"
              name="member_name"
            />
          </div>
          <div class="mb-4">
            <label for="member_nickname">닉네임</label>
            <input
              class="form-control"
              type="text"
              id="member_nickname"
              name="member_nickname"
              onkeyup="check_nickname();"
            />
            <span id="nickname_msg" />
          </div>
          <div class="mb-4">
            <label for="member_accountId">아이디</label>
            <input
              class="form-control"
              type="text"
              id="member_accountId"
              name="member_accountId"
              onkeyup="check_id();"
            />
            <span id="id_msg" />
          </div>
          <div class="mb-4">
            <label for="member_pwd">비밀번호</label>
            <input
              class="form-control"
              type="password"
              id="member_pwd"
              name="member_pwd"
            />
          </div>
          <div class="mb-4">
            <label for="member_pwd">비밀번호 확인</label>
            <input
              class="form-control"
              type="password"
              id="passwordConfirm"
              name="member_pwd_confirm"
              onkeyup="passConfirm()"
            />
            <span id="confirmMsg"></span>
          </div>
          <div class="mb-4">
            <label for="member_email"
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
            <label for="member_phone">전화번호</label>
            <input class="form-control" type="text" name="member_phone" id="member_phone" oninput="formatPhoneNumber(this);">
            
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
