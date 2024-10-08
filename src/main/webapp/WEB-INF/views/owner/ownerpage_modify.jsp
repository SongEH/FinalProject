<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>사장 정보 수정</title>
    <script type="text/javascript">

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

    <script type="text/javascript">
      function formatPhoneNumber(input) {
        let owner_phone = input.value.replace(/\D/g, ""); 
        if (owner_phone.length > 11) {
          owner_phone = owner_phone.slice(0, 10); 
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
    </script>
    <script type="text/javascript">
      function send(f) {
        let owner_name = f.owner_name.value.trim();
        let owner_pwd = f.owner_pwd.value.trim();
        let owner_email = f.owner_email.value.trim();
        let owner_phone = f.owner_phone.value.trim();
        let owner_license = f.owner_license.value.trim();
        let owner_bankbook = f.owner_bankbook.value.trim();

        if (owner_name == "") {
          alert("이름을 입력하시오");
          f.owner_name.value = "";
          f.owner_name.focus();
          return;
        }

        if (owner_pwd == "") {
          alert("비밀번호를 입력하시오");
          f.owner_pwd.value = "";
          f.owner_pwd.focus();
          return;
        }

        if (owner_email == "") {
          alert("이메일을 입력하시오");
          f.owner_email.value = "";
          f.owner_email.focus();
          return;
        }

        if (owner_phone == "") {
          alert("전화번호를 입력하시오");
          f.owner_phone.value = "";
          f.owner_phone.focus();
          return;
        }

        if (owner_license == "") {
          alert("사업자등록번호를 입력하시오");
          f.owner_license.focus();
          return;
        }

        if (owner_bankbook == "") {
          alert("법인통장번호를 입력하시오");
          f.owner_bankbook.focus();
          return;
        }

        f.action = "modify.do";
        f.submit(); 
      } 
    </script>
  </head>
  <body>

    <%@include file="../common.jsp" %>

    <%@include file="../header.jsp" %>

    <%@include file="../sidebar.jsp" %>

    <main id="main" class="main">
      <div class="pagetitle">

        <h1>사장정보 수정</h1><br>

        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">사장관리</li>
            <li class="breadcrumb-item active">사장정보 수정</li>
          </ol>
        </nav>

      </div>

        
        <input type="hidden" name="owner_id" value="${owner.owner_id}" />
        <div class="container mx-auto p-6">
          <form action="${pageContext.request.contextPath}/owner/ownerpage/modify.do" method="post">
          <div class="mb-4">
            <label for="name">이름:</label>
            <input
              class="form-control"
              type="text"
              name="owner_name"
              value="${owner.owner_name}"
            />
          </div>
          <div class="mb-4">
            <lable for="accountId">아이디:</lable>
            <input
              class="form-control"
              type="text"
              value="${owner.owner_accountId}"
              readonly
            />
          </div>
          <div class="mb-4">
            <label for="password">비밀번호:</label>
            <input
              class="form-control"
              type="password"
              name="owner_pwd"
              value="${owner.owner_pwd}"
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
              name="owner_email"
              value="${owner.owner_email}"
            />
          </div>
          <div class="mb-4">
            <label for="phone">전화번호:</label>
            <input
              class="form-control"
              type="text"
              name="owner_phone"
              oninput="formatPhoneNumber(this);"
              value="${owner.owner_phone}"
            />
          </div>
          <div class="mb-4">
            <lable for="license">사업자등록번호:</lable>
            <input
              class="form-control"
              type="text"
              name="owner_license"
              value="${owner.owner_license}"
            />
          </div>
          <div class="mb-4">
            <lable for="bankbook">법인통장번호:</lable>
            <input
              class="form-control"
              type="text"
              name="owner_bankbook"
              value="${owner.owner_bankbook}"
            />
          </div>
          <div class="flex justify-end">
            <input type="button" class="button_style" value="수정하기" onclick="send(this.form);" />
            <input
              type="button" class="button_style"
              value="돌아가기"
              onclick="location.href='/owner/ownerpage.do'"
            />
          </div>
        </div>
      </form>

    </main>


    
    
  </body>
</html>
