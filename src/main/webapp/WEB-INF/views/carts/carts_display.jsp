<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8" />
  <title>장바구니</title>
  <style>
    .menu-item {
      padding: 10px;
    }

    .menu-details {
      display: flex;
      justify-content: space-between;
      align-items: left;
      margin-bottom: 5px;
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

    .store-total-price {
      border-bottom: 1px solid #ddd;
      padding-bottom: 10px;
    }

    .total-price {
      font-size: 18px;
      font-weight: bold;
      text-align: right;
    }

    .shop-info {
      margin-left: 10px;
      margin-top: 20px;
      font-size: 16px;
      font-weight: bold;
    }

    .small_btn {
      width: 25px !important;
      height: 25px !important;
      padding: 3px !important;
      color: black !important;
      background-color: white !important;
    }
  </style>
</head>

<script>
  // 장바구니 목록 업데이트
  function updateCartList() {
    $.ajax({
      url: "/carts/listFromDisplay.do",
      type: "GET",
      success: function (response) {
        // 응답으로 받은 HTML을 장바구니 목록에 업데이트
        $("#cart_list").html(response);
      },
      error: function (xhr, status, error) {
        alert(
          "장바구니 목록을 불러오는 데 실패했습니다: " + xhr.responseText
        );
      },
    });
  }

  function deleteItem(cartsId) {
    // 기본 클릭 이벤트를 차단합니다.
    event.preventDefault();

    $.ajax({
      url: "/carts/deleteFromDisplay.do",
      type: "GET", // GET 방식으로 변경
      data: {
        carts_id: cartsId,
      },
      success: function (response) {
        alert(response); // 서버에서 보낸 메시지 표시
        updateCartList();
      },
      error: function (xhr, status, error) {
        alert("삭제에 실패했습니다: " + xhr.responseText);
      },
    });
  }

  function orderFromShop(shop_id, shop_name, currentShopTotal) {
    // 기본 클릭 이벤트를 차단. main/display.do로 가지않도록 막음
    event.preventDefault();

    let shopMinPriceInput = document.getElementById(
      "shop_min_price_" + shop_id
    ).value;

    if (parseInt(shopMinPriceInput) > parseInt(currentShopTotal)) {
      alert(shopMinPriceInput + "원 이상이어야 주문 가능합니다.");
      return;
    }

    // order_addr 요소를 선택
    const orderAddrInput = document.getElementById("order_addr");
    const orderAddrZipCodeInput =
      document.getElementById("order_addr_zipcode");

    // value 값을 가져옴
    const orderAddrValue = orderAddrInput.value;
    const orderAddrZipCodeValue = orderAddrZipCodeInput.value;

    // 직접 페이지 이동
    window.location.href =
      "/order/pending_order.do?shop_id=" +
      shop_id +
      "&shop_name=" +
      shop_name +
      "&order_addr=" +
      orderAddrValue +
      "&order_addr_zipcode=" +
      orderAddrZipCodeValue;
  }

  function updateQuantity(cartsId, operation) {
    // 수량 업데이트 로직 추가 필요
    alert(cartsId + "의 수량이 " + operation + "되었습니다.");
  }
</script>

<body>
  <!-- 공통 css import -->
  <%@include file="../common.jsp" %>

  <c:if test="${empty list}">
    <div style="text-align: center; margin-top: 65px">
      장바구니가 비어있습니다.
    </div>
  </c:if>

  <c:if test="${not empty list}">
    <c:set var="currentShopId" value="" />
    <c:set var="currentShopTotal" value="0" />
    <c:set var="totalPrice" value="0" />

    <!-- 메뉴 리스트 순회 -->
    <c:forEach var="item" items="${list}">
      <!-- 가게 최소 주문금액 -->
      <input type="hidden" value="${item.shop_min_price}" id="shop_min_price_${item.shop_id}" name="shop_min_price" />

      <!-- 가게별 구분 -->
      <c:if test="${item.shop_id != currentShopId}">
        <!-- 이전 가게의 주문 버튼과 총 가격 표시 -->
        <c:if test="${currentShopId != '' && shop_status=='영업중'}">
          <p style="margin-left: 10px" class="store-total-price">
            총 가격:
            <fmt:formatNumber value="${currentShopTotal}" pattern="#,###" />원
            <button class="order-button button_style"
              onclick="orderFromShop('${currentShopId}', '${currentShopName}', '${currentShopTotal}')">
              주문
            </button>
          </p>
        </c:if>

        <!-- 가게명 및 가게별 총 가격 초기화 -->
        <p class="shop-info">${item.shop_name}</p>
        <c:set var="currentShopId" value="${item.shop_id}" />
        <c:set var="currentShopName" value="${item.shop_name}" />
        <c:set var="currentShopTotal" value="0" />
      </c:if>

      <!-- 메뉴 아이템 표시 -->
      <div class="menu-item">
        <div class="menu-details">
          <span class="menu-name">${item.menu_name}</span>
          <div class="quantity-controls">
            <span>${item.carts_quantity}개</span>
          </div>
          <span>
            <fmt:formatNumber value="${item.carts_quantity * item.menu_price}" pattern="#,###" />원</span>
          <button class="button_style small_btn" onclick="deleteItem('${item.carts_id}')">
            x
          </button>
        </div>
      </div>

      <!-- 가게별 총 가격 계산 -->
      <c:set var="currentShopTotal" value="${currentShopTotal + (item.carts_quantity * item.menu_price)}" />
      <!-- 주문버튼 클릭시 가게 메뉴 총 가격 전달 -->
      <input type="hidden" value="${currentShopTotal}" id="currentShopTotal_${item.shop_id}" name="currentShopTotal" />
      <c:set var="totalPrice" value="${totalPrice + (item.carts_quantity * item.menu_price)}" />
      <c:set var="shop_status" value="${item.shop_status}" />
    </c:forEach>

    <!-- 마지막 가게의 주문 버튼과 총 가격 출력 -->
    <c:if test="${currentShopId !='' && shop_status=='영업중'}">
      <p style="margin-left: 10px" class="store-total-price">
        총 가격:
        <fmt:formatNumber value="${currentShopTotal}" pattern="#,###" />원
        <button class="order-button button_style"
          onclick="orderFromShop('${currentShopId}', '${currentShopName}', '${currentShopTotal}')">
          주문
        </button>
      </p>
    </c:if>

    <!-- 전체 가격 출력 -->
    <div class="total-price">
      장바구니 총 가격:
      <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
    </div>
  </c:if>
</body>

</html>