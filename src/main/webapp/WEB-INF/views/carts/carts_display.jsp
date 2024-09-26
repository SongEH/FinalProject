<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    .delete-button {
      background-color: #ff4d4d;
      color: white;
      padding: 5px 10px;
      border: none;
      cursor: pointer;
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
  </style>
</head>

<script>
  function deleteItem(cartsId) {
    $.ajax({
      url: '/carts/delete2.do',
      type: 'POST',
      data: {
        carts_id: cartsId
      },
      success: function (response) {
        alert("삭제되었습니다.");
        location.reload();
      },
      error: function (xhr, status, error) {
        alert("삭제에 실패했습니다: " + xhr.responseText);
      }
    });
  }

  function orderFromShop(shop_id, shop_name) {
    location.href = "/order/pending_order.do?shop_id=" + shop_id + "&shop_name=" + shop_name;
  }

  function updateQuantity(cartsId, operation) {
    // 수량 업데이트 로직 추가 필요
    alert(cartsId + "의 수량이 " + operation + "되었습니다.");
  }
</script>

<body>
  <c:set var="currentShopId" value="" />
  <c:set var="currentShopTotal" value="0" />
  <c:set var="totalPrice" value="0" />

  <!-- 메뉴 리스트 순회 -->
  <c:forEach var="item" items="${list}">
    <!-- 가게별 구분 -->
    <c:if test="${item.shop_id != currentShopId}">
      <!-- 이전 가게의 주문 버튼과 총 가격 표시 -->
      <c:if test="${currentShopId != ''}">
        <p>총 가격: ${currentShopTotal}원</p>
        <button class="order-button" onclick="orderFromShop('${currentShopId}', '${currentShopName}')">주문</button>
      </c:if>
      
      <!-- 가게명 및 가게별 총 가격 초기화 -->
      <p class="shop-info">가게명: ${item.shop_name} ${status}</p>
      <c:set var="currentShopId" value="${item.shop_id}" />
      <c:set var="currentShopName" value="${item.shop_name}" />
      <c:set var="currentShopTotal" value="0" />
    </c:if>

    <!-- 메뉴 아이템 표시 -->
    <div class="menu-item">
      <div class="menu-details">
        <span class="menu-name">${item.menu_name}</span>
        <div class="quantity-controls">
          <button onclick="updateQuantity('${item.carts_id}', 'minus')">-</button>
          <span>${item.carts_quantity}</span>
          <button onclick="updateQuantity('${item.carts_id}', 'plus')">+</button>
        </div>
        <span>${item.carts_quantity * item.menu_price}원</span>
        <button class="delete-button" onclick="deleteItem('${item.carts_id}')">삭제</button>
      </div>
    </div>

    <!-- 가게별 총 가격 계산 -->
    <c:set var="currentShopTotal" value="${currentShopTotal + (item.carts_quantity * item.menu_price)}" />
    <c:set var="totalPrice" value="${totalPrice + (item.carts_quantity * item.menu_price)}" />
    <c:set var="status" value="${item.status}"/>
  </c:forEach>

  
  <!-- 마지막 가게의 주문 버튼과 총 가격 출력 -->
  <c:if test="${currentShopId !='' && status=='영업중'}">
    <p>총 가격: ${currentShopTotal}원</p>
    <button class="order-button" onclick="orderFromShop('${currentShopId}', '${currentShopName}')">주문</button>
  </c:if>

  <!-- 전체 가격 출력 -->
  <div class="total-price">
    장바구니 총 가격: ${totalPrice}원
  </div>
</body>


</html>