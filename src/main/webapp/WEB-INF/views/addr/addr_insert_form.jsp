<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>

    <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
  </head>
  <body>
    <div class="container mx-auto p-6">
      <h1 class="text-3xl font-bold mb-6" style="margin-top: 150px">
        주&nbsp;소&nbsp;등&nbsp;록
      </h1>

      <div class="bg-white shadow-md rounded-lg p-6">
        <form
          action="${pageContext.request.contextPath}/addr/addr_insert_form.do"
          method="post"
        >
          <input type="hidden" name="nextPath" value="${nextPath}" />

          <div class="mb-4">
            <label for="zipcode">우편번호</label>
            <input
              class="form-control"
              type="text"
              name="addr_zipcode"
              id="addr_zipcode"
            />
            <input
              type="button"
              value="주소검색"
              class="form-control"
              onclick="execDaumPostcode()"
            />
          </div>
          <div class="mb-4">
            <label for="line1">기본주소</label>
            <input
              type="text"
              name="addr_line1"
              id="addr_line1"
              class="form-control"
            />
          </div>
          <div class="mb-4">
            <label for="line2">상세주소</label>
            <input
              type="text"
              name="addr_line2"
              id="addr_line2"
              class="form-control"
            />
          </div>
          <div class="mb-4">
            <label for="name">별칭</label>
            <input
              type="text"
              name="addr_name"
              id="addr_name"
              class="form-control"
            />
            <select
              class="select, form-control"
              title="별칭 선택"
              value=""
              onclick="setAddrName(this.value);return false;"
            >
              <option value="직접입력">-직접입력-</option>
              <option value="집">집</option>
              <option value="회사">회사</option>
              <option value="학원">학원</option>
            </select>
          </div>
          <div class="flex justify-end">
            <input
              type="button"
              value="이전으로"
              onclick="location.href='/addr/addr_list.do'"
            />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" value="주소등록" onclick="send(this.form);" />
          </div>
        </form>
      </div>
    </div>
  </body>
</html>
