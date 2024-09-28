<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>공지사항 등록</title>
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
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group textarea {
            resize: vertical;
        }
        /* .form-group button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        } */
        .content {
            white-space: pre-wrap; /* 줄 바꿈과 공백을 유지합니다 */
            word-wrap: break-word; /* 긴 단어를 자동으로 줄 바꿈 */
        }
    </style>

    <script type="text/javascript">
      function send(f) {
        let notice_title = f.notice_title.value.trim();
        let notice_type = f.notice_title.value.trim();
        let notice_content = f.notice_title.value.trim();

        if (notice_title == "") {
          alert("제목을 입력하시오");
          f.notice_title.value = "";
          f.notice_title.focus();
          return;
        }
      }
        </script>
<body>
   <%@ include file="../common.jsp" %>

  <%@include file="../header.jsp" %>

  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">

      <h1>공지사항 등록</h1>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active">Layouts</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

   <div class="container">
        
        <form action="${pageContext.request.contextPath}/notice/insert_form.do" method="post">
            <input type="hidden" name="notice_id" value="${vo.notice_id}">
            <div class="form-group">
                <label for="notice_title">제목</label>
                <input type="text" id="notice_title" name="notice_title" required>
            </div>
            <div class="form-group">
                <label for="notice_type">유형</label>
                <select class="select, form-control" id="notice_type" name="notice_type" required>
                    <option value="전체">전체</option>
                    <option value="서비스안내">서비스 안내</option>
                    <option value="점검안내">점검 안내</option>
                    <option value="약관안내">약관 안내</option>
                </select>
            </div>
            <div class="form-group">
                <label for="notice_content">내용</label>
                <textarea id="notice_content" name="notice_content" rows="5" required></textarea>
            </div>
            <div class="form-group">
                <button type="button" class="button_style" onclick="send(this.form);">
                    등록
                </button>
                <button type="button" class="button_style" onclick="location.href='${pageContext.request.contextPath}/notice/list.do'">
                    취소
                </button>
            </div>
        </form>
    </div>

  </main><!-- End #main -->
    
    
</body>
</html>