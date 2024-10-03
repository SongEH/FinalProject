<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <title>Insert title here</title>

  <script type="text/javascript">
    function execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function (data) {
          var addr = "";
          if (data.userSelectedType === "R") {
            addr = data.roadAddress;
          } else {
            addr = data.jibunAddress;
          }
          document.getElementById("addr_zipcode").value = data.zonecode;
          document.getElementById("addr_line1").value = addr;
        },
      }).open();
    }

    function send(f) {
      let addr_zipcode = f.addr_zipcode.value.trim();
      let addr_line1 = f.addr_line1.value.trim();
      let addr_line2 = f.addr_line2.value.trim();
      let addr_name = f.addr_name.value.trim();

      if (addr_zipcode == "") {
        alert("우편번호를 입력하시오");
        f.addr_zipcode.value = "";
        f.addr_zipcode.focus();
        return;
      }

      if (addr_line1 == "") {
        alert("기본주소를 입력하시오");
        f.addr_line1.value = "";
        f.addr_line1.focus();
        return;
      }

      if (addr_line2 == "") {
        alert("상세주소를 입력하시오");
        f.addr_line2.value = "";
        f.addr_line2.focus();
        return;
      }

      if (addr_name == "") {
        alert("별칭를 입력하시오");
        f.addr_name.value = "";
        f.addr_name.focus();
        return;
      }

      f.action = "addr_insert.do";
      f.submit();
    }
  </script>

  <script type="text/javascript">
    function setAddrName(name) {
      if (name === "직접입력") {
        document.getElementById("addr_name").value = "";
      } else {
        document.getElementById("addr_name").value = name;
      }
    }
  </script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0px;
    }

    .container {
      max-width: 800px;
      margin: auto;
      background: white;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
      text-align: center;
      color: #333;
    }

    .bg-white {
      background-color: #fff;
      border-radius: 5px;
      padding: 20px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .form-control {
      width: calc(100% - 20px);
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }

    .form-control:focus {
      border-color: #007bff;
      outline: none;
      box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }

    .btn {
      color: white;
      border: none;
      padding: 10px 15px;
      cursor: pointer;
      border-radius: 5px;
      transition: background-color 0.3s;
    }

    .btn:hover {
      background-color: #4cae4c;
    }

    .flex {
      display: flex;
      justify-content: flex-end;
    }

    .flex>input {
      margin-left: 10px;
    }

    label {
      font-weight: bold;
    }
  </style>
</head>

<body>
  <%@include file="../common.jsp" %> <%@include file="../header.jsp" %>
  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">
      <h1>주소등록</h1>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">회원관리</li>
          <li class="breadcrumb-item active">주소목록</li>
        </ol>
      </nav>
    </div>

    <div class="container mx-auto p-6">
      <div class="bg-white shadow-md rounded-lg p-6">
        <form action="${pageContext.request.contextPath}/addr/addr_insert_form.do" method="post">
          <input type="hidden" name="nextPath" value="${nextPath}" />

          <div class="mb-4">
            <label for="zipcode">우편번호
              <input type="button" value="주소검색" class="button_style" onclick="execDaumPostcode()" />
            </label>
            <input class="form-control" type="text" name="addr_zipcode" id="addr_zipcode" />

          </div>
          <div class="mb-4">
            <label for="line1">기본주소</label>
            <input type="text" name="addr_line1" id="addr_line1" class="form-control" />
          </div>
          <div class="mb-4">
            <label for="line2">상세주소</label>
            <input type="text" name="addr_line2" id="addr_line2" class="form-control" />
          </div>
          <div class="mb-4">
            <label for="name">별칭</label>
            <input type="text" name="addr_name" id="addr_name" class="form-control" />
            <select class="select, form-control" title="별칭 선택" value="" onclick="setAddrName(this.value);return false;">
              <option value="직접입력">-직접입력-</option>
              <option value="집">집</option>
              <option value="회사">회사</option>
              <option value="학원">학원</option>
            </select>
          </div>
          <div class="flex justify-end">
            <input class="button_style" type="button" value="이전으로" onclick="location.href='/addr/addr_list.do'" />
            <input class="button_style" type="button" value="주소등록" onclick="send(this.form);" />
          </div>
        </form>
      </div>
    </div>
  </main>

</body>

</html>