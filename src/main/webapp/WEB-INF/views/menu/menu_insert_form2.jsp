<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="utf-8">

      <script type="text/javascript">
        function send(f) {

          //입력값 검증
          let menu_name = f.menu_name.value.trim();
          let menu_content = f.menu_content.value.trim();
          let menu_category = f.menu_category.value.trim();
          let menu_price = f.menu_price.value.trim();
          let photo = f.photo.value;

          if (menu_name == '') {
            alert("메뉴명을 입력하세요!");
            f.menu_name.value = ""; //지우기
            f.menu_name.focus();
            return;
          }

          if (menu_content == '') {
            alert("메뉴설명을 입력하세요!");
            f.menu_content.value = ""; //지우기
            f.menu_content.focus();
            return;
          }

          if (menu_category == '') {
            alert("카테고리를 입력하세요!");
            f.menu_category.value = ""; //지우기
            f.menu_category.focus();
            return;
          }
          if (menu_price == '') {
            alert("가격을 입력하세요!");
            f.menu_price.value = ""; //지우기
            f.menu_price.focus();
            return;
          }

          if (photo == '') {
            alert("사진을 선택하세요!");
            return;
          }


          //f.method = "POST";
          f.action = "insert.do";//전송대상(PhotoInsertAction)
          f.submit(); //전송
        }
      </script>
    </head>

    <body>
      <%@include file="../common.jsp" %>

        <!-- header import -->
        <%@include file="../header.jsp" %>

          <!-- side bar import -->
          <%@include file="../sidebar.jsp" %>


            <main id="main" class="main">
              <div class="pagetitle">

                <h1>Form Layouts</h1>

                <nav>
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                    <li class="breadcrumb-item">Forms</li>
                    <li class="breadcrumb-item active">Layouts</li>
                  </ol>
                </nav>

              </div><!-- End Page Title -->
              <section class="section">
                <div class="row">
                  <div class="col-lg-10">
                    <div class="card">
                      <div class="card-body">
                        <h5 class="card-title">Floating labels Form</h5>

                        <!-- Floating Labels Form -->
                        <form class="row g-3" method="POST" enctype="multipart/form-data">

                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="메뉴명" name="menu_name">
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
                              <input type="text" class="form-control" placeholder="가격" name="menu_price">
                              <label>가격</label>
                            </div>
                          </div>

                          <div class="col-md-12">
                            <div class="form-floating">
                              <input class="form-control" type="file" name="photo">
                              <label>사진</label>
                            </div>
                          </div>


                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <select class="form-select" id="floatingSelect" aria-label="State" name="menu_category">
                                <option selected></option>
                                <option value="1">임시카테고리1</option>
                                <option value="2">임시카테고리2</option>
                              </select>
                              <label for="floatingSelect">카테고리</label>
                            </div>
                          </div>

                          <div class="col-12">
                            <div class="form-check">
                              <input class="form-check-input" type="checkbox" name="menu_popularity" value="1">
                              <label class="form-check-label">
                                인기
                              </label>
                              <input type="hidden" name="menu_popularity" value="0">
                            </div>
                          </div>

                          <div class="col-12">
                            <div class="form-check">
                              <input class="form-check-input" type="checkbox" name="menu_hidden" value="1">
                              <label class="form-check-label">
                                숨김
                              </label>
                              <input type="hidden" name="menu_hidden" value="0">
                            </div>
                          </div>

                          <div class="col-12">
                            <div class="form-check">
                              <input class="form-check-input" type="checkbox" name="menu_soldout" value="1">
                              <label class="form-check-label">
                                품절
                              </label>
                              <input type="hidden" name="menu_soldout" value="0">
                            </div>
                          </div>

                          <div class="text-center">
                            <!-- <button type="submit" class="btn btn-primary">Submit</button>
                          <button type="reset" class="btn btn-secondary">Reset</button> -->
                            <input class="btn btn-success" type="button" value="메인화면" onclick="location.href='list.do'">

                            <input class="btn btn-primary" type="button" value="메뉴등록" onclick="send(this.form);">
                          </div>
                        </form><!-- End floating Labels Form -->

                      </div>
                    </div>
                  </div>
                </div>
              </section>

            </main><!-- End #main -->

    </body>

    </html>