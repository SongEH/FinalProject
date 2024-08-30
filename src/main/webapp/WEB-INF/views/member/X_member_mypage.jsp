<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>마이페이지</title>
   <!--  Bootstrap  3.x  -->
   <link
   rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
 />
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
      /* 사이드바 스타일 */
      .sidebar {
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        height: 100%;
        background-color: #f4f4f4;
        padding: 15px;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
      }

      .sidebar a {
        display: block;
        padding: 10px;
        color: #333;
        text-decoration: none;
      }

      .sidebar a:hover {
        background-color: #ddd;
      }

      .content {
        margin-left: 270px;
        padding: 15px;
      }

      /* 각 섹션의 기본 숨김 */
      .section {
        display: none;
      }

      .section.active {
        display: block;
      }
    </style>

    <script>
      // 섹션 표시 함수
      function showSection(sectionId) {
        var sections = document.getElementsByClassName("section");
        for (var i = 0; i < sections.length; i++) {
          sections[i].style.display = "none"; // 모든 섹션 숨기기
        }
        var section = document.getElementById(sectionId);
        if (section) {
          section.style.display = "block"; // 선택된 섹션만 표시
        }
      }

      // 페이지 로딩 시 기본 섹션 표시 (여기서는 회원정보를 기본으로 설정)
      window.onload = function () {
        showSection("profileSection");
      };
    </script>
    <script>
      function check_nickname() {
        //회원가입 버튼은 비활성화
        // <input id="btn_register" type="button" ...  disabled="disabled">
        $("#btn_register").prop("disabled", true);

        //           document.getElementById("mem_id").value
        let member_nickname = $("#member_nickname").val();

        if (member_nickname.length == 0) {
          $("#nickname_msg").html("");
          return;
        }

        if (member_nickname.length < 3) {
          $("#nickname_msg")
            .html("닉네임는 3자리 이상 입력하세요")
            .css("color", "red");
          return;
        }

        $.ajax({
          url: "check_nickname.do",
          data: {
            member_nickname: member_nickname,
          },
          dataType: "json",
          success: function (res_data) {
            if (res_data.result) {
              $("#nickname_msg")
                .html("사용가능한 닉네임 입니다")
                .css("color", "blue");

              $("#btn_register").prop("disabled", false);
            } else {
              $("#nickname_msg")
                .html("이미 사용중인 닉네임 입니다")
                .css("color", "red");
            }
          },
          error: function (err) {
            alert(err.responseText);
          },
        });
      } //end:check_nickname()
    </script>
    <script>
      // 전화번호 포맷팅 함수
      function formatPhoneNumber(input) {
          let member_phone = input.value.replace(/\D/g, ''); // 숫자만 남기기
          if (member_phone.length > 11) {
            member_phone = member_phone.slice(0, 10); // 10자리까지만
          }
          if (member_phone.length > 6) {
              input.value = member_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
          } else if (member_phone.length > 3) {
              input.value = member_phone.replace(/(\d{3})(\d{0,3})/, '$1-$2');
          } else {
              input.value = member_phone;
          }
      }
    </script>
    <script>
      function send(f) {
        let member_name = f.member_name.value.trim();
        let member_nickname = f.member_nickname.value.trim();
        let member_pwd = f.member_pwd.value.trim();
        let member_phone = f.member_phone.value.trim();
        let member_email = f.member_email
        // let email_id = $("#email_id").val().trim();
        // let email_domain = $("#email_domain").val().trim();

        if (member_name == "") {
          alert("이름을 입력하시오");
          f.member_name.value = "";
          f.member_name.focus();
          return;
        }

        if (member_nickname == "") {
          alert("닉네임을 입력하시오");
          f.member_nickname.value = "";
          f.member_nickname.focus();
          return;
        }

        if (member_pwd == "") {
          alert("비밀번호를 입력하시오");
          f.member_pwd.value = "";
          f.member_pwd.focus();
          return;
        }

        if (member_phone == "") {
          alert("전화번호를 입력하시오");
          f.member_phone.focus();
          return;
        }
        
        // let member_email = email_id + "@" + email_domain;
        // $("#member_email").val(member_email); // email 필드가 있는지 확인하세요

        alert(member_email);

        f.action = "modify.do"; 
        f.submit(); //전송
      } //end:send()
    </script>

  </head>
  <body>
    



    <div class="sidebar">
      <h2>마이페이지</h2>
      <!-- <a href="mypage.do">회원정보</a> -->
      <a href="mypage.do" onclick="showSection('profileSection')">회원정보</a>
      <a href="#" onclick="showSection('paymentsSection')">결제정보</a>
      <a href="#" onclick="showSection('addressesSection')">주소정보</a>
      <a href="#" onclick="showSection('ordersSection')">주문내역</a>
      <a href="#" onclick="showSection('cartSection')">장바구니</a>
    </div> --%>

    <div class="content">
      <!-- 회원정보 섹션 -->
      <div id="profileSection" class="container mx-auto p-6">
        <h2>회원 정보</h2>
        <form action="" method="post" align="center">
          <input type="hidden" name="member_id" value="${member.member_id}" />
          <input type="hidden" name="member_email" value="${member.member_email}" />
          <div class="form-group">
          <div class="mb-4">
            <label for="member_name">이름</label>
            <input
              class="form-control"
              type="text"
              id="member_name"
              name="member_name"
              value="${member.member_name}"
            />
          </div>
          <div class="mb-4">
            <label for="member_nickname">닉네임</label>
            <input
              class="form-control"
              type="text"
              id="member_nickname"
              name="member_nickname"
              value="${member.member_nickname}"
            />
            <span id="nickname_msg" />
          </div>
          <div class="mb-4">
            <label for="member_pwd">비밀번호</label>
            <input
              class="form-control"
              type="password"
              id="member_pwd"
              name="member_pwd"
              value="${member.member_pwd}"
            />
          </div>
          <div class="mb-4">
            <label for="member_email"
              >이메일<span class="em_red">*</span></label
            >
            <input class="form-control" type="text" id="member_email" name="member_email" value="${member.member_email}">
            <!-- <input
              class="form-control"
              type="text"
              id="email_id"
              name="email_id"
              value="email_id"
              title="이메일 아이디"
              maxlength="18"
            />
            @
            <input
              class="form-control"
              type="text"
              id="email_domain"
              name="email_domain"
              value="email_domain"
              title="이메일 도메인"
              maxlength="18"
            />
            <select
              class="select, form-control"
              title="이메일 도메인 주소 선택"
              onclick="setEmailDomain(this.value);return false;"
            >
              <option value="직접입력">-선택-</option>
              <option value="naver.com">naver.com</option>
              <option value="google.com">google.com</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="daum.net">daum.net</option>
              <option value="kakao.com">kakao.com</option>
              <option value="nate.com">nate.com</option>
            </select> -->
          </div>
          <div class="mb-4">
            <label for="member_phone">전화번호</label>
            <input
              class="form-control"
              type="text"
              name="member_phone"
              id="member_phone"
              oninput="formatPhoneNumber(this);"
              value="${member.member_phone}"
            />
          </div>
        </div>
          <div class="flex justify-end">
            <button type="button">저장</button>
            <button type="button" onclick="location.href='../member/mypage/modify.do'">수정</button>
          </div>
        </form>
      </div>

    

  </body>
</html>
