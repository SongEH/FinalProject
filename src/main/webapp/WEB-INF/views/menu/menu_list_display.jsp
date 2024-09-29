<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <script type="text/javascript">
    // JSP에서 userType 값을 JavaScript로 전달
    var userType = '<%= session.getAttribute("userType") %>';

    // shop_listOne.jsp에서 장바구니 목록 표시
    $(document).ready(function () {
      if (userType === 'MEMBER') {
        updateCartList('${status}'); // 페이지 로딩 시 함수 실행
      } else if (userType === "UNKNOWN") {
        $('#cart_list').html('<p>로그인해주세요.</p>');
      }
    });


    // 회원용 장바구니담기 누르면 모달 팝업
    function menu_modal(menu_id, menu_soldout) {

      if (menu_soldout == 1) {
        alert("품절 상품은 담을 수 없습니다.");
        return;
      }

      // Show the modal
      var myModal = new bootstrap.Modal(document.getElementById('menuModal'), {
        backdrop: 'static',
        keyboard: false
      });

      myModal.show();

      // menu_id에 대한 메뉴정보 가져오기(Ajax이용 JSON형식)
      $.ajax({
        url: "/menu/menu_one.do",
        data: {
          "menu_id": menu_id
        }, //parameter => menu_one.do?menu_id=5
        dataType: "json",
        success: function (res_data) {
          //popup modal에 넣을 값 
          $("#pop_image").prop("src", "../resources/images/" + res_data.menu_img);
          $("#pop_title").html(res_data.menu_name);
          $("#pop_content").html(res_data.menu_content);
          $("#pop_regdate").html(res_data.menu_cdate);
          $("#pop_price").html(res_data.menu_price);
          $('#pop_hidden_menuid').val(menu_id);
          $('#pop_hidden_shopid').val(res_data.shop_id);
        },
        error: function (err) {
          alert(err.responseText);
        }
      });
    }

    // 회원용 장바구니 담기
    function input_cart() {

      // 모달창에서 hidden 태그의 값을 가져온다. 
      menu_id = document.getElementById("pop_hidden_menuid").value;
      shop_id = document.getElementById("pop_hidden_shopid").value;
      carts_quantity = document.getElementById("pop_quantity").value;

      // 장바구니 추가 회원ID, 가게ID, 메뉴ID, 수량 추가 
      $.ajax({
        url: '/carts/insert.do',
        type: 'POST',
        data: {
          menu_id: menu_id,
          shop_id: shop_id,
          carts_quantity: carts_quantity
        },
        success: function (response) {
          updateCartList();
          alert("장바구니에 추가되었습니다!");
        },
        error: function (xhr, status, error) {
          alert("장바구니에 아이템을 추가하는 데 실패했습니다: " + xhr.responseText);
        }
      });

      var modal = bootstrap.Modal.getInstance(document.getElementById('menuModal'));
      modal.hide();
    }

    // 장바구니 목록 업데이트
    function updateCartList(status) {
      $.ajax({
        url: '/carts/list2.do',
        type: 'GET',
        data: {
          "status": status
        },
        success: function (response) {
          // 응답으로 받은 HTML을 장바구니 목록에 업데이트
          $('#cart_list').html(response);
        },
        error: function (xhr, status, error) {
          alert("장바구니 목록을 불러오는 데 실패했습니다: " + xhr.responseText);
        }
      });
    }
  </script>

  <style>
    .menu-card {
      background-color: white;
      border-radius: 8px;
      padding: 2px 15px; /* 상하 2px, 좌우 15px */
      margin-bottom: 20px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    td{
      padding-bottom: 7px !important;
    }
    .menu-img {
      border-radius: 8px;
      width: 100%;
      height: auto; /* 자동 높이 조정 */
      object-fit: cover; /* 비율 유지 */
    }

  </style>
</head>

<body>
  <!-- popup:Modal -->
  <%@include file="menu_popup.jsp" %>

  ${status}

  <c:set var="userType" value="${sessionScope.userType}" />



  <c:forEach var="item" items="${menu_list}">

    <!-- item.menu_status가 1인 경우만 표시 -->
    <c:if test="${item.menu_status == 1}">

      <!-- menu_hidden이 0인 경우를 표시합니다 -->
      <c:if test="${ item.menu_hidden == 0}">

        <div class="menu-card">
          <table style="width: 100%; border-collapse: collapse;">
            <tr>
              <td style="width: 150px; vertical-align: top;">
                <img id="menuImg" src="../resources/images/${item.menu_img}" alt="..." class="menu-img">
              </td>
              <td style="padding-left: 15px; vertical-align: top;">
                <h5>
                  <c:choose>
                    <c:when test="${item.menu_popularity == 1}">인기</c:when>
                    <c:when test="${item.menu_soldout == 1}">품절</c:when>
                    <c:otherwise></c:otherwise>
                  </c:choose>
                  ${item.menu_name}
                </h5>
                <p style="margin: 5px 0;">${item.menu_content}</p>
                <p style="margin: 5px 0;">${item.menu_price}원</p>

                <c:if test="${status == '영업중'}">
                  <input class="button_style" type="button" value="장바구니담기"
                    onclick="menu_modal('${ item.menu_id }', '${ item.menu_soldout }');" style="margin-top:-130px; margin-left:350px;">
                </c:if>
              </td>
            </tr>
          </table>
        </div>

      </c:if>
    </c:if>
  </c:forEach>



</body>


</html>