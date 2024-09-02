<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>회원 정보 수정</title>

    <script type="text/javascript">
      function formatPhoneNumber(input) {
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
    </script>
    <script type="text/javascript">
      function send(f) {
        let member_name = f.member_name.value.trim();
        let member_nickname = f.member_nickname.value.trim();
        let member_pwd = f.member_pwd.value.trim();
        let member_email = f.member_email.value.trim();
        let member_phone = f.member_phone.value.trim();

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

        if (member_pwd == "") {
          alert("비밀번호를 입력하시오");
          f.member_pwd.value = "";
          f.member_pwd.focus();
          return;
        }

        if (member_email == "") {
          alert("이메일을 입력하시오");
          f.member_email.value = "";
          f.member_email.focus();
          return;
        }

        if (member_phone == "") {
          alert("전화번호를 입력하시오");
          f.member_phone.focus();
          return;
        }

        f.action = "modify.do";
        f.submit(); //전송
      } //end:send()
    </script>
  </head>
  <body>
    <h1>회원 정보 수정</h1>
    <form
      action="${pageContext.request.contextPath}/member/mypage/modify.do"
      method="post"
    >
      <input type="hidden" name="member_id" value="${member.member_id}" />
      <div class="container mx-auto p-6">
        <div class="mb-4">
          <label for="name">이름:</label>
          <input
            class="form-control"
            type="text"
            name="member_name"
            value="${member.member_name}"
          />
        </div>
        <div class="mb-4">
          <label for="nickname">닉네임:</label>
          <input
            class="form-control"
            type="text"
            name="member_nickname"
            value="${member.member_nickname}"
          />
        </div>
        <div class="mb-4">
          <lable for="accountId">아이디:</lable>
          <input
            class="form-control"
            type="text"
            value="${member.member_accountId}"
            readonly
          />
        </div>
        <div class="mb-4">
          <label for="password">비밀번호:</label>
          <input
            class="form-control"
            type="password"
            name="member_pwd"
            value="${member.member_pwd}"
          />
        </div>
        <div class="mb-4">
          <label for="email"
            >이메일:
            <span class="em_red">*</span>
          </label>
          <input
            class="form-control"
            type="text"
            name="member_email"
            value="${member.member_email}"
          />
        </div>
        <div class="mb-4">
          <label for="phone">전화번호:</label>
          <input
            class="form-control"
            type="text"
            name="member_phone"
            oninput="formatPhoneNumber(this);"
            value="${member.member_phone}"
          />
        </div>
        <div class="mb-4">
          <lable for="grade">회원등급:</lable>
          <input
            class="form-control"
            type="icon"
            value="${member.member_grade}"
            readonly
          />
        </div>
        <div class="flex justify-end">
          <input type="button" value="수정하기" onclick="send(this.form);" />
          <input
            type="button"
            value="돌아가기"
            onclick="location.href='/member/mypage.do'"
          />
        </div>
      </div>
    </form>
  </body>
</html>
