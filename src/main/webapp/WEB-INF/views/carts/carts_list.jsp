<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <style>
    .cart-summary {
      margin-top: 20px;
    }
  </style>

  <script>
    // 장바구니에서 삭제
    function delete_carts(carts_id) {
      if (confirm("정말 삭제하시겠습니까?") == false) return;
      location.href = "delete.do?carts_id=" + carts_id;
    }

    // 주문 
    function orderFromShop(shop_id, shop_name) {
      location.href = "/order/pending_order.do?shop_id=" + shop_id + "&shop_name=" + shop_name;
    }
  </script>
</head>


<body>

  <%@include file="../common.jsp" %>

  <%@include file="../header.jsp" %>

  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">

      <h1>장바구니목록</h1>
      <br>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="../index.html">Home</a></li>
          <li class="breadcrumb-item">주문&리뷰</li>
          <li class="breadcrumb-item active">장바구니</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    <c:if test="${empty list}">
      <p>장바구니가 비어있습니다.</p>
    </c:if>

    <c:if test="${not empty list}">
      <section class="section">
        <div class="row align-items-top">
          <div class="col-lg-10">
            <!-- 현재 상점 ID를 저장할 변수 초기화 -->
            <c:set var="currentShopId" value="" />

            <!-- 가게별 출력 -->
            <c:forEach var="vo" items="${list}">
              <!-- 상점 ID가 변경되었는지 확인 -->
              <c:if test="${currentShopId != vo.shop_id}">
                <!-- 새로운 상점 ID가 발견되면 현재 상점 ID를 업데이트 -->
                <c:set var="currentShopId" value="${vo.shop_id}" />
                <table class="table">
                  <thead>
                    <tr>
                      <th colspan="7" style="background-color: #f8f9fa; text-align: left; padding: 10px;">
                        가게명 : ${vo.shop_name}
                        <button class="button_style"
                          onclick="orderFromShop('${vo.shop_id}','${vo.shop_name}')">주문</button>
                      </th>
                    </tr>
                    <tr>
                      <th>이미지</th>
                      <th>메뉴명</th>
                      <th>메뉴개수</th>
                      <th>메뉴가격</th>
                      <th>총 가격</th>
                      <th>추가일자</th>
                      <th></th>
                    </tr>
                  </thead>
              </c:if>

              <!-- 메뉴 출력 -->
              <tbody id="cartItems">
                <tr>
                  <td class="cart_menuimg">
                    <div>
                      <img src="../resources/images/${vo.menu_img}" class="img-fluid rounded" alt="..." width="100px">
                    </div>
                  </td>
                  <td class="cart_menuname">${vo.menu_name}</td>

                  <td class="cart_quantity">
                    <input type="number" class="form-control quantity-input" id="quantity_${vo.carts_id}"
                      value="${vo.carts_quantity}" min="1" max="50" disabled>
                  </td>

                  <td class="cart_price">${vo.menu_price}</td>
                  <td class="cart_total_price">
                    ${vo.menu_price * vo.carts_quantity}
                  </td>
                  <td class="cart_cdate">
                    <fmt:formatDate value="${vo.carts_cdate}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
                  </td>

                  <td>
                    <input class="button_style" type="button" value="삭제" onclick="delete_carts('${vo.carts_id}');">
                    <input class="button_style" type="button" id="edit_${vo.carts_id}" value="수정"
                      onclick="editQuantity('${vo.carts_id}');">
                    <button class="button_style" id="save_${vo.carts_id}" onclick="saveQuantity('${vo.carts_id}')"
                      style="display: none;">저장</button>
                  </td>
                </tr>
            </c:forEach>
            </tbody>
            <br>
            <tfoot>
              <tr>
                <td colspan="3" class="text-right"><strong>총 개수:</strong></td>
                <td id="total_quantity">0</td>
                <td colspan="2" class="text-right"><strong>총 가격:</strong></td>
                <td id="total_price">0</td>
              </tr>
            </tfoot>

            <script>
              document.addEventListener('DOMContentLoaded', function () {
                const currencyFormatter = new Intl.NumberFormat('ko-KR', {
                  style: 'currency',
                  currency: 'KRW',
                  minimumFractionDigits: 0
                });

                function updateTotals() {
                  let totalQuantity = 0;
                  let totalPrice = 0;

                  // 각 행을 순회하며 총 개수와 총 가격 계산
                  document.querySelectorAll('#cartItems tr').forEach(row => {
                    const quantityInput = row.querySelector('.quantity-input');
                    const priceElement = row.querySelector('.cart_price');
                    const totalPriceElement = row.querySelector('.cart_total_price');

                    if (quantityInput && priceElement && totalPriceElement) {
                      const quantity = parseInt(quantityInput.value) || 0;
                      const price = parseFloat(priceElement.textContent) || 0;
                      const total = quantity * price;

                      totalQuantity += quantity;
                      totalPrice += total;

                      totalPriceElement.textContent = currencyFormatter.format(total);
                    }
                  });

                  document.getElementById('total_quantity').textContent = totalQuantity;
                  document.getElementById('total_price').textContent = currencyFormatter.format(totalPrice);
                }

                updateTotals();

                window.editQuantity = function (id) {
                  const quantityInput = document.getElementById("quantity_" + id);
                  const saveButton = document.getElementById("save_" + id);
                  const editButton = document.getElementById("edit_" + id);

                  if (quantityInput && saveButton) {
                    quantityInput.disabled = false;
                    saveButton.style.display = 'inline';
                    editButton.style.display = 'none';
                  }
                };

                window.saveQuantity = function (id) {
                  const quantityInput = document.getElementById("quantity_" + id);
                  const saveButton = document.getElementById("save_" + id);
                  const editButton = document.getElementById("edit_" + id);

                  if (quantityInput && saveButton) {
                    const newQuantity = quantityInput.value;

                    $.ajax({
                      url: '/carts/modify.do',
                      type: 'POST',
                      data: {
                        carts_id: id,
                        carts_quantity: newQuantity
                      },
                      success: function (response) {
                        quantityInput.disabled = true;
                        saveButton.style.display = 'none';
                        editButton.style.display = 'inline';
                        updateTotals();
                      },
                      error: function (xhr, status, error) {
                        console.error(`Error updating quantity for ID ${id}: ${error}`);
                      }
                    });
                  }
                };
              });
            </script>

          </div>
        </div>

      </section>
    </c:if>
</body>

</html>