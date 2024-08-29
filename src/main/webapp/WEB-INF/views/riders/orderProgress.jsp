<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>진행 중인 주문</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
        }
        .order-progress-box {
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h2>진행 중인 주문</h2>

    <c:forEach var="order" items="${orders}">
        <div class="order-progress-box">
            <div><strong>주문 번호:</strong> ${order.orders_id}</div>
            <div><strong>상태:</strong> ${order.orders_status}</div>
            <div><strong>배송 수단:</strong> ${order.deliveries_method}</div>
            <div><strong>남은 시간:</strong> ${order.remaining_time}</div>
            <button onclick="window.open('${pageContext.request.contextPath}/riders/route?orderId=${order.orders_id}', '경로보기', 'width=800,height=600');">경로 보기</button>
        </div>
    </c:forEach>

</body>
</html>
