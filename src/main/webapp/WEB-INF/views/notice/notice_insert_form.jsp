<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
      .form-group button {
        padding: 10px 20px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
      }
      .form-group button:hover {
        background-color: #0056b3;
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

        if (notice_type == "") {
          alert("유형을 선택하시오");
          f.notice_type.value = "";
          f.notice_type.focus();
          return;
        }

        if (notice_content == "") {
          alert("내용을 입력하시오");
          f.notice_content.value = "";
          f.notice_content.focus();
          return;
        }

        f.action = "/notice/insert.do";
        f.submit();
      }
    </script>
  </head>
  <body>
    <!-- 메시지 표시 -->
    <c:if test="${not empty message}">
      <div class="alert alert-info">${message}</div>
    </c:if>

    <div class="container">
      <h1>공지사항 등록</h1>
      <form
        action="${pageContext.request.contextPath}/notice/insert_form.do"
        method="post"
      >
        <input type="hidden" name="notice_id" value="${vo.notice_id}" />
        <div class="form-group">
          <label for="notice_title">제목</label>
          <input type="text" id="notice_title" name="notice_title" required />
        </div>
        <div class="form-group">
          <label for="notice_type">유형</label>
          <select
            class="select, form-control"
            id="notice_type"
            name="notice_type"
            required
          >
            <option value="전체">전체</option>
            <option value="서비스안내">서비스 안내</option>
            <option value="점검안내">점검 안내</option>
            <option value="약관안내">약관 안내</option>
          </select>
        </div>
        <div class="form-group">
          <label for="notice_content">내용</label>
          <textarea
            id="notice_content"
            name="notice_content"
            rows="5"
            required
          ></textarea>
        </div>
        <div class="form-group">
          <button
            type="button"
            class="btn btn-primary"
            onclick="send(this.form);"
          >
            등록
          </button>
        </div>
      </form>
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
        .form-group button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }
    </style>

    <script type="text/javascript">
        function send(f){
            let notice_title = f.notice_title.value.trim();
            let notice_type = f.notice_title.value.trim();
            let notice_content = f.notice_title.value.trim();

            if(notice_title ==""){
                alert("제목을 입력하시오");
                f.notice_title.value="";
                f.notice_title.focus();
                return;
            }

            if(notice_type ==""){
                alert("유형을 선택하시오");
                f.notice_type.value="";
                f.notice_type.focus();
                return;
            }

            if(notice_content ==""){
                alert("내용을 입력하시오");
                f.notice_content.value="";
                f.notice_content.focus();
                return;
            }

            f.action = "/notice/insert.do";
            f.submit();
        }
    </script>
</head>
<body>

    <!-- 메시지 표시 -->
    <c:if test="${not empty message}">
        <div class="alert alert-info">
            ${message}
        </div>
    </c:if>

    
    <div class="container">
        <h1>공지사항 등록</h1>
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
                <button type="button" class="btn btn-primary" onclick="send(this.form);">
                    등록
                </button>
            </div>
        </form>
    </div>
</body>
>>>>>>> main
</html>
