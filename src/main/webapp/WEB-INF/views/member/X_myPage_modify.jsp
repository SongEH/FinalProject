<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보 수정</title>
<!--  Bootstrap  3.x  -->
<link
rel="stylesheet"
href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
    <!-- <button id="openModal" data-toggle="modal" data-target="#signupModal">
        회&nbsp;원
      </button>
      <div id="signupModal" class="modal fade" role="dialog">
        <div class="modal-content"> -->
        <div class ="container mx-auto p-6">
          <span class="close-button">&times;</span>s
          <h2>회&nbsp;원&nbsp;수&nbsp;정</h2>
          <form
            action="${pageContext.request.contextPath}/member/mypage/modify.do"
            method="post"
          >
            <input type="hidden" name="member_id" id="member_id" />
            <input type="hidden" name="member_email" id="member_email" />
            <div class="mb-4">
              <label for="member_name">이름</label>
              <input
                class="form-control"
                type="text"
                id="member_name"
                name="member_name"
                value="${vo.member_name}"
              />
            </div>
            <div class="mb-4">
              <label for="member_nickname">닉네임</label>
              <input
                class="form-control"
                type="text"
                id="member_nickname"
                name="member_nickname"
                value="${vo.member_nickname}"
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
                value="${vo.member_pwd}"
              />
            </div>
                        <div class="mb-4">
              <label for="member_email"
                >이메일<span class="em_red">*</span></label
              >
              <input
                class="form-control"
                type="text"
                id="email_id"
                name="email_id"
                value=""
                title="이메일 아이디"
                maxlength="18"
              />
              @
              <input
                class="form-control"
                type="text"
                id="email_domain"
                name="email_domain"
                value=""
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
              </select>
            </div>
            <div class="mb-4">
              <label for="member_phone">전화번호</label>
              <input class="form-control" type="text" name="member_phone" id="member_phone" oninput="formatPhoneNumber(this);" value="${vo.member_phone}">
              
            </div>
  
            <div class="flex justify-end">
              <button type="submit">저장</button>
            </div>
          </form>
        </div>
      </div>
</body>
</html>