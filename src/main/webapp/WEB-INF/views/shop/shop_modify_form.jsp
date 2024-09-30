<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="utf-8">
      <script type="text/javascript" src="${pageContext.request.contextPath}/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <script>
      function send(f){

        let shop_id = f.shop_id.value;
        let shop_content = oEditors.getById["shop_content"].getIR();
        f.action = "modify.do";
        f.submit();
      }

      function formatPhoneNumber(input) {
      // 숫자만 남기기
      let shop_call = input.value.replace(/\D/g, "");

      // 최대 11자리까지만 허용
      if (shop_call.length > 11) {
        shop_call = shop_call.slice(0, 11);
      }

      // 형식에 맞게 변환
      if (shop_call.length > 6) {
        input.value = shop_call.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
      } else if (shop_call.length > 3) {
        input.value = shop_call.replace(/(\d{3})(\d{0,4})/, "$1-$2");
      } else {
        input.value = shop_call;
      }
    }

    </script>
    <script>
    var oEditors = [];
    $(function(){
          nhn.husky.EZCreator.createInIFrame({
              oAppRef: oEditors,
              elPlaceHolder: "shop_content", //textarea에서 지정한 id와 일치해야 합니다. 
              //SmartEditor2Skin.html 파일이 존재하는 경로
              sSkinURI: "${pageContext.request.contextPath}/resources/smarteditor2/SmartEditor2Skin.html",
          htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
            fOnBeforeUnload : function() {
    
            }
          },
          fOnAppLoad : function() {
            //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
            /* oEditors.getById["ir1"].exec("PASTE_HTML", ["기존 DB에 저장된 내용을 에디터에 적용할 문구"]); */
            oEditors.getById["shop_content"].exec();
          },
          fCreator : "createSEditor2"
        });
    
        //저장버튼 클릭시 form 전송
        $("#modifyShop").click(function() {
          oEditors.getById["shop_content"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
        });
    
      });
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
                        <form class="row g-3" id="frm" method="POST" action="modify.do" enctype="multipart/form-data">
                          
                          <!-- 가게 ID -->
                          <input type="hidden" name="shop_id" value="${vo.shop_id}">
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="상호명" name="shop_name" value="${vo.shop_name}">
                              <label style="color:#F0A8D0;">상호명</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="row">
                              <div class="col-md-5">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="shop_addr1" placeholder="주소찾기 버튼을 눌러주세요." name="shop_addr1" value="${vo.shop_addr1}" readonly>
                                    <label style="color:#F0A8D0;">가게주소</label>
                                </div>
                              </div>
                              <div class="col-md-5">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="shop_addr2" placeholder="상세주소를 입력해주세요" name="shop_addr2" value="${vo.shop_addr2}">
                                    <label style="color:#F0A8D0;">상세주소</label>
                                </div>
                              </div>
                              <div class="col-md-2">
                                <div class="form-floating">
                                    <button type="button" class="form-control" style="background-color: #F7B5CA;"  id="addressSearch" onclick="findAddr()">주소 찾기</button>
                                </div>
                              </div>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="가게 전화번호" name="shop_call" id="shop_call" value="${vo.shop_call}" oninput="formatPhoneNumber(this);">
                              <label style="color:#F0A8D0;">가게전화번호</label>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="최소주문금액" name="shop_min_price" value="${vo.shop_min_price}">
                              <label style="color:#F0A8D0;">최소주문금액</label>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="form-floating">
                              <input type="time" class="form-control" placeholder="영업오픈시간" name="shop_open_hour" value="${vo.shop_open_hour}">
                              <label style="color:#F0A8D0;">영업 오픈 시간</label>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="form-floating">
                              <input type="time" class="form-control" placeholder="영업마감시간" name="shop_close_hour" value="${vo.shop_close_hour}">
                              <label style="color:#F0A8D0;">영업 마감 시간</label>
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
                              <label style="color:#F0A8D0;">휴무일</label>
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
                            <label style="color:#F0A8D0;">음식 카테고리</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input class="form-control" type="file" name="photo" value="${vo.shop_img}">
                              <label style="color:#F0A8D0;">사진</label>
                            </div>
                          </div>

                          <div class="col-md-12">
                            <label style="color:#F0A8D0;">가게소개글 </label>
                            <div class="form-floating" style="width: 100%; border-radius: 5px;">
                                <textarea class="form-control" placeholder="소개글" name="shop_content" id="shop_content" rows="7" style="height:300px; resize:none; width: 90%;">${vo.shop_content}</textarea>
                            </div>
                          </div>
    
                          <div class="text-center">
                            <!-- <button type="submit" class="btn btn-primary">Submit</button>
                          <button type="reset" class="btn btn-secondary">Reset</button> -->
                            <input class="button_style" type="button" value="메인화면" onclick="location.href='list.do'">
    
                            <input class="button_style" id="modifyShop" type="button" value="가게수정" onclick="send(this.form);">
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