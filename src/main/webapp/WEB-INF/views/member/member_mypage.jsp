<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title></title>

    <script>
      function del(member_id) {
        //console.log(mem_idx,"삭제");
        if (confirm("정말 삭제 하시겠습니까?") == false) return;

        //삭제요청
        location.href = "mypage/delete.do?member_id=" + member_id; //MemberDeleteAction
      }
    </script>
  </head>
  <body>
    <input type="hidden" name="member_id" value="${member.member_id}" />
    <h1>회&nbsp;원&nbsp;정&nbsp;보</h1>
    <div class="container">
      <div class="mb-4">
        <lable for="name">이름:</lable>
        <input
          class="form-control"
          type="text"
          value="${member.member_name}"
          readonly
        />
      </div>
      <div class="mb-4">
        <lable for="nickname">닉네임:</lable>
        <input
          class="form-control"
          type="text"
          value="${member.member_nickname}"
          readonly
        />
      </div>
      <div class="mb-4">
        <lable for="password">비밀번호:</lable>
        <input
          class="form-control"
          type="text"
          value="${member.member_pwd}"
          readonly
        />
      </div>
      <div class="mb-4">
        <lable for="email">이메일:</lable>
        <input
          class="form-control"
          type="text"
          value="${member.member_email}"
          readonly
        />
        <div class="mb-4">
          <lable for="phone">전화번호:</lable>
          <input
            class="form-control"
            type="text"
            value="${member.member_phone}"
            readonly
          />
        </div>
        <div class="flex justify-end">
          <c:if test="( user.member_id eq vo.member_id )">
            <input
              type="button"
              value="회원 수정"
              onclick="location.href='mypage/modify_form.do?member_id=${member.member_id}'"
            />
            <input
              type="button"
              value="회원 탈퇴"
              onclick="del('${ vo.member_id }');"
            />
          </c:if>
        </div>
      </div>
    </div>
  </body>
</html>
