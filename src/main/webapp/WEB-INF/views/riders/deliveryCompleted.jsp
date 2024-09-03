<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <div><strong>상태:</strong> ${order.orders_status}</div>
            <div><strong>배송 수단:</strong> ${order.deliveries_method}</div>
            <div><strong>배송 완료 시간:</strong> ${order.orders_cdate}</div> <!-- 배송 완료 시간을 orders_cdate로 가정 -->
        </div>
    </c:forEach>

</body>
</html>
