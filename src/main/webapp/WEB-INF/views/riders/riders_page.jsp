<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>마이페이지 여긴 riders_page</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />" />
    <script src="<c:url value='/js/scripts.js' />"></script>
    <style>
      /* 사이드바 스타일 */
      .sidebar {
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        height: 100%;
        background-color: #f4f4f4;
        padding: 15px;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
      }

      .sidebar a {
        display: block;
        padding: 10px;
        color: #333;
        text-decoration: none;
      }

      .sidebar a:hover {
        background-color: #ddd;
      }

      .content {
        margin-left: 270px;
        padding: 15px;
      }

      /* 각 섹션의 기본 숨김 */
      .section {
        display: none;
      }

      .section.active {
        display: block;
      }
    </style>
  </head>
  <body>
    
    <div class="content">
      <!-- 회원정보 섹션 -->
      <div id="profileSection" class="section">
        <h2>회원 정보</h2>
        <form action="/member_modify_form.do" method="post">
          <label for="member_name">이름:</label>
          <input
            type="text"
            id="member_name"
            name="member_name"
            value="${member_name}"
            required
          /><br />

          <label for="member_nickname">닉네임:</label>
          <input
            type="text"
            id="member_nickname"
            name="member_nickname"
            value="${member_nickname}"
            required
          /><br />

          <label for="member_pwd">비밀번호:</label>
          <input
            type="password"
            id="member_pwd"
            name="member_pwd"
            value="${member_pwd}"
            required
          /><br />

          <button type="submit">회원 정보 수정</button>
        </form>
      </div>

      <!-- 결제정보 섹션 -->
      <div id="paymentsSection" class="section">
        <h2>결제 정보</h2>
        <table>
          <thead>
            <tr>
              <th>결제 ID</th>
              <th>주문 ID</th>
              <th>금액</th>
              <th>결제 방법</th>
              <th>결제 상태</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="payment" items="${payments}">
              <tr>
                <td>${payment.id}</td>
                <td>${payment.orderId}</td>
                <td>${payment.amount}</td>
                <td>${payment.paymentMethod}</td>
                <td>${payment.paymentStatus}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <!-- 주소정보 섹션 -->
      <div id="addressesSection" class="section">
        <h2>주소 등록</h2>
        <form action="addAddress.do" method="post">
          <input type="hidden" name="memberId" value="${user.id}" />
          <label for="addressLine1">주소 1:</label>
          <input
            type="text"
            id="addressLine1"
            name="addressLine1"
            required
          /><br />

          <label for="addressLine2">주소 2:</label>
          <input type="text" id="addressLine2" name="addressLine2" /><br />

          <label for="city">시/도:</label>
          <input type="text" id="city" name="city" required /><br />

          <label for="state">구/군:</label>
          <input type="text" id="state" name="state" required /><br />

          <label for="postalCode">우편번호:</label>
          <input type="text" id="postalCode" name="postalCode" required /><br />

          <label for="country">국가:</label>
          <input type="text" id="country" name="country" required /><br />

          <button type="submit">주소 등록</button>
        </form>

        <h3>등록된 주소 목록</h3>
        <table>
          <thead>
            <tr>
              <th>주소 1</th>
              <th>주소 2</th>
              <th>시/도</th>
              <th>구/군</th>
              <th>우편번호</th>
              <th>국가</th>
              <th>삭제</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="address" items="${addresses}">
              <tr>
                <td>${address.addressLine1}</td>
                <td>${address.addressLine2}</td>
                <td>${address.city}</td>
                <td>${address.state}</td>
                <td>${address.postalCode}</td>
                <td>${address.country}</td>
                <td><a href="deleteAddress.do?id=${address.id}">삭제</a></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <!-- 주문내역 섹션 -->
      <div id="ordersSection" class="section">
        <h2>주문 내역</h2>
        <table>
          <thead>
            <tr>
              <th>주문 ID</th>
              <th>주문 날짜</th>
              <th>상태</th>
              <th>총 금액</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="order" items="${orders}">
              <tr>
                <td>${order.id}</td>
                <td>${order.orderDate}</td>
                <td>${order.status}</td>
                <td>${order.totalAmount}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <!-- 장바구니 섹션 -->
      <div id="cartSection" class="section">
        <h2>장바구니</h2>
        <table>
          <thead>
            <tr>
              <th>상품 ID</th>
              <th>상품명</th>
              <th>수량</th>
              <th>가격</th>
              <th>총 금액</th>
              <th>삭제</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="item" items="${cartItems}">
              <tr>
                <td>${item.productId}</td>
                <td>${item.productName}</td>
                <td>${item.quantity}</td>
                <td>${item.price}</td>
                <td>${item.totalPrice}</td>
                <td>
                  <a href="removeFromCart.do?productId=${item.productId}"
                    >삭제</a
                  >
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

    <script>
      // 섹션 표시 함수
      function showSection(sectionId) {
        var sections = document.getElementsByClassName("section");
        for (var i = 0; i < sections.length; i++) {
          sections[i].style.display = "none"; // 모든 섹션 숨기기
        }
        var section = document.getElementById(sectionId);
        if (section) {
          section.style.display = "block"; // 선택된 섹션만 표시
        }
      }

      // 페이지 로딩 시 기본 섹션 표시 (여기서는 회원정보를 기본으로 설정)
      window.onload = function () {
        showSection("profileSection");
      };
    </script>
  </body>
</html>