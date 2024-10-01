<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8" />

  <script type="text/javascript">
    /* -----------------메뉴 인기, 숨김, 품절 옵션 설정-----------------*/
    // onclick 이벤트를 사용하여 하나의 체크박스만 선택되도록 함
    function handleCheckboxChange(clickedCheckbox) {
      // 모든 체크박스 가져오기
      const checkboxes = document.querySelectorAll('input[type="checkbox"]');

      // 클릭된 체크박스 외에 모든 체크박스의 체크를 해제
      checkboxes.forEach((checkbox) => {
        if (checkbox !== clickedCheckbox) {
          checkbox.checked = false;
        }
      });

      // 폼의 hidden 필드 업데이트
      updateHiddenFields();
    }

    function updateHiddenFields() {
      // 체크박스 상태에 따라 히든 필드 값 업데이트
      const popularityCheckbox = document.getElementById("menu_popularity");
      const hiddenCheckbox = document.getElementById("menu_hidden");
      const soldoutCheckbox = document.getElementById("menu_soldout");

      document.querySelector('input[name="menu_popularity"]').value =
        popularityCheckbox.checked ? "1" : "0";
      document.querySelector('input[name="menu_hidden"]').value =
        hiddenCheckbox.checked ? "1" : "0";
      document.querySelector('input[name="menu_soldout"]').value =
        soldoutCheckbox.checked ? "1" : "0";
    }

    // 페이지 로드 시 초기화
    document.addEventListener("DOMContentLoaded", updateHiddenFields);
    //페이지가 로드될 때 메뉴의 인기, 품절, 숨김 옵션 히든 필드 초기값 설정

    /* ----------------- END 메뉴 인기, 숨김, 품절 옵션 설정-----------------*/

    function send(f) {
      //입력값 검증
      let menu_name = f.menu_name.value.trim();
      let menu_content = f.menu_content.value.trim();
      let menu_price = f.menu_price.value.trim();
      let photo = f.photo.value;

      if (menu_name == "") {
        alert("메뉴명을 입력하세요!");
        f.menu_name.value = ""; //지우기
        f.menu_name.focus();
        return;
      }

      if (menu_content == "") {
        alert("메뉴설명을 입력하세요!");
        f.menu_content.value = ""; //지우기
        f.menu_content.focus();
        return;
      }

      if (menu_price == "") {
        alert("가격을 입력하세요!");
        f.menu_price.value = ""; //지우기
        f.menu_price.focus();
        return;
      }

      if (photo == "") {
        alert("사진을 선택하세요!");
        return;
      }

      //f.method = "POST";
      f.action = "insert.do"; //전송대상(PhotoInsertAction)
      f.submit(); //전송
    }
  </script>

  <style>
    img {
      width: 300px;
    }

    #my_img {
      border-radius: 8px;

    }
  </style>
</head>

<body>
  <!-- 공통 css import -->
  <%@include file="../common.jsp" %>

  <!-- header import -->
  <%@include file="../header.jsp" %>

  <!-- side bar import -->
  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">
      <h1>메뉴등록</h1><br>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">메뉴관리</li>
          <li class="breadcrumb-item active">메뉴등록</li>
        </ol>
      </nav>
    </div>
    <!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-10">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">메뉴 정보 입력</h5>

              <!-- Floating Labels Form -->
              <form class="row g-3" method="POST" enctype="multipart/form-data">
                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" placeholder="메뉴명" name="menu_name" />
                    <label>메뉴명</label>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating">
                    <textarea class="form-control" placeholder="메뉴설명" name="menu_content"
                      tyle="height: 100px;"></textarea>
                    <label>메뉴설명</label>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" placeholder="가격" name="menu_price" />
                    <label>가격</label>
                  </div>
                </div>

                <div class="col-md-12">
                  <div class="form-floating" style="text-align:center;">
                    <input class="form-control" type="file" name="photo" id="my_img" />
                  </div>
                </div>

                <div class="col-12">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="menu_popularity" id="menu_popularity"
                      value="1" onclick="handleCheckboxChange(this)" />
                    <label class="form-check-label" for="menu_popularity">
                      인기
                    </label>
                  </div>
                </div>

                <div class="col-12">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="menu_hidden" id="menu_hidden" value="2"
                      onclick="handleCheckboxChange(this)" />
                    <label class="form-check-label" for="menu_hidden">
                      숨김
                    </label>
                  </div>
                </div>

                <div class="col-12">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="menu_soldout" id="menu_soldout" value="3"
                      onclick="handleCheckboxChange(this)" />
                    <label class="form-check-label" for="menu_soldout">
                      품절
                    </label>
                  </div>
                </div>



                <!-- Hidden inputs to ensure all values are submitted -->
                <input type="hidden" name="menu_popularity" value="0" />
                <input type="hidden" name="menu_hidden" value="0" />
                <input type="hidden" name="menu_soldout" value="0" />

                <div class="text-center">
                  <input class="button_style" type="button" value="메인화면" onclick="location.href='list.do'" />
                  <input class="button_style" type="button" value="메뉴등록" onclick="send(this.form);" />
                </div>
              </form>
              <!-- End floating Labels Form -->
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
  <!-- End #main -->
</body>

</html>