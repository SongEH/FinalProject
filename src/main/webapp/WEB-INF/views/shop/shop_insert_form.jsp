<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <!DOCTYPE html>
    <html lang="ko">

<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
  <script>
  function send(f) {

    var reqCall = /^\d{2,3}-\d{3,4}-\d{4}$/;

    let shop_name = f.shop_name.value.trim();
    let shop_content = oEditors.getById["shop_content"].getIR();
    alert(shop_content);
    // f.shop_content.value.trim();
    if(shop_content==""){
      alert("가게 소개글을 입력해주세요");
      return;
    }
    let shop_addr1 = f.shop_addr1.value.trim();
    let shop_addr2 = f.shop_addr2.value.trim();
    if(shop_addr1 == "" || shop_addr2 == ""){
      alert("가게 주소는 필수 등록입니다. 상세주소까지 입력해주세요.");
      return;
    }    // let shop_addr = shop_addr1 + " " + shop_addr2;
    let shop_call= f.shop_call.value.trim();
    if(shop_call==""){
      alert("가게 번호는 필수 입력입니다.");
      return;
    }
    if(!checkCall.test($("#shop_call").val())){
      return false;
    }
    let shop_min_price = f.shop_min_price.value.trim();
    if(shop_min_price==""){
      alert("최소 주문 가격 설정은 필수입니다.");
      return;
    }
    let shop_open_hour = f.shop_open_hour.value;
    let shop_close_hour = f.shop_close_hour.value;
    let shop_close_day = f.shop_close_day.value;
    let food_category = f.food_category.value;

    f.action = "insert.do";
    f.submit();
  }
</script>
  <script>
  // findAddr() function definition
  function findAddr() {
    new daum.Postcode({
      oncomplete: function(data) {
        // Define a variable to receive the user address.
        let addr = '';

        // The address value according to the address type selected by the user
        if (data.userSelectedType === 'R') { // If the user selects the road name address (R)
            addr = data.roadAddress;
        } else { // If the user selects the Jibun address (J)
            addr = data.jibunAddress;
        }

        // Enter the received address in the address box
        $("#shop_addr1").val(addr);
      }
    }).open();
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
  $(document).ready(function() {
    var oEditors = []; // 여기서 oEditors를 초기화

    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "shop_content", // 정확한 ID 확인
        sSkinURI: "${pageContext.request.contextPath}/resources/smarteditor2/SmartEditor2Skin.html",
        htParams: {
            bUseToolbar: true,
            bUseVerticalResizer: true,
            bUseModeChanger: true,
            fOnBeforeUnload: function() {}
        },
        fOnAppLoad: function() {
            oEditors.getById["shop_content"].exec();
        },
        fCreator: "createSEditor2"
    });

    $("#insertShop").click(function() {
			oEditors.getById["shop_content"].exec("UPDATE_CONTENTS_FIELD", []);
			$("#frm").submit();
		});


    setTimeout(showMessage, 100);
});

    function showMessage(){
      if("${param.reason=='Register_shop'}" =="true"){
        alert("가맹점 등록 후 이용할 수 있습니다. ")
      }
    }

  </script>
<style>
  #addressSearch:hover{
    background-color: #e090b5 !important;
  }
