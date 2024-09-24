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
    <title>회원정보수정</title>
    
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
      }
      .container {
        max-width: 600px;
        margin: 20px auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }
      h1 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
      }
      .form-group {
        margin-bottom: 15px;
      }
      .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
      }
      .form-group input,
      .form-group select,
      .form-group textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
      }
      .form-group textarea {
        resize: none;
      }
      .form-group button {
        padding: 10px 20px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-right: 10px;
      }
      .form-group button:hover {
        background-color: #0056b3;
      }
      
    </style>

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
 
    <%@ include file="../common.jsp"%>

    <%@ include file="../header.jsp"%>

    <%@ include file="../sidebar.jsp"%>

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
          
            <div class="form-group">
              <label for="name">이름:</label>
              <input
                class="form-control"
                type="text"
                name="member_name"
                value="${member.member_name}"
              />
            </div>
            <div class="form-group">
              <label for="nickname">닉네임:</label>
              <input
                class="form-control"
                type="text"
                name="member_nickname"
                value="${member.member_nickname}"
              />
            </div>
            <div class="form-group">
              <lable for="accountId">아이디:</lable>
              <input
                class="form-control"
                type="text"
                value="${member.member_accountId}"
                readonly
              />
            </div>
            <div class="form-group">
              <label for="password">비밀번호:</label>
              <input
                class="form-control"
                type="password"
                name="member_pwd"
                value="${member.member_pwd}"
              />
            </div>
            <div class="form-group">
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
            <div class="form-group">
              <label for="phone">전화번호:</label>
              <input
                class="form-control"
                type="text"
                name="member_phone"
                oninput="formatPhoneNumber(this);"
                value="${member.member_phone}"
              />
            </div>
            <div class="form-group">
              <lable for="grade">회원등급:</lable>
              <input
                class="form-control"
                type="icon"
                value="${member.member_grade}"
                readonly
              />
            </div>
            <div class="form-group">
              <button type="button" class="btn btn-primary" onclick="send(this.form);">수정</button>
              <button type="button" class="btn btn-primary" onclick="location.href='/member/mypage.do'">취소</button>
            </div>
          
        </form>
      </div>
    </main><!-- End #main -->

  </body>
</html>
