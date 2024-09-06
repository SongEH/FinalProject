<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <title>배달 완료 내역</title>
  </head>
  <body>
    <h2>배달 완료 내역</h2>

    <c:forEach var="order" items="${completedOrders}">
      <div class="completed-order-box">
        <div><strong>주문 번호:</strong> ${order.orders_id}</div>
        <div><strong>배달 상태:</strong> ${order.orders_status}</div>
        <div><strong>가계 이름:</strong> ${order.shop_name}</div>
        <div><strong>가계 주소:</strong> ${order.shop_addr}</div>
        <div><strong>배송 수단:</strong> ${order.deliveries_method}</div>
        <div><strong>배송 날짜:</strong> 
          <fmt:formatDate value="${order.orders_cdate}" pattern="yyyy년 MM월 dd일 EEEE" />
        </div>
      </div>
    </c:forEach>
  </body>
</html>
