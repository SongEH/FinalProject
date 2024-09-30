<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>공지사항 목록</title>
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
        color: #007bff;
        margin: 0 10px;
        font-size: 16px;
      }
      .filter a.active {
        font-weight: bold;
        color: #ff5733;
      }
      .admin-actions {
        text-align: center;
        margin-bottom: 20px;
      }
      .admin-actions a {
        text-decoration: none;
        padding: 10px 20px;
        color: #fff;
        background-color: #007bff;
        border-radius: 5px;
        font-size: 16px;
      }
      .admin-actions a:hover {
        background-color: #0056b3;
      }
      .notice-list {
        display: flex;
        flex-direction: column;
        gap: 10px;
      }
      .notice-card {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        background-color: #ffffff;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
      }
      .notice-title {
        font-size: 18px;
        font-weight: bold;
        flex: 2;
      }
      .notice-date {
        flex: 1;
        text-align: center;
        color: #888;
      }
      .notice-author {
        flex: 1;
        text-align: right;
        color: #555;
      }
      .notice-title a {
        text-decoration: none;
        color: #007bff;
      }
      .notice-title a:hover {
        text-decoration: underline;
      }
    </style>
  </head>
  <body>
    <%@include file="../common.jsp" %> <%@include file="../header.jsp" %>
    <%@include file="../sidebar.jsp" %>

    <main id="main" class="main">
      <div class="pagetitle">
        <h1>공지사항</h1>

        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">공지&문의</li>
            <li class="breadcrumb-item active">공지사항</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <div class="container">
        <input type="hidden" id="notice_type" value="${vo.notice_type}" />

        <div class="filter">
          <a
            href="${pageContext.request.contextPath}/notice/list.do?notice_type=전체"
            class="${notice_type == '전체' ? 'active' : ''}"
            >전체</a
          >
          <a
            href="${pageContext.request.contextPath}/notice/list.do?notice_type=서비스안내"
            class="${notice_type == '서비스안내' ? 'active' : ''}"
            >서비스 안내</a
          >
          <a
            href="${pageContext.request.contextPath}/notice/list.do?notice_type=점검안내"
            class="${notice_type == '점검안내' ? 'active' : ''}"
            >점검 안내</a
          >
          <a
            href="${pageContext.request.contextPath}/notice/list.do?notice_type=약관안내"
            class="${notice_type == '약관안내' ? 'active' : ''}"
            >약관 안내</a
          >
        </div>

        <!-- 관리자 전용 액션 버튼 -->
        <c:if test="${userType == 'ADMIN'}">
          <div class="admin-actions">
            <button class="button_style" onclick="location.href='${pageContext.request.contextPath}/notice/insert_form.do'"
              >공지사항 등록</button
            >
          </div>
        </c:if>

        <div class="notice-list">
          <c:forEach var="notice" items="${list}">
            <div class="notice-card">
              <div class="notice-title">
                <a
                  href="${pageContext.request.contextPath}/notice/detail.do?notice_id=${notice.notice_id}"
                  >${notice.notice_title}</a
                >
              </div>
              <div class="notice-date">작성일자: ${notice.notice_cdate}</div>
              <div class="notice-author">작성자: ${notice.adminAccountId}</div>
            </div>
          </c:forEach>
        </div>
      </div>
    </main>
    <!-- End #main -->

    <%@include file="../footer.jsp" %>
  </body>
</html>
