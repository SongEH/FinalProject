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
    <title>가게목록</title>
    
    <style>
     body {
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

        <h1>가게목록</h1><br>

        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">관리자페이지</li>
            <li class="breadcrumb-item active">가게목록</li>
          </ol>
        </nav>

      </div><!-- End Page Title -->

      <table border="1">
      <tr>
        <th>번호</th>
        <th>상호명</th>
        <th>주소</th>
        <th>전화번호</th>
        <th>사장이름</th>
        <th>삭제</th>
      </tr>
      <c:forEach var="shop" items="${shop_list}">
        <tr>
          <td>${shop.shop_id}</td>
          <td>${shop.shop_name}</td>
          <td>${shop.shop_addr1}</td>
          <td>${shop.shop_call }</td>
          <td>${shop.owner_name}</td>
          <td>
            <button class="button_style" onclick="location.href='delete_shop.do?shop_id=${shop.shop_id}'">Delete</button>
          </td>
        </tr>
      </c:forEach>
    </table>
      
    </main><!-- End #main -->

   
  </body>
</html>
