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
    <title>Member List</title>
    
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
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }

      h1 {
        text-align: center;
        color: #333;
      }

      input[type="button"] {
        background-color: #5cb85c;
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s;
      }

      input[type="button"]:hover {
        background-color: #4cae4c;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }

      table, th, td {
        border: 1px solid #ddd;
      }

      th, td {
        padding: 12px;
        text-align: left;
      }

      th {
        background-color: #f2f2f2;
      }

      tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      tr:hover {
        background-color: #f1f1f1;
      }

      
    </style>

  </head>
  <body>

    <%@include file="../common.jsp" %>

    <%@include file="../header.jsp" %>

    <%@include file="../sidebar.jsp" %>

    <main id="main" class="main">
      <div class="pagetitle">

        <h1>회원리스트</h1>

        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">관리자페이지</li>
            <li class="breadcrumb-item active">회원리스트</li>
          </ol>
        </nav>

      </div><!-- End Page Title -->

      <table border="1">
      <tr>
        <th>번호</th>
        <th>이름</th>
        <th>닉네임</th>
        <th>아이디</th>
        <th>이메일</th>
        <th>전화번호</th>
        <th>삭제</th>
      </tr>
      <c:forEach var="member" items="${member_list}">
        <tr>
          <td>${member.member_id}</td>
          <td>${member.member_name}</td>
          <td>${member.member_nickname}</td>
          <td>${member.member_accountId }</td>
          <td>${member.member_email}</td>
          <td>${member.member_phone}</td>
          <td>
            <button class="button_style" onclick="location.href='/admin/delete_member.do?member_id='+'${member.member_id}'">Delete</button>
          </td>
        </tr>
      </c:forEach>
    </table>
      
    </main><!-- End #main -->

   
  </body>
</html>
