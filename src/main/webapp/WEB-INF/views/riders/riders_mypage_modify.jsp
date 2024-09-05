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

    <style>
      h1 {
        color: #f0a8d0; /* 연보라색 */
        text-align: center;
        margin-bottom: 30px;
      }

      .container {
        background-color: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        max-width: 600px;
        margin: 0 auto;
      }

      label {
        font-weight: bold;
        color: #f7b5ca; /* 연핑크색 */
      }

      .form-control {
        border: 2px solid #f0a8d0; /* 연보라색 */
        border-radius: 5px;
      }

      .form-check-label {
        color: #f0a8d0;
        margin-right: 10px;
      }

      .form-check-input {
        accent-color: #f0a8d0; /* 체크박스 색상 변경 */
      }

      .buttons {
        display: flex;
        justify-content: center; /* 버튼들을 가운데로 정렬 */
        margin-top: 20px;
      }

      .buttons a,
      .buttons input[type="submit"] {
        background-color: #ffc6c6; /* 살구색 */
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
        background-color: #f7b5ca; /* 연핑크색으로 hover 효과 */
      }

      .buttons a {
        background-color: #f0a8d0; /* 연보라색 */
      }
    </style>

    <script type="text/javascript">
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

      // $(document).ready(function() {
      //   let regions = "${vo.riders_region}".split(",");
      //   regions.forEach(function(region) {
      //     $("input[name='riders_region'][value='" + region + "']").prop("checked", true);
      //   });
      // });
    </script>
  </head>
  <body>
    <h1>회원 정보 수정 여긴 riders_mypage_modify</h1>
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
          <input
            class="form-control"
            type="text"
            name="riders_phone"
            value="${vo.riders_phone}"
          />
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
