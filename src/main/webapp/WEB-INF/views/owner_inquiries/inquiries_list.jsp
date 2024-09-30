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
    <title>문의사항 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 0 auto;
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
        .filter {
            text-align: center;
            margin-bottom: 20px;
        }
        .filter a {
            text-decoration: none;
            color: #f0a8d0;
            margin: 0 10px;
            font-size: 16px;
        }
        .filter a.active {
            font-weight: bold;
            color: #e090b5;
        }
        .owner-actions {
            text-align: center;
            margin-bottom: 20px;
        }
        .owner-actions a {
            text-decoration: none;
            padding: 10px 20px;
            color: #fff;
            background-color: #f0a8d0;
            border-radius: 5px;
            font-size: 16px;
        }
        .owner-actions a:hover {
            background-color: #e090b5;
            color: #fff;
        }
        .inquiries-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .inquiries-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .inquiries-title {
            font-size: 18px;
            font-weight: bold;
            flex: 2;
        }
        .inquiries-date {
            flex: 1;
            text-align: center;
            color: #888;
        }
        .inquiries-author {
            flex: 1;
            text-align: right;
            color: #555;
        }
        .inquiries-title a {
            text-decoration: none;
            color: #007bff;
        }
        .inquiries-title a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>


  <%@include file="../common.jsp" %>

  <%@include file="../header.jsp" %>

  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">

      <h1>문의사항</h1>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">공지&문의</li>
          <li class="breadcrumb-item active">문의사항</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    <div class="container">

        <c:if test="${sessionScope.userType == 'OWNER'}">
            <div class="owner-actions">
                <button class="button_style" onclick="location.href='${pageContext.request.contextPath}/owner_inquiries/insert_form.do'">문의사항 등록</button>
            </div>
        </c:if>
       

        <div class="inquiries-list">
            <c:forEach var="inquiries" items="${list}">
                <div class="inquiries-card">
                    <div class="inquiries-title">
                        <a href="${pageContext.request.contextPath}/owner_inquiries/detail.do?o_inquiries_id=${inquiries.o_inquiries_id}">${inquiries.o_inquiries_title}</a>
                        <c:if test="${inquiries.o_answer_content == null}">
                            <span class="badge rounded-pill bg-warning">
                            ❗️미답변 
                            </span>
                        </c:if>
                    </div>
                    <div class="inquiries-date">
                        작성일자: ${inquiries.o_inquiries_cdate}
                    </div>
                    <div class="inquiries-author">
                        작성자: ${inquiries.owner_accountId}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

  </main><!-- End #main -->

</body>
</html>
