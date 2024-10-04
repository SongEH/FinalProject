<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>라이더 정보</title>

    <!-- Bootstrap 3.x -->
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
      body {
        background-color: #f8f9fa;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }

      .container {
        max-width: 400px;
        margin: 50px auto;
        background-color: #fff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      .header h2 {
        text-align: center;
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 30px;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-label {
        font-size: 14px;
        font-weight: bold;
        color: black;
      }

      .form-control {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        background-color: #f9f9f9;
      }

      .button-group {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
      }

      .button-group input {
        width: 48%;
        padding: 15px;
        background-color: #f0a8d0;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
      }

      .button-group input:hover {
        background-color: #e090b5;
      }

      /* Responsive Styles */
      @media (max-width: 768px) {
        .container {
          padding: 15px;
        }

        .button-group input {
          width: 100%;
          margin-bottom: 10px;
        }
      }
    </style>

    <script>
      function del(raiders_id) {
        if (confirm("정말 삭제 하시겠습니까?") == false) return;
        location.href = "mypage/delete.do?raiders_id=" + raiders_id;
      }
    </script>
  </head>

  <body>
    <input type="hidden" name="raiders_id" value="${rider.raiders_id}" />

    <div class="container">
      <div class="header">
        <h2>라이더 정보</h2>
      </div>

      <div class="form-group">
        <label for="name" class="form-label">이름:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.rider_name}"
          readonly
        />
      </div>

      <div class="form-group">
        <label for="email" class="form-label">이메일:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_email}"
          readonly
        />
      </div>

      <div class="form-group">
        <label for="password" class="form-label">비밀번호:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_pwd}"
          readonly
        />
      </div>

      <div class="form-group">
        <label for="phone" class="form-label">전화번호:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_phone}"
          readonly
        />
      </div>

      <div class="form-group">
        <label for="region" class="form-label">배달지역:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_region}"
          readonly
        />
      </div>

      <div class="button-group">
        <c:if test="(user.raiders_id eq vo.raiders_id)">
          <input
            type="button"
            value="회원 수정"
            onclick="location.href='mypage/modify_form.do?raiders_id=${vo.raiders_id}'"
          />
          <input
            type="button"
            value="내역보기"
            onclick="location.href='mypage/list.do?raiders_id=${vo.raiders_id}'"
          />
          <input
            type="button"
            value="메인이동"
            onclick="location.href='${pageContext.request.contextPath}/riders/delivery'"
          />
          <input
            type="button"
            value="회원 탈퇴"
            onclick="del('${vo.raiders_id}');"
          />
        </c:if>
      </div>
    </div>
  </body>
</html>
