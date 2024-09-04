<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>진행 중인 주문</title>
</head>
<body>
    <h2>진행 중인 주문</h2>

    <c:choose>
        <c:when test="${empty orders}">
            <p>${message}</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="order" items="${orders}">
                <div class="order-progress-box">
                    <div><strong>주문 번호:</strong> ${order.orders_id}</div>
                    <div><strong>상태:</strong> ${order.orders_status}</div>
                    <div><strong>배송 수단:</strong> ${order.deliveries_method}</div>
                    <button onclick="window.open('${pageContext.request.contextPath}/riders/route?orders_id=${order.orders_id}', '경로보기', 'width=800,height=600');">경로 보기</button>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</body>
</html>
