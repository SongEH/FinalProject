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
        alert(f.shop_id.value)
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
                                tyle="height: 100px;"></textarea>
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
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="영업시작시간" name="shop_open_time" value="${vo.shop_open_time}">
                              <label>영업시작시간</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="영업마감시간" name="shop_close_time" value="${vo.shop_close_time}">
                              <label>영업마감시간</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="휴무일" name="shop_close_day" value="${vo.shop_close_day}">
                              <label>휴무일</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="배달지역" name="shop_area" value="${vo.shop_area}">
                              <label>배달지역</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <select class="form-control" placeholder="음식카테고리" name="food_category" value="${vo.food_category}">
                                <option class="form-control" value="pork_trotters">족발 보쌈</option>
                                <option class="form-control" value="korea_food">한식</option>
                                <option class="form-control" value="japanese_food">돈까스 회 일식</option>
                                <option class="form-control" value="west_food">피자/양식</option>
                                <option class="form-control" value="chicken">치킨</option>
                                <option value="chinese_food">중식</option>
                                <option value="asian_food">아시안</option>
                                <option value="porridge_noodle">백반 죽 국수</option>
                                <option value="snack_food">분식</option>
                                <option value="desserts">디저트</option>
                                <option value="fast_food">패스트푸드</option>
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
                              <input class="form-control" type="file" name="photo">
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