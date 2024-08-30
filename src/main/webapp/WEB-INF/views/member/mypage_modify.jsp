<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>회원 정보 수정</title>
  </head>
  <body>
    <h1>회원 정보 수정</h1>
    <form
      action="${pageContext.request.contextPath}/member/mypage/modify.do"
      method="post"
    >
      <input type="hidden" name="member_id" value="${member.member_id}" />
      <div class="container">
        <div class="mb-4">
          <label for="name">이름:</label>
          <input
            class="form-control"
            type="text"
            name="member_name"
            value="${member.member_name}"
          />
        </div>
        <div class="mb-4">
          <label for="nickname">닉네임:</label>
          <input
            class="form-control"
            type="text"
            name="member_nickname"
            value="${member.member_nickname}"
          />
        </div>
        <div class="mb-4">
          <label for="password">비밀번호:</label>
          <input
            class="form-control"
            type="password"
            name="member_pwd"
            value="${member.member_pwd}"
          />
        </div>
        <div class="mb-4">
          <label for="email">이메일:</label>
          <input
            class="form-control"
            type="text"
            name="member_email"
            value="${member.member_email}"
          />
        </div>
        <div class="mb-4">
          <label for="phone">전화번호:</label>
          <input
            class="form-control"
            type="text"
            name="member_phone"
            value="${member.member_phone}"
          />
        </div>
        <div class="flex justify-end">
          <input type="submit" value="수정하기" />
        </div>
      </div>
    </form>
    <a href="mypage.do">취소</a>
  </body>
</html>
