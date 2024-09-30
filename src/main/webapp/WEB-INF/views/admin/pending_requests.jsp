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
    <title>승인 요청 사장 리스트</title>
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

      <h1>승인 요청 사장 리스트</h1>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">관리자페이지</li>
          <li class="breadcrumb-item active">승인 요청 사장 리스트</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    <table border="1">
      <thead>
        <tr>
          <th>사장 번호</th>
          <th>사장 이름</th>
          <th>사장 아이디</th>
          <th>이메일</th>
          <th>전화번호</th>
          <th>사업자등록번호</th>
          <th>승인 상태</th>
          <th>승인</th>
          <th>거절</th>
        </tr>
      </thead>

      <tbody>
        <c:forEach var="request" items="${requests}">
          <tr>
            <td>${request.owner_id}</td>
            <td>${request.owner_name}</td>
            <td>${request.owner_accountId}</td>
            <td>${request.owner_email}</td>
            <td>${request.owner_phone}</td>
            <td>${request.owner_license}</td>
            <td>${request.approval_status}</td>
            <td>
              <button class="button_style"
                onclick="location.href='${pageContext.request.contextPath}/admin/approve_request.do?owner_id='+'${request.owner_id}'"
                >승인</button
              >
            </td>
            <td>
              <button class="button_style"
              onclick="location.href='${pageContext.request.contextPath}/admin/reject_request.do?owner_id='+'${request.owner_id}'"
                >거절</button
              >
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

  </main><!-- End #main -->
    
  </body>
</html>
