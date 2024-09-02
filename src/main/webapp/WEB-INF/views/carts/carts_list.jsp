<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    function delete_carts(carts_id) {
      if (confirm("정말 삭제하시겠습니까?") == false) return;

      location.href = "delete.do?carts_id=" + carts_id;
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

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active">Layouts</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    <section class="section">
      <div class="row align-items-top">
        <div class="col-lg-10">

          <!-- Card with an image on left -->
          <!-- 장바구니 항목 테이블 -->
          <table class="table table-bordered">
            <thead>
              <tr>
                <th>가게명</th>
                <th>이미지</th>
                <th>메뉴명</th>
                <th>메뉴개수</th>
                <th>메뉴가격</th>
                <th>총 가격</th>
                <th>추가일자</th>
                <th></th>
              </tr>
            </thead>
            <tbody id="cartItems">
              <c:forEach var="vo" items="${list}">
                <tr>
                  <td id="shop_name">${vo.shop_name}</td>
                  <td id="cart_menuimg">
                    <div>
                      <img src="../resources/images/${vo.menu_img}" class="img-fluid rounded" alt="..." width="150px">
                    </div>
                  </td>
                  <td id="cart_menuname">${vo.menu_name}</td>

                  <td id="cart_quantity">
                    <input type="number" class="form-control" id="quantity_${vo.carts_id}" value="${vo.carts_quantity}"
                      min="1" max="50" disabled>
                  </td>

                  <td id="cart_price">${vo.menu_price}</td>
                  <td id="cart_total_price">
                    ${vo.menu_price * vo.carts_quantity}
                  </td>
                  <td id="cart_cdate">${vo.carts_cdate}</td>

                  <td>
                    <input class="btn btn-danger" type="button" value="삭제" onclick="delete_carts('${vo.carts_id}');">

                    <!-- Trigger edit mode on quantity input field -->
                    <input class="btn btn-info" type="button" id="edit_${vo.carts_id}" value="수정"
                      onclick="editQuantity('${vo.carts_id}');">

                    <!-- Save button is shown instead of modify button -->
                    <button class="btn btn-success" id="save_${vo.carts_id}" onclick="saveQuantity('${vo.carts_id}')"
                      style="display: none;">저장</button>
                  </td>
                </tr>

              </c:forEach>
            </tbody>

            <tfoot>
              <tr>
                <td colspan="4" class="text-right"><strong>총 개수:</strong></td>
                <td id="total_quantity">0</td>
                <td colspan="2" class="text-right"><strong>총 가격:</strong></td>
                <td id="total_price">0</td>
              </tr>
            </tfoot>
          </table>

          <script>
            // DOMContentLoaded 이벤트 안에서 자바스크립트 정의
            document.addEventListener('DOMContentLoaded', function () {

              // 통화 포맷 설정 (원화 기준으로 설정)
              const currencyFormatter = new Intl.NumberFormat('ko-KR', {
                style: 'currency',
                currency: 'KRW',
                minimumFractionDigits: 0 // 소수점 없이 정수로 표시
              });

              function updateTotals() {
                let totalQuantity = 0;
                let totalPrice = 0;

                // 각 행을 순회하며 총 개수와 총 가격 계산
                document.querySelectorAll('#cartItems tr').forEach(row => {
                  const quantity = parseInt(row.querySelector('input[type="number"]').value) || 0;
                  const price = parseFloat(row.querySelector('#cart_price').textContent) || 0;
                  const total = quantity * price;

                  totalQuantity += quantity;
                  totalPrice += total;

                  row.querySelector('#cart_total_price').textContent = currencyFormatter.format(total);
                });

                // 총 개수와 총 가격 업데이트
                document.getElementById('total_quantity').textContent = totalQuantity;
                document.getElementById('total_price').textContent = currencyFormatter.format(totalPrice);
              }

              // 페이지 로드 시 총 합계 업데이트
              updateTotals();

              // 수정 버튼 클릭 시 호출되는 함수
              window.editQuantity = function (id) {
                const quantityInput = document.getElementById("quantity_" + id);
                const saveButton = document.getElementById("save_" + id);
                const editButton = document.getElementById("edit_" + id);

                if (quantityInput && saveButton) {
                  quantityInput.disabled = false; // 수량 입력 필드 활성화
                  saveButton.style.display = 'inline'; // 저장 버튼 표시
                  editButton.style.display = 'none'; // 수정 버튼 숨김
                }
              };

              // 저장 버튼 클릭 시 호출되는 함수
              window.saveQuantity = function (id) {
                const quantityInput = document.getElementById("quantity_" + id);
                const saveButton = document.getElementById("save_" + id);
                const editButton = document.getElementById("edit_" + id);

                if (quantityInput && saveButton) {
                  const newQuantity = quantityInput.value;

                  $.ajax({
                    url: '/carts/modify.do', // 서버에서 수량을 처리할 URL
                    type: 'POST',
                    data: {
                      carts_id: id,
                      carts_quantity: newQuantity
                    },
                    success: function (response) {
                      quantityInput.disabled = true; // 수량 입력 필드 비활성화
                      saveButton.style.display = 'none'; // 저장 버튼 숨김
                      editButton.style.display = 'inline'; // 수정 버튼 표시
                      updateTotals(); // 총 개수와 총 가격 업데이트
                    },

                    error: function (xhr, status, error) {
                      console.error(`Error updating quantity for ID ${id}: ${error}`);
                    }
                  }); // end ajax

                }
              };
            });
          </script>

        </div>
      </div>

    </section>
</body>

</html>