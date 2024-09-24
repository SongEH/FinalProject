<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>회원정보수정</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .pagetitle h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .mb-4 {
            margin-bottom: 16px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="password"],
        input[type="icon"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        input[type="button"] {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin-right: 10px;
        }
        input[type="button"]:hover {
            background-color: #0056b3;
        }
        .em_red {
            color: red;
        }
        .flex {
            display: flex;
            justify-content: flex-end;
        }
        .breadcrumb {
            padding: 8px 15px;
            background: #e9ecef;
            border-radius: 5px;
            list-style: none;
            display: flex;
            gap: 5px;
        }
        .breadcrumb-item a {
            text-decoration: none;
            color: #007bff;
        }
        .breadcrumb-item.active {
            color: #6c757d;
        }
    </style>
  </head>
  <body>
 
    <%@include file="../common.jsp" %>

    <%@include file="../header.jsp" %>

    <%@include file="../sidebar.jsp" %>

    <main id="main" class="main">
      <div class="pagetitle">

        <h1>회원정보수정</h1>

        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">Forms</li>
            <li class="breadcrumb-item active">Layouts</li>
          </ol>
        </nav>

      </div><!-- End Page Title -->
      <div class="container">
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
      </div>
    </main><!-- End #main -->

  </body>
</html>
