<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8" />
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
      border-radius: 5px;
    }

    #pop_content {
      min-height: 80px;
    }

    #pop_quantity {
      width: 100px;
    }

    #content1 {
      text-align: center;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
    }

    th,
    td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }

    input[type="number"] {
      width: 50px;
    }
  </style>
</head>

<body>
  <!-- 공통 css import -->
  <%@include file="../common.jsp" %>

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
          <div style="text-align: center; height: 310px">
            <img id="pop_image" />
          </div>

          <!-- menu id -->
          <input type="hidden" id="pop_hidden_menuid" />
          <input type="hidden" id="pop_hidden_shopid" />

          <div id="content1">
            <br>
            <h5 class="modal-title" id="pop_title">메뉴명</h5>

            <table>
              <tr>
                <th>설명</th>
                <td id="pop_content">메뉴에 대한 자세한 설명이 여기에 들어갑니다.</td>
              </tr>
              <tr>
                <th>가격</th>
                <td id="pop_price">₩00,000</td>
              </tr>
              <tr>
                <th>수량</th>
                <td>
                  <input type="number" id="pop_quantity" class="form-control" min="1" max="50" value="1" />
                </td>
              </tr>
            </table>
          </div>
          <div class="modal-footer">
            <button type="button" class="button_style" data-bs-dismiss="modal">
              닫기
            </button>
            <button type="button" class="button_style" onclick="input_cart();">
              장바구니담기
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>

</html>