</style>
</head>
    <body>
      <%@include file="../common.jsp" %>

        <!-- header import -->
        <%@include file="../header.jsp" %>

          <!-- side bar import -->
          <%@include file="../sidebar.jsp" %>


            <main id="main" class="main">
              <div class="pagetitle">

                <h1>가맹점 등록</h1><br>

                <nav>
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="../order/accept.do">Home</a></li>
                    <li class="breadcrumb-item">가맹점관리</li>
                    <li class="breadcrumb-item active">가맹점 등록</li>

                  </ol>
                </nav>
              </div><!-- End Page Title -->
              
              <div class="conatainer">
              <section class="section">
                <div class="row">
                  <div class="col-lg-10">
                    <div class="card">
                      <div class="card-body">
                        <h5></h5>
                        <!-- Floating Labels Form -->
                        <form class="row g-3" id="frm" method="POST" action="insert.do" enctype="multipart/form-data">
                          <!-- <input type="hidden" value="" /> -->
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="상호명" name="shop_name" id="shop_name">
                              <span id="shop_name_msg"></span>
                              <label >상호명</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="row">
                              <div class="col-md-5">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="shop_addr1" placeholder="주소찾기 버튼을 눌러주세요." name="shop_addr1" readonly>
                                    <label >가게주소</label>
                                </div>
                              </div>
                              <div class="col-md-5">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="shop_addr2" placeholder="상세주소를 입력해주세요" name="shop_addr2">
                                    <label >상세주소</label>
                                </div>
                              </div>
                              <div class="col-md-2">
                                <div class="form-floating">
                                    <button type="button" class="form-control button_style" style=" padding-top: 10px;" id="addressSearch" onclick="findAddr()">주소 찾기</button>
                                </div>
                              </div>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="text" class="form-control" placeholder="가게 전화번호" name="shop_call" id="shop_call" pattern="\d{2,3}-\d{3,4}-\d{4}" maxlength="11" oninput="formatPhoneNumber(this);">
                              <label >가게전화번호</label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input type="number" class="form-control" placeholder="최소주문금액" name="shop_min_price" >
                              <label >최소주문금액</label>
                            </div>
                          </div>

                          <div class="col-md-6">
                            <div class="form-floating">
                              <input type="time" class="form-control" placeholder="영업오픈시간" name="shop_open_hour" value="00:00">
                              <label >영업 오픈 시간 (미입력시 항상 영업중으로 표기됩니다.)</label>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="form-floating">
                              <input type="time" class="form-control" placeholder="영업마감시간" name="shop_close_hour" value="00:00">
                              <label >영업 마감 시간 (미입력시 항상 영업중으로 표기됩니다.)</label>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating">
                              <select class="form-control" placeholder="휴무일" name="shop_close_day">
                                <option class="form-control" value="">휴무없음</option>
                                <option class="form-control" value="Monday">월요일</option>
                                <option class="form-control" value="Tuesday">화요일</option>
                                <option class="form-control" value="Wednesday">수요일</option>
                                <option class="form-control" value="Thursday">목요일</option>
                                <option class="form-control" value="Friday">금요일</option>
                                <option class="form-control" value="Saturday">토요일</option>
                                <option class="form-control" value="Sunday">일요일</option>
                              </select>
                              <label >휴무일 </label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <select class="form-control" placeholder="음식카테고리" name="food_category">
                                <option class="form-control" value="pork_trotters">족발·보쌈</option>
                                <option class="form-control" value="pizza">피자</option>
                                <option class="form-control" value="chicken">치킨</option>
                                <option class="form-control" value="japanese_food">돈까스·회·일식</option>
                                <option class="form-control" value="korea_food">한식</option>
                                <option class="form-control" value="chinese_food">중식</option>
                                <option class="form-control" value="asian_food">아시안</option>
                                <option class="form-control" value="porridge_noodle">백반·죽·국수</option>
                                <option class="form-control" value="snack_food">분식</option>
                                <option class="form-control" value="desserts">카페·디저트</option>
                                <option class="form-control" value="fast_food">패스트푸드</option>
                              </select>
                              <label >음식 카테고리 </label>
                            </div>
                          </div>
    
                          <div class="col-md-12">
                            <div class="form-floating">
                              <input class="form-control" type="file" name="photo">
                              <label >사진</label>
                            </div>
                          </div>

                          <div class="col-md-12">
                            <div class="form-floating" style="width: 100%;">
                                <textarea class="form-control" placeholder="소개글" name="shop_content" id="shop_content" rows="7" style="height:200px; resize:none;"></textarea>
                                <label >가게소개글 </label>
                            </div>
                          </div>
    
                          <div class="text-center">
                            <!-- <button type="submit" class="btn btn-primary">Submit</button>
                          <button type="reset" class="btn btn-secondary">Reset</button> -->
                            <input class="button_style" type="button" value="메인화면" onclick="location.href='list.do'">
    
                            <input class="button_style" id="insertShop" type="button" value="가게등록" onclick="send(this.form);">
                          </div>
                        </form><!-- End floating Labels Form -->

                      </div>
                    </div>
                  </div>
                </div>
              </section>
            </div>

            </main><!-- End #main -->

    </body>

    </html>