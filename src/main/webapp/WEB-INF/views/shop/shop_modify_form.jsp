<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="utf-8">
    </head>

    <script>
      function send(f){

        let shop_id = f.shop_id.value;
        
        f.action = "modify.do";
        f.submit();
      }

    </script>
    <body>
      <%@include file="../common.jsp" %>

        <!-- header import -->
        <%@include file="../header.jsp" %>

          <!-- side bar import -->
          <%@include file="../sidebar.jsp" %>

            <main id="main" class="main">
              <div class="pagetitle">
                <h1>Form Layouts</h1>
              </div><!-- End Page Title -->
              <section class="section">
                <div class="row">
                  <div class="col-lg-10">
                    <div class="card">
                      <div class="card-body">
                        <h5 class="card-title">Floating labels Form</h5>
                        
                        
                        <!-- Floating Labels Form -->
                        <form class="row g-3" method="POST" action="modify.do" enctype="multipart/form-data">
                          
                          <!-- 가게 ID -->
                          <input type="hidden" name="shop_id" value="${vo.shop_id}">
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="상호명" name="shop_name" value="${vo.shop_name}">
                              <label>상호명</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <textarea class="form-control" placeholder="소개글" name="shop_content" value="${vo.shop_content}"
                                style="height: 100px;">${vo.shop_content}</textarea>
                              <label>가게소개글 </label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="가게주소" name="shop_addr" value="${vo.shop_addr}">
                              <label>가게주소</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="가게 전화번호" name="shop_call" value="${vo.shop_call}">
                              <label>가게전화번호</label>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="최소주문금액" name="shop_min_price" value="${vo.shop_min_price}">
                              <label>최소주문금액</label>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="form-floating">
                              <input type="time" class="form-control" placeholder="영업오픈시간" name="shop_open_hour" value="${vo.shop_open_hour}">
                              <label>영업 오픈 시간</label>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="form-floating">
                              <input type="time" class="form-control" placeholder="영업마감시간" name="shop_close_hour" value="${vo.shop_close_hour}">
                              <label>영업 마감 시간</label>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating">
                              <select class="form-control" placeholder="휴무일" name="shop_close_day">
                                <option class="form-control" value="monday" <c:if test="${vo.shop_close_day == 'monday'}">selected</c:if>>월요일</option>
                                <option class="form-control" value="tuesday" <c:if test="${vo.shop_close_day == 'tuesday'}">selected</c:if>>화요일</option>
                                <option class="form-control" value="wednesday" <c:if test="${vo.shop_close_day == 'wednesday'}">selected</c:if>>수요일</option>
                                <option class="form-control" value="thursday" <c:if test="${vo.shop_close_day == 'thursday'}">selected</c:if>>목요일</option>
                                <option class="form-control" value="friday" <c:if test="${vo.shop_close_day == 'friday'}">selected</c:if>>금요일</option>
                                <option class="form-control" value="saturday" <c:if test="${vo.shop_close_day == 'saturday'}">selected</c:if>>토요일</option>
                                <option class="form-control" value="sunday" <c:if test="${vo.shop_close_day == 'sunday'}">selected</c:if>>일요일</option>
                              </select>
                            </div>
                          </div>
                          <!-- <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="휴무일" name="shop_close_day" value="${vo.shop_close_day}">
                              <label>휴무일</label>
                            </div>
                          </div> -->
                          
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="배달지역" name="shop_area" value="${vo.shop_area}">
                              <label>배달지역</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <select class="form-control" placeholder="음식카테고리" name="food_category">
                                <option class="form-control" value="pork_trotters" <c:if test="${vo.food_category == 'pork_trotters'}">selected</c:if>>족발·보쌈</option>
                                <option class="form-control" value="pizza" <c:if test="${vo.food_category == 'pizza'}">selected</c:if>>피자</option>
                                <option class="form-control" value="chicken" <c:if test="${vo.food_category == 'chicken'}">selected</c:if>>치킨</option>
                                <option class="form-control" value="japanese_food" <c:if test="${vo.food_category == 'japanese_food'}">selected</c:if>>돈까스·회·일식</option>
                                <option class="form-control" value="korea_food" <c:if test="${vo.food_category == 'korea_food'}">selected</c:if>>한식</option>
                                <option class="form-control" value="chinese_food" <c:if test="${vo.food_category == 'chinese_food'}">selected</c:if>>중식</option>
                                <option class="form-control" value="asian_food" <c:if test="${vo.food_category == 'asian_food'}">selected</c:if>>아시안</option>
                                <option class="form-control" value="porridge_noodle" <c:if test="${vo.food_category == 'porridge_noodle'}">selected</c:if>>백반·죽·국수</option>
                                <option class="form-control" value="snack_food" <c:if test="${vo.food_category == 'snack_food'}">selected</c:if>>분식</option>
                                <option class="form-control" value="desserts" <c:if test="${vo.food_category == 'desserts'}">selected</c:if>>카페·디저트</option>
                                <option class="form-control" value="fast_food" <c:if test="${vo.food_category == 'fast_food'}">selected</c:if>>패스트푸드</option>
                            </select>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating form-control">
                              <input type="radio" name="shop_status" value="영업전" checked="checked">영업전</input>
                              <input type="radio" name="shop_status" value="영업중">영업중</input>
                              <input type="radio" name="shop_status" value="휴무일">휴무일</input>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input class="form-control" type="file" name="photo" value="${vo.shop_img}">
                              <label>사진</label>
                            </div>
                          </div>
    
                          <div class="text-center">
                            <!-- <button type="submit" class="btn btn-primary">Submit</button>
                          <button type="reset" class="btn btn-secondary">Reset</button> -->
                            <input class="btn btn-success" type="button" value="메인화면" onclick="location.href='list.do'">
    
                            <input class="btn btn-primary" type="button" value="가게수정" onclick="send(this.form);">
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