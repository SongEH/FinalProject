<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
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

        <h1>쿠폰리스트</h1>

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
        <th>회원명</th>
              <th>쿠폰 번호</th>
              <th>할인 금액</th>
              <th>발행날짜</th>
              <th>만료날짜</th>
              <th>사용 날짜</th>
      </tr>
          <c:forEach var="coupon" items="${coupon}">
        <tr>
          <td>${coupon.member_name}</td>
                <td>${coupon.coupon_code}</td>
                <td>${coupon.discount_amount}</td>
                <td>${coupon.start_date}</td>
                <td>${coupon.end_date}</td>
                <td>
                  <c:choose>
                    <c:when test="${coupon.used_date != null}">
                      ${coupon.used_date}
                    </c:when>
                    <c:otherwise>Unused</c:otherwise>
                  </c:choose>
	</td>
        </tr>
      </c:forEach>
    </table>
      <c:if test="${empty coupon}">
        <p>발행된 쿠폰이 없습니다.</p>
      </c:if>
    </main><!-- End #main -->

   
  </body>
  </body>
</html>
