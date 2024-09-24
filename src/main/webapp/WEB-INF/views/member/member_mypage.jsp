<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title></title>

    <script type="text/javascript">
      function del(member_id) {
        
        if (confirm("정말 탈퇴 하시겠습니까?") == false) return;
        location.href = "mypage/delete.do?member_id=" + member_id;
      }
    </script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .mb-4 {
            margin-bottom: 16px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form-control[readonly] {
            background-color: #f9f9f9;
        }

        .flex {
            display: flex;
            justify-content: flex-end;
        }

        .flex > input {
            margin-left: 10px;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .flex > input:hover {
            background-color: #0056b3;
        }

        input[type="button"] {
            background-color: #28a745; /* Success color */
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="button"]:hover {
            background-color: #218838; /* Darker green */
        }
    </style>
  </head>
  <body>
 
  <%@include file="../common.jsp" %>

  <%@include file="../header.jsp" %>

  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">

      <h1>Form Layouts</h1>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active">Layouts</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    <input type="hidden" name="member_id" value="${member.member_id}" />
    <h1>회&nbsp;원&nbsp;정&nbsp;보</h1>
    <div class="container mx-auto p-6">
      <div class="mb-4">
        <lable for="name">이름:</lable>
        <input
          class="form-control"
          type="text"
          value="${member.member_name}"
          readonly
        />
      </div>
      <div class="mb-4">
        <lable for="nickname">닉네임:</lable>
        <input
          class="form-control"
          type="text"
          value="${member.member_nickname}"
          readonly
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
        <lable for="password">비밀번호:</lable>
        <input
          class="form-control"
          type="password"
          value="${member.member_pwd}"
          readonly
        />
      </div>
      <div class="mb-4">
        <lable for="email">이메일:</lable>
        <input
          class="form-control"
          type="text"
          value="${member.member_email}"
          readonly
        />
        <div class="mb-4">
          <lable for="phone">전화번호:</lable>
          <input
            class="form-control"
            type="text"
            value="${member.member_phone}"
            readonly
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
          <c:if test="${user.member_id eq member.member_id}">
            <input
              type="button"
              value="회원 수정"
              onclick="location.href='mypage/modify_form.do?member_id=${member.member_id}'"
            />
            <input
              type="button"
              value="회원 탈퇴"
              onclick="del('${ member.member_id }');"
            />
          </c:if>
        </div>
      </div>
    </div>

  </main>
  </body>
</html>
