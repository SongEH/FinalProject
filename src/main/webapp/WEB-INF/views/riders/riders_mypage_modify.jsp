<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>회원 정보 수정</title>
    <script type="text/javascript">
  function updateRidersRegion() {
    let selectedRegions = [];
    
    // 선택된 체크박스 값을 배열로 수집
    $("input[name='riders_region']:checked").each(function() {
      selectedRegions.push($(this).val());
    });
    
    // 선택된 값을 쉼표로 구분된 문자열로 결합하여 riders_region 필드에 설정
    let riders_region = selectedRegions.join(",");
    $("input[name='riders_region_hidden']").val(riders_region);
  }

  // Form 제출 시 이벤트 처리
  $("form").submit(function(event) {
    updateRidersRegion();
  });

  // 페이지 로드 시 현재 riders_region 값을 체크박스에 반영
  $(document).ready(function() {
    let regions = "${vo.riders_region}".split(",");
    regions.forEach(function(region) {
      $("input[name='riders_region'][value='" + region + "']").prop("checked", true);
    });
  });
</script>
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  </head>
  <body>
    <h1>회원 정보 수정 여긴 riders_mypage_modify</h1>
    <form action="${pageContext.request.contextPath}/riders/mypage/modify.do">
      <input type="hidden" name="riders_region_hidden" value="${vo.riders_region}" />
      <input type="hidden" name="raiders_id" value="${vo.raiders_id}" />
      <div class="container">
        <div class="mb-4">
          <label for="name">이름:</label>
          <input
            class="form-control"
            type="text"
            name="riders_name"
            value="${vo.riders_name}"
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
          <label for="riders_region">배달지역:</label>
         
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
        <!-- <div class="mb-4">
          <label for="riders_region">배달지역:</label>
          <input
            class="form-control"
            type="text"
            name="riders_region"
            value="${vo.riders_region}"
          />
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
        </div> -->

        <div class="flex justify-end">
          <input type="submit" value="수정하기" />
        </div>
      </div>
    </form>
    <a href="../mypage.do">취소</a>
  </body>
</html>
