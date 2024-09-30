<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
            padding: 0px;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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



    </style>
  </head>
  <body>
 
  <%@ include file="../common.jsp" %>

  <%@ include file="../header.jsp" %>

  <%@ include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">

     <h1>회원정보</h1><br>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">회원관리</li>
          <li class="breadcrumb-item active">회원정보</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    
    
    <div class="container">
      <!-- <input type="hidden" name="member_id" value="${member.member_id}" /> -->
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
      </div>
      <div class="mb-4">
        <lable for="phone">전화번호:</lable>
        <input
          class="form-control"
          type="text"
          value="${member.member_phone}"
          readonly
        />
      </div>
        
      <div class="flex justify-end">
        <c:if test="${user.member_id eq member.member_id}">
          <input style="margin-right: 10px;"
            type="button"
            class="button_style"
            value="회원 수정"
            onclick="location.href='mypage/modify_form.do?member_id=${member.member_id}'"
          />
          <input
            type="button"
            class="button_style"
            value="회원 탈퇴"
            onclick="del('${ member.member_id }');"
          />
        </c:if>
      </div>
    </div>

  </main>

  </body>
</html>
