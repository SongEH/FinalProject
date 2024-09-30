<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Insert title here</title>

    <!--  Bootstrap  3.x  -->
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
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

      

      .password-info {
          font-size: 12px;
          color: black;
          background-color: #f1f3f5;
          padding: 10px;
          border-radius: 5px;
          margin-top: 10px;
      }

      .password-visibility {
          position: absolute;
          right: 15px;
          top: 15px;
          cursor: pointer;
          color: black;
      }

      .title {
          font-size: 18px;
          font-weight: bold;
          margin-bottom: 20px;
      }

      .button-group {
          display: flex;
          justify-content: space-between;
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
          background-color: #f0a8d0;
      }

      .location-select,
      .method-select {
          margin-bottom: 20px;
      }

      .options {
          display: flex;
          flex-wrap: wrap;
          gap: 10px;
      }

      .options button {
          background-color: #f0a8d0;
          border: 1px solid #f0a8d0;
          border-radius: 5px;
          padding: 10px;
          cursor: pointer;
      }

      .options button.selected {
          background-color: #f0a8d0;
          border-color: #f0a8d0;
      }
  </style>
  <style>
    .button_style {
      background-color: #f0a8d0;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      padding: 10px 15px;
    } 
  
    .button_style:hover {
      background-color: #e090b5;
    }
  </style>
    <script type="text/javascript">
     
      // 전화번호 포맷팅 함수
      function formatPhoneNumber(input) {
          let riders_phone = input.value.replace(/\D/g, ''); // 숫자만 남기기
          if (riders_phone.length > 11) {
            riders_phone = riders_phone.slice(0, 10); // 10자리까지만
          }
          if (riders_phone.length > 6) {
              input.value = riders_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
          } else if (riders_phone.length > 3) {
              input.value = riders_phone.replace(/(\d{3})(\d{0,3})/, '$1-$2');
          } else {
              input.value = riders_phone;
          }
      }

      function send(f) {
    let rider_name = f.rider_name.value.trim();
    let riders_pwd = f.riders_pwd.value.trim();
    let riders_phone = f.riders_phone.value.trim();
    let email_id = $("#email_id").val().trim();
    let email_domain = $("#email_domain").val().trim();
    let riders_email = email_id + "@" + email_domain;
    $("#riders_email").val(riders_email); // email 필드가 있는지 확인

    
     // 지역 선택 초기화
    $("#riders_region").val(""); // 이전 값 지우기

    // 지역 선택 수집
    let selectedRegions = [];
    $("input[name='riders_region']:checked").each(function() {
        selectedRegions.push($(this).val());
    });

    let riders_region = selectedRegions.join(","); // 쉼표로 구분된 값
    $("#riders_region").val(riders_region);
    

    // 입력값 검증
    if (rider_name === "") {
        alert("이름을 입력하시오");
        f.rider_name.value = "";
        f.rider_name.focus();
        return;
    }

    if (riders_pwd === "") {
        alert("비밀번호를 입력하시오");
        f.riders_pwd.value = "";
        f.riders_pwd.focus();
        return;
    }

    if (riders_phone === "") {
        alert("전화번호를 입력하시오");
        f.riders_phone.value = "";
        f.riders_phone.focus();
        return;
    }

    // 폼 제출 방지 플래그 추가
    f.action = "insert.do"; // MemberInsertAction
    f.submit(); // 전송
}

    </script>

    <script type="text/javascript">
      function setEmailDomain(domain) {
        // '직접입력'을 선택한 경우, 도메인 입력 필드를 비웁니다.
        if (domain === "직접입력") {
          document.getElementById("email_domain").value = "";
        } else {
          // 선택된 도메인 값을 도메인 입력 필드에 설정합니다.
          document.getElementById("email_domain").value = domain;
        }
      }
    </script>

    <script type="text/javascript">
      /* 자바 스크립트 함수 선언(비밀번호 확인) */

      function passConfirm() {
        var password = $("#riders_pwd").val();
        var passwordConfirm = $("#passwordConfirm").val();
        var confirmMsg = $("#confirmMsg");
        var correctColor = "blue";
        var wrongColor = "red";

        if (password === passwordConfirm) {
          confirmMsg.css("color", correctColor);
          confirmMsg.html("비밀번호 일치");
        } else {
          confirmMsg.css("color", wrongColor);
          confirmMsg.html("비밀번호 불일치");
        }
      }
    </script>
  </head>
  <body>
    
    <form action="${pageContext.request.contextPath}/riders/insert.do" method="post">
      <input type="hidden" name="riders_email" id="riders_email" />
      <!-- <input type="hidden" id="riders_region" name="riders_region" /> -->
      <div class="wrapper">
        <div class="container">
          <div class="header">
            <h2>회원가입</h2>
          </div>
          <div class="form-group">
            <label for="rider_name">로그인 시 사용할 이름을 입력해 주세요</label>
            <input type="text" class="form-control" id="rider_name" name="rider_name" required>
          </div>
          <div class="form-group">
            <label for="riders_phone">라이더의 전화번호를 입력해 주세요</label>
            <input type="text" class="form-control" id="riders_phone" name="riders_phone" oninput="formatPhoneNumber(this);" required>
          </div>
          <div class="form-group">
            <label for="email_id">로그인 시 사용할 이메일 주소를 입력해 주세요</label>
            <input type="text" class="form-control" id="email_id" name="email_id" required>
            @
            <label for="email_domain"></label>
            <input class="form-control" type="text" id="email_domain" name="email_domain" value="" title="이메일 도메인" maxlength="18" />
            <select class="select form-control" title="이메일 도메인 주소 선택" onchange="setEmailDomain(this.value);">
              <option value="직접입력">-선택-</option>
              <option value="naver.com">naver.com</option>
              <option value="gmail.com">gmail.com</option>
              <option value="hanmail.net">hanmail.net</option>
            </select>
          </div>
          <div class="form-group position-relative">
            <label for="riders_pwd">비밀번호를 입력해 주세요</label>
            <input type="password" class="form-control" id="riders_pwd" name="riders_pwd" required>
          </div>
          <div class="mb-4">
            <label for="riders_pwd">비밀번호 확인</label>
            <input
              class="form-control"
              type="password"
              id="passwordConfirm"
              name="riders_pwd_confirm"
              onkeyup="passConfirm()"
            />
            <span id="confirmMsg"></span>
              
          </div>
          <div> &nbsp;</div>
          <div class="form-group">
            <label for="riders_region">배달지역 선택</label>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="checkbox" id="inlineCheckbox1" name="riders_region" value="서울">
              <label class="form-check-label" for="inlineCheckbox1">서울</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="checkbox" id="inlineCheckbox2" name="riders_region" value="경기">
              <label class="form-check-label" for="inlineCheckbox2">경기</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="checkbox" id="inlineCheckbox3" name="riders_region" value="인천">
              <label class="form-check-label" for="inlineCheckbox3">인천</label>
            </div>
          </div>
        
          <div class="button-group">
            <!-- <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/riders/main.do'">로그인 화면 으로</button> 
            <button type="button" class="btn btn-primary" onclick="send(this.form);">가입하기</button> -->
           <input class="button_style" type="button" id="btn_popup_update" value="로그인 화면으로" onclick="location.href='${pageContext.request.contextPath}/riders/main.do'">
            <input class="button_style" type="button" id="btn_popup_updated" value="가입하기" onclick="send(this.form);">
          </div>
        </div>
      </div>
      
    </form>
  </body>

  </body>
</html>