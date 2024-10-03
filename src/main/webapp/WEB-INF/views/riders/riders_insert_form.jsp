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
     
     

     
      function formatPhoneNumber(input) {
          let riders_phone = input.value.replace(/\D/g, ''); 
          if (riders_phone.length > 11) {
            riders_phone = riders_phone.slice(0, 10); 
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
    $("#riders_email").val(riders_email); 
    
    
    $("#riders_region").val(""); 

    
    let selectedRegions = [];
    $("input[name='riders_region']:checked").each(function() {
        selectedRegions.push($(this).val());
    });

    let riders_region = selectedRegions.join(","); 
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

   
    f.action = "insert.do"; 
    f.submit(); 
}

    </script>

    <script type="text/javascript">
      function setEmailDomain(domain) {
     
        if (domain === "직접입력") {
          document.getElementById("email_domain").value = "";
        } else {
         
          document.getElementById("email_domain").value = domain;
        }
      }
    </script>

    <script type="text/javascript">
     function validateEmail(email) {
        // Regular expression for validating email format
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailRegex.test(email);
    }

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
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="checkbox" id="inlineCheckbox4" name="riders_region" value="대전">
              <label class="form-check-label" for="inlineCheckbox4">대전</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="checkbox" id="inlineCheckbox5" name="riders_region" value="부산">
              <label class="form-check-label" for="inlineCheckbox5">부산</label>
            </div>
          </div>
        
          <div class="button-group">
        
           <input class="button_style" type="button" id="btn_popup_update" value="로그인 화면으로" onclick="location.href='${pageContext.request.contextPath}/riders/main.do'">
            <input class="button_style" type="button" id="btn_popup_updated" value="가입하기" onclick="send(this.form);">
          </div>
        </div>
      </div>
      
    </form>
  </body>

  </body>
</html>