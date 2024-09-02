<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>

  <style type="text/css">
    .mycommon {

      /* text-align: center; */
      width: 300px;
      margin: auto;
      border: 1px solid gray;
      margin-bottom: 10px;
      padding: 5px;

      box-shadow: 1px 1px 1px black;
    }

    #pop_image {
      width: 300px;
      height: 300px;
      border: 2px solid gray;
      outline: 2px solid black;
    }

    #pop_content {
      min-height: 80px;
    }
  </style>

</head>

<body>
  <!-- 이미지 팝업  -->
  <!-- Modal -->
  <div class="modal fade" id="menuModal" tabindex="-1" role="dialog" aria-labelledby="photoModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

        </div>

        <!-- 본문 -->
        <div class="modal-body">
          <div style="text-align: center; height: 310px;">
            <img id="pop_image">
          </div>


          <!-- menu id -->
          <input type="hidden" id="pop_hidden_menuid">
          <input type="hidden" id="pop_hidden_shopid">

          <h5 class="modal-title" id="pop_title">메뉴명</h5>
          <p><strong>설명:</strong> <span id="pop_content">메뉴에 대한 자세한 설명이 여기에 들어갑니다.</span></p>
          <p><strong>가격:</strong> <span id="pop_price">₩00,000</span></p>

          <!-- 수량 입력 -->
          <p><strong>수량:</strong>
            <input type="number" id="pop_quantity" class="form-control" min="1" max="50" value="1"></p>
          

          <!-- 메뉴별 옵션은 추후에 고려 -->
          <!-- <div class="mb-3">
            <label for="optionSelect" class="form-label">옵션 선택</label>
            <select class="form-select" id="optionSelect">
              <option selected>옵션을 선택하세요</option>
              <option value="1">옵션 1</option>
              <option value="2">옵션 2</option>
              <option value="3">옵션 3</option>
            </select>
          </div> -->

          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary" onclick="input_cart();">장바구니담기</button>
          </div>
        </div>
        <!--   
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div> -->
      </div>
    </div>
  </div>
</body>

</html>