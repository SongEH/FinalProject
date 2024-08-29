<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>배달 완료 내역</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
        }
        .completed-order-box {
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h2>배달 완료 내역</h2>

    <c:forEach var="order" items="${completedOrders}">
        <div class="completed-order-box">
            <div><strong>주문 번호:</strong> ${order.orders_id}</div>
            <div><strong>상태:</strong> ${order.orders_status}</div>
            <div><strong>배송 수단:</strong> ${order.deliveries_method}</div>
            <div><strong>배송 완료 시간:</strong> ${order.delivery_completed_time}</div>
        </div>
    </c:forEach>

</body>
</html>
