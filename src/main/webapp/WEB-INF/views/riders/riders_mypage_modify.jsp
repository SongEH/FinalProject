<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />

    <title>회원 정보 수정</title>
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
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

      mb-4 {
        margin-bottom: 16px;
      }

      .container {
        max-width: 800px;
        margin: auto;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      label {
        font-weight: bold;
        color: black; /* 연핑크색 */
        margin-bottom: 5px;
      }

      .form-control {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
      }

      .form-check-label {
        color: black;
        margin-right: 10px;
      }

      .form-check-input {
        accent-color: black; /* 체크박스 색상 변경 */
      }

      .buttons {
        display: flex;
        justify-content: center; /* 버튼들을 가운데로 정렬 */
        margin-top: 20px;
      }

      .buttons a,
      .buttons input[type="submit"] {
        background-color: #f0a8d0; /* 살구색 */
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        cursor: pointer;
        font-size: 16px;
        text-align: center;
        text-decoration: none;
        margin: 0 10px;
      }

      .buttons input[type="submit"]:hover,
      .buttons a:hover {
        background-color: #f0a8d0; /* 연핑크색으로 hover 효과 */
      }

      .buttons a {
        background-color: #f0a8d0; /* 연보라색 */
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

    <script type="text/javascript">
      function formatPhoneNumber(input) {
        let riders_phone = input.value.replace(/\D/g, ""); // 숫자만 남기기
        if (riders_phone.length > 11) {
          riders_phone = riders_phone.slice(0, 10); // 10자리까지만
        }
        if (riders_phone.length > 6) {
          input.value = riders_phone.replace(
            /(\d{3})(\d{4})(\d{4})/,
            "$1-$2-$3"
          );
        } else if (riders_phone.length > 3) {
          input.value = riders_phone.replace(/(\d{3})(\d{0,3})/, "$1-$2");
        } else {
          input.value = riders_phone;
        }
      }

      function updateRidersRegion() {
        let selectedRegions = [];
        $("input[name='riders_region']:checked").each(function () {
          selectedRegions.push($(this).val());
        });
        let riders_region = selectedRegions.join(",");
        $("input[name='riders_region_hidden']").val(riders_region);
      }

      $("form").submit(function (event) {
        updateRidersRegion();
      });

      $(document).ready(function () {
        let regions = "${vo.riders_region}".split(",");
        regions.forEach(function (region) {
          $("input[name='riders_region'][value='" + region + "']").prop(
            "checked",
            true
          );
        });
      });
    </script>
  </head>
  <body>
    <h1>라이더 정보</h1>
    <form action="${pageContext.request.contextPath}/riders/mypage/modify.do">
      <input
        type="hidden"
        name="riders_region_hidden"
        value="${vo.riders_region}"
      />
      <input type="hidden" name="raiders_id" value="${vo.raiders_id}" />
      <div class="container">
        <div class="mb-4">
          <label for="name">이름:</label>
          <input
            class="form-control"
            type="text"
            name="rider_name"
            value="${vo.rider_name}"
            disabled
          />
        </div>

        <div class="mb-4">
          <label for="email">이메일:</label>
          <input
            class="form-control"
            type="text"
            name="riders_email"
            value="${vo.riders_email}"
            disabled
          />
        </div>

        <div class="mb-4">
          <label for="password">비밀번호:</label>
          <input
            class="form-control"
            type="password"
            name="riders_pwd"
            value="${vo.riders_pwd}"
          />
        </div>

        <div class="mb-4">
          <label for="phone">전화번호:</label>
          <input class="form-control" type="text" name="riders_phone"
          value="${vo.riders_phone}" <<<<<<< HEAD
          oninput="formatPhoneNumber(this);"
        </div>

        <div class="mb-4">
          <label for="riders_region">배달지역 수정:</label>
          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="checkbox"
              id="inlineCheckbox1"
              name="riders_region"
              value="서울"
            />
            <label class="form-check-label" for="inlineCheckbox1">서울</label>
          </div>
          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="checkbox"
              id="inlineCheckbox2"
              name="riders_region"
              value="경기"
            />
            <label class="form-check-label" for="inlineCheckbox2">경기</label>
          </div>
          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="checkbox"
              id="inlineCheckbox3"
              name="riders_region"
              value="인천"
            />
            <label class="form-check-label" for="inlineCheckbox3">인천</label>
          </div>
        </div>

        <div class="buttons">
          <a href="../mypage.do">취소</a>
          <input type="submit" value="수정하기" />
        </div>
      </div>
    </form>
  </body>
</html>
