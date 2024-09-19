<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
    </style>
    <script type="text/javascript">
      function del(notice_id) {
        if (confirm("정말 삭제 하시겠습니까?") == false) return;

        location.href = "delete.do?notice_id=" + notice_id;
      }
    </script>
  </head>
  <body>
    <div class="container">
      <h1>공지사항 상세</h1>

      <div class="notice-detail">
        <div class="notice-title">${vo.notice_title}</div>
        <div class="notice-date">${vo.notice_cdate}</div>
        <div class="notice-content">${vo.notice_content}</div>
        <div class="notice-author">작성자: ${vo.adminAccountId}</div>
      </div>

      <a
        href="${pageContext.request.contextPath}/notice/list.do?notice_type=전체"
        class="back-button"
        >목록으로</a
      >
      <c:if test="${userType == 'ADMIN'}">
        <button
          type="button"
          class="btn btn-primary"
          onclick="location.href='${pageContext.request.contextPath}/notice/modify_form.do?notice_id=${vo.notice_id}&notice_type=${vo.notice_type}'"
        >
          수정
        </button>
        <button
          type="button"
          class="btn btn-primary"
          onclick="del('${vo.notice_id}');"
        >
          삭제
        </button>
      </c:if>
    </div>
  </body>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
    </style>
    <script type="text/javascript">
        function del(notice_id) {
            
            if (confirm("정말 삭제 하시겠습니까?") == false) return;

            
            location.href = "delete.do?notice_id=" + notice_id;
        }
    </script>
</head>
<body>
    
    <div class="container">
        <h1>공지사항 상세</h1>

        <div class="notice-detail">
            <div class="notice-title">
                ${vo.notice_title}
            </div>
            <div class="notice-date">
                ${vo.notice_cdate}
            </div>
            <div class="notice-content">
                ${vo.notice_content}
            </div>
            <div class="notice-author">
                작성자: ${vo.adminAccountId}
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/notice/list.do?notice_type=전체" class="back-button">목록으로</a>
        <c:if test="${userType == 'ADMIN'}">
            <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/notice/modify_form.do?notice_id=${vo.notice_id}&notice_type=${vo.notice_type}'">수정</button>
            <button type="button" class="btn btn-primary" onclick="del('${vo.notice_id}');">삭제</button>
        </c:if>
    </div>
</body>
>>>>>>> main
</html>
