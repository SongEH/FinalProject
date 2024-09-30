<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>장바구니</title>
  <style>
    .menu-item {
      padding: 10px;
      border-bottom: 1px solid #ddd;
    }

    .menu-details {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }

    .quantity-controls {
      display: flex;
      align-items: center;
    }

    .quantity-controls button {
      padding: 5px;
      font-size: 16px;
      margin: 0 5px;
      cursor: pointer;
    }

    .menu-name {
      font-weight: bold;
    }

    .total-price {
      font-size: 18px;
      font-weight: bold;
      text-align: right;
    }

    .shop-info {
      margin-top: 20px;
      font-size: 16px;
      font-weight: bold;
    }

    .order-button {
      margin-top: 10px;
      background-color: #007bff;
      color: white;
      padding: 5px 10px;
      border: none;
      cursor: pointer;
    }

    .small_btn {
      width: 25px !important;
      height: 25px !important;
      padding: 3px !important;
    }
  </style>
</head>

<script>
  // 회원용 장바구니 리스트 업데이트
  function updateCartList() {
    // 장바구니 목록을 업데이트하기 위한 AJAX 요청 - 한지혜
    $.ajax({
      url: '/carts/list2.do',
      type: 'GET',
      success: function (response) {
        // 응답으로 받은 HTML을 장바구니 목록에 업데이트
        $('#cart_list').html(response);
      },
      error: function (xhr, status, error) {
        alert("장바구니 목록을 불러오는 데 실패했습니다: " + xhr.responseText);
      }
    });
  }

  function deleteItem(cartsId) {
    // 기본 클릭 이벤트를 차단합니다.
    event.preventDefault();

    $.ajax({
      url: '/carts/delete2.do',
      type: 'GET', // GET 방식으로 변경
      data: {
        carts_id: cartsId
      },
      success: function (response) {
        alert(response); // 서버에서 보낸 메시지를 표시
        updateCartList();
        // location.reload(); // 필요시 페이지 새로고침
      },
      error: function (xhr, status, error) {
        alert("삭제에 실패했습니다: " + xhr.responseText);
      }
    });
  }




  function orderFromShop(shop_id, shop_name) {

    // order_addr 요소를 선택합니다.
    const orderAddrInput = document.getElementById('order_addr');
    const orderAddrZipCodeInput = document.getElementById('order_addr_zipcode');

    // value 값을 가져옵니다.
    const orderAddrValue = orderAddrInput.value;
    const orderAddrZipCodeValue = orderAddrZipCodeInput.value;

    // 가져온 값을 콘솔에 출력합니다.
    console.log(orderAddrValue);

    // 기본 클릭 이벤트를 차단. main/display.do로 가지않도록 막음
    event.preventDefault();

    // 직접 페이지 이동
    window.location.href = "/order/pending_order.do?shop_id=" + shop_id + "&shop_name=" + shop_name + "&order_addr=" +
      orderAddrValue + "&order_addr_zipcode=" + orderAddrZipCodeValue;
  }

  function updateQuantity(cartsId, operation) {
    // 수량 업데이트 로직 추가 필요
    alert(cartsId + "의 수량이 " + operation + "되었습니다.");
  }
</script>

<body>
  <!-- 공통 css import -->
  <%@include file="../common.jsp" %>


  <c:set var="currentShopId" value="" />
  <c:set var="currentShopTotal" value="0" />
  <c:set var="totalPrice" value="0" />

  <table style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
    <thead>
      <tr style="background-color: #f0f0f0;">
        <th style="padding: 10px; text-align: left;">메뉴 이름</th>
        <th style="padding: 10px; text-align: center;">수량</th>
        <th style="padding: 10px; text-align: right;">가격</th>
        <th style="padding: 10px; text-align: center;">삭제</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="item" items="${list}">
        <c:if test="${item.shop_id != currentShopId}">
          <!-- 가게명 표시 -->
          <p class="shop-info">${item.shop_name}</p>

          <!-- 이전 가게의 주문 버튼과 총 가격 표시 -->
          <c:if test="${currentShopId != '' && status == '영업중'}">
            <p>총 가격:
              <fmt:formatNumber value="${currentShopTotal}" pattern="#,###" />원
              <button class="order-button button_style"
                onclick="orderFromShop('${currentShopId}', '${currentShopName}')">주문</button>
            </p>
          </c:if>

          <!-- 가게별 총 가격 초기화 -->
          <c:set var="currentShopId" value="${item.shop_id}" />
          <c:set var="currentShopName" value="${item.shop_name}" />
          <c:set var="currentShopTotal" value="0" />
        </c:if>

        <!-- 메뉴 아이템 표시 -->
        <tr>
          <td style="padding: 10px;">${item.menu_name}</td>
          <td style="padding: 10px; text-align: center;">
            <div class="quantity-controls">
              <button class="button_style small_btn" onclick="updateQuantity('${item.carts_id}', 'minus')">-</button>
              <span>${item.carts_quantity}</span>
              <button class="button_style small_btn" onclick="updateQuantity('${item.carts_id}', 'plus')">+</button>
            </div>
          </td>
          <td style="padding: 10px; text-align: right;">
            <fmt:formatNumber value="${item.carts_quantity * item.menu_price}" pattern="#,###" />원
          </td>
          <td style="padding: 10px; text-align: center;">
            <button class="button_style small_btn" onclick="deleteItem('${item.carts_id}')">x</button>
          </td>
        </tr>

        <!-- 가게별 총 가격 계산 -->
        <c:set var="currentShopTotal" value="${currentShopTotal + (item.carts_quantity * item.menu_price)}" />
        <c:set var="totalPrice" value="${totalPrice + (item.carts_quantity * item.menu_price)}" />
        <c:set var="status" value="${item.status}" />
      </c:forEach>
    </tbody>
  </table>

  <!-- 마지막 가게의 주문 버튼과 총 가격 출력 -->
  <c:if test="${currentShopId != '' && status == '영업중'}">
    <p>총 가격:
      <fmt:formatNumber value="${currentShopTotal}" pattern="#,###" />원
      <button class="order-button button_style"
        onclick="orderFromShop('${currentShopId}', '${currentShopName}')">주문</button>
    </p>
  </c:if>

  <!-- 전체 가격 출력 -->
  <div class="total-price">
    장바구니 총 가격:
    <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
  </div>




</body>


</html>