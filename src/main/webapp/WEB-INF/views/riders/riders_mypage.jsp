<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title></title>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    body {
      background-color: white; /* 배경색 */
      color: #333; /* 텍스트 색상 */
      font-family: Arial, sans-serif;
    }
    h1 {
      color: #F0A8D0; /* 제목 색상 */
      text-align: center;
      padding: 20px;
    }
    .container {
      background-color: #FFF; /* 컨테이너 배경색 */
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      max-width: 600px;
      margin: 30px auto;
    }
    .form-control {
      background-color: #F7B5CA; /* 입력 필드 배경색 */
      border: 1px solid #F0A8D0; /* 입력 필드 테두리 색상 */
      color: #333; /* 입력 필드 텍스트 색상 */
    }
    .form-control[readonly] {
      background-color: #FFC6C6; /* 읽기 전용 필드 배경색 */
    }
    .mb-4 {
      margin-bottom: 20px;
    }
    .flex {
      display: flex;
      justify-content: flex-end;
    }
    input[type="button"] {
      background-color: #F0A8D0; /* 버튼 배경색 */
      border: none;
      color: #fff;
      padding: 10px 20px;
      margin-left: 10px;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    input[type="button"]:hover {
      background-color: #F7B5CA; /* 버튼 호버 색상 */
    }
  </style>



    <script>
      function del(raiders_id) {
        //console.log(mem_idx,"삭제");
        if (confirm("정말 삭제 하시겠습니까?") == false) return;

        //삭제요청
        location.href = "mypage/delete.do?raiders_id=" + raiders_id; //MemberDeleteAction
      }
    </script>
  </head>
  <body>
    <input type="hidden" name="raiders_id" value="${rider.raiders_id}" />
    <h1>회&nbsp;원&nbsp;정&nbsp;보 여긴riders_mypage</h1>
    <div class="container">
      <div class="mb-4">
        <lable for="name">이름:</lable>
        <input
          class="form-control"
          type="text"
          value="${vo.rider_name}"
          readonly
        />
      </div>
  
      <div class="mb-4">
        <lable for="email">이메일:</lable>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_email}"
          readonly
        />
        </div>

      <div class="mb-4">
        <lable for="password">비밀번호:</lable>
        <input
          class="form-control"
          type="text"
          value="${vo.riders_pwd}"
          readonly
        />
      </div>
   
        <div class="mb-4">
          <lable for="phone">전화번호:</lable>
          <input
            class="form-control"
            type="text"
            value="${vo.riders_phone}"
            readonly
          />
        </div>

        <div class="mb-4">
            <lable for="region">배달지역:</lable>
            <input
              class="form-control"
              type="text"
              value="${vo.riders_region}"
              readonly
            />
          </div>


        <div class="flex justify-end">
          <c:if test="( user.raiders_id eq vo.raiders_id )">
            <input
              type="button"
              value="회원 수정"
              onclick="location.href='mypage/modify_form.do?raiders_id=${vo.raiders_id}'"
            />

            <input
            type="button"
            value="메인이동"
            onclick="location.href='main.do'"
          />

            <input
              type="button"
              value="회원 탈퇴"
              onclick="del('${ vo.raiders_id }');"
            />
          </c:if>
        </div>
      </div>
    </div>
  </body>
</html>