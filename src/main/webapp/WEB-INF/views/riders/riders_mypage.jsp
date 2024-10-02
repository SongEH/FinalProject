<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title></title>

    <!-- Bootstrap 5 CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0px;
      }

      h1 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
      }
      .container {
        max-width: 800px;
        margin: auto;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }
      .form-control {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
      }
      .form-control[readonly] {
        background-color: #f9f9f9;
      }
      .mb-4 {
        margin-bottom: 20px;
      }
      .flex {
        display: flex;
        justify-content: flex-end;
      }
      input[type="button"] {
        background-color: #f0a8d0; /* 버튼 배경색 */
        border: none;
        color: #fff;
        padding: 10px 20px;
        margin-left: 10px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
      }
      input[type="button"]:hover {
        background-color: #f7b5ca; /* 버튼 호버 색상 */
      }

      /* 반응형 스타일 */
      @media (max-width: 768px) {
        .login-container {
          padding: 20px; /* 모바일에서 패딩 감소 */
        }
      }

      @media (max-width: 480px) {
        .login-container h1 {
          font-size: 20px; /* 제목 폰트 사이즈 줄임 */
        }

        .login-container input[type="email"],
        .login-container input[type="password"] {
          font-size: 14px; /* 폰트 크기 축소 */
        }

        .login-container button,
        .login-container .btn {
          font-size: 14px; /* 버튼 폰트 사이즈 줄임 */
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
    <h1>라&nbsp;이&nbsp;더&nbsp;정&nbsp;보</h1>
    <div class="container">
      <div class="mb-4">
        <label for="name" class="form-label">이름:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.rider_name}"
          readonly
        />
      </div>

      <div class="mb-4">
        <label for="email" class="form-label">이메일:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_email}"
          readonly
        />
      </div>

      <div class="mb-4">
        <label for="password" class="form-label">비밀번호:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_pwd}"
          readonly
        />
      </div>

      <div class="mb-4">
        <label for="phone" class="form-label">전화번호:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_phone}"
          readonly
        />
      </div>

      <div class="mb-4">
        <label for="region" class="form-label">배달지역:</label>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_region}"
          readonly
        />
      </div>

      <div class="d-flex justify-content-end">
        <c:if test="( user.raiders_id eq vo.raiders_id )">
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
            value="메인이동"
            onclick="location.href='/riders/delivery'"
          />
          <input
            type="button"
            value="회원 탈퇴"
            onclick="del('${ vo.raiders_id }');"
          />
        </c:if>
      </div>
    </div>
  </body>
</html>
