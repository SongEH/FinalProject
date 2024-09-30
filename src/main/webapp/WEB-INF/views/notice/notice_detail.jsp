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
    <title>공지사항 상세</title>
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
      .notice-detail {
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        background-color: #ffffff;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
      }
      .notice-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
      }
      .notice-date {
        font-size: 14px;
        color: #888;
        margin-bottom: 20px;
      }
      .notice-content {
        font-size: 16px;
        line-height: 1.6;
      }
      .notice-author {
        font-size: 14px;
        color: #555;
        margin-top: 20px;
        text-align: right;
      }
      .back-button {
        display: block;
        width: 150px;
        margin: 20px auto;
        padding: 10px;
        text-align: center;
        font-size: 16px;
        color: #fff;
        background-color: #007bff;
        border-radius: 5px;
        text-decoration: none;
      }
      .back-button:hover {
        background-color: #0056b3;
      }
      .content {
        white-space: pre-wrap; /* 줄 바꿈과 공백을 유지합니다 */
        word-wrap: break-word; /* 긴 단어를 자동으로 줄 바꿈 */
      }
    </style>
    <script type="text/javascript">
      function del(notice_id) {
        if (confirm("정말 삭제 하시겠습니까?") == false) return;

        location.href = "delete.do?notice_id=" + notice_id;
      }
    </script>
  </head>
  <body>
    <%@include file="../common.jsp" %> <%@include file="../header.jsp" %>
    <%@include file="../sidebar.jsp" %>

    <main id="main" class="main">
      <div class="pagetitle">
        <h1>공지사항 상세</h1>

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
        <div class="notice-detail">
          <div class="notice-title">${vo.notice_title}</div>
          <div class="notice-date">${vo.notice_cdate}</div>
          <div class="notice-content">${vo.notice_content}</div>
          <div class="notice-author">작성자: ${vo.adminAccountId}</div>
        </div>

        <button class="button_style"
          onclick="location.href='${pageContext.request.contextPath}/notice/list.do?notice_type=전체'"
          class="back-button"
          >목록으로</button
        >
        <c:if test="${userType == 'ADMIN'}">
          <button
            type="button"
            class="button_style"
            onclick="location.href='${pageContext.request.contextPath}/notice/modify_form.do?notice_id=${vo.notice_id}&notice_type=${vo.notice_type}'"
          >
            수정
          </button>
          <button
            type="button"
            class="button_style"
            onclick="del('${vo.notice_id}');"
          >
            삭제
          </button>
        </c:if>
      </div>
    </main>
    <!-- End #main -->

    <%@include file="../footer.jsp" %>
  </body>
</html>
