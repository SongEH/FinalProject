<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- cart_list.jsp -->
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>장바구니</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      padding: 20px;
      background-color: #f9f9f9;
    }

    h5 {
      margin: 10px 0;
      font-size: 1.5em;
    }

    .menu-item {
      border: 1px solid #ddd;
      border-radius: 5px;
      padding: 15px;
      margin-bottom: 15px;
      background-color: #fff;
    }

    .menu-details {
      margin: 10px 0;
    }

    button {
      padding: 8px 12px;
      margin-right: 5px;
      border: none;
      border-radius: 4px;
      background-color: #007bff;
      color: white;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #0056b3;
    }

    .order-button {
      margin-top: 20px;
      font-size: 1.2em;
    }
  </style>
</head>

<body>

  <script>
    // 장바구니 아이템 삭제
    function deleteItem(cartsId) {
      // AJAX 요청으로 carts_id를 컨트롤러로 전송
      $.ajax({
        url: '/carts/delete2.do', // URL을 적절히 설정
        type: 'POST',
        data: {
          carts_id: cartsId
        },
        success: function (response) {
          // 성공적으로 삭제되었을 경우 처리
          alert("삭제되었습니다.");
          location.reload(); // 페이지 새로고침
        },
        error: function (xhr, status, error) {
          alert("삭제에 실패했습니다: " + xhr.responseText);
        }
      });
    }

    // 주문 
    function orderFromShop(shop_id, shop_name) {
      location.href = "/order/pending_order.do?shop_id=" + shop_id + "&shop_name=" + shop_name;
    }
  </script>

  <c:set var="currentShopId" value="" />
  <c:set var="currentShopName" value="" />
  <c:set var="itemCount" value="0" />

  <c:forEach var="item" items="${list}">
    <c:if test="${item.shop_id != currentShopId}">
      <c:if test="${itemCount > 0}">
        <!-- 이전 상점 그룹의 주문 버튼 -->
        <button class="order-button" onclick="orderFromShop('${currentShopId}', '${currentShopName}')">주문</button>
      </c:if>

      <h5>가게명 : ${item.shop_name}</h5>
      <c:set var="currentShopId" value="${item.shop_id}" />
      <c:set var="currentShopName" value="${item.shop_name}" /> <!-- 현재 상점 이름 저장 -->
      <c:set var="itemCount" value="0" />
    </c:if>

    <div class="menu-item">
      <div class="menu-details">
        <p>${item.menu_name}</p>
        <p>개수: ${item.carts_quantity} / ${item.menu_price}원</p>
      </div>
      <button onclick="deleteItem('${item.carts_id}')">삭제</button>
    </div>

    <c:set var="itemCount" value="${itemCount + 1}" />
  </c:forEach>

  <!-- 마지막 상점 그룹의 주문 버튼 -->
  <c:if test="${itemCount > 0}">
    <button class="order-button" onclick="orderFromShop('${currentShopId}', '${currentShopName}')">주문</button>
  </c:if>

</body>

</html>