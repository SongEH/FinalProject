<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>회원 정보 수정</title>

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
      }

      .container {
        max-width: 400px;
        margin: 50px auto;
        background-color: #fff;
        padding: 30px;
        border-radius: 10px;
      }

      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
      }

      .header h2 {
        margin: 0;
        font-size: 18px;
        font-weight: bold;
      }

      .form-group label {
        font-size: 14px;
        font-weight: bold;
        color: black;
      }

      .form-control {
        border-radius: 5px;
        height: 45px;
      }

      .button-group {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
      }

      .button-group button {
        width: 48%;
        padding: 15px;
        background-color: #f0a8d0;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
      }

      .button-group button:hover {
        background-color: #e090b5;
      }

      .form-check-input {
        accent-color: black;
      }
    </style>

    <script type="text/javascript">
      function formatPhoneNumber(input) {
        let riders_phone = input.value.replace(/\D/g, "");
        if (riders_phone.length > 11) {
          riders_phone = riders_phone.slice(0, 10);
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
    <form
      action="${pageContext.request.contextPath}/riders/mypage/modify.do"
      method="post"
    >
      <input
        type="hidden"
        name="riders_region_hidden"
        value="${vo.riders_region}"
      />
      <input type="hidden" name="raiders_id" value="${vo.raiders_id}" />

      <div class="container">
        <div class="header">
          <h2>회원 정보 수정</h2>
        </div>

        <div class="form-group">
          <label for="rider_name">이름:</label>
          <input
            class="form-control"
            type="text"
            name="rider_name"
            value="${vo.rider_name}"
          />
        </div>

        <div class="form-group">
          <label for="riders_email">이메일:</label>
          <input
            class="form-control"
            type="text"
            name="riders_email"
            value="${vo.riders_email}"
            disabled
          />
        </div>

        <div class="form-group">
          <label for="riders_pwd">비밀번호:</label>
          <input
            class="form-control"
            type="password"
            name="riders_pwd"
            value="${vo.riders_pwd}"
          />
        </div>

        <div class="form-group">
          <label for="riders_phone">전화번호:</label>
          <input
            class="form-control"
            type="text"
            name="riders_phone"
            value="${vo.riders_phone}"
            oninput="formatPhoneNumber(this);"
          />
        </div>

        <div class="form-group">
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
          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="checkbox"
              id="inlineCheckbox4"
              name="riders_region"
              value="대전"
            />
            <label class="form-check-label" for="inlineCheckbox4">대전</label>
          </div>
          <div class="form-check form-check-inline">
            <input
              class="form-check-input"
              type="checkbox"
              id="inlineCheckbox5"
              name="riders_region"
              value="부산"
            />
            <label class="form-check-label" for="inlineCheckbox5">부산</label>
          </div>
        </div>

        <div class="button-group">
          <button type="button" onclick="location.href='../mypage.do'">
            취소
          </button>
          <button type="submit">수정하기</button>
        </div>
      </div>
    </form>
  </body>
</html>
