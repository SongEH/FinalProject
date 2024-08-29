<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>배차 대기 중인 주문</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FFC6C6;
            color: #333;
        }
        .order-box {
            padding: 15px;
            margin: 10px 0;
            background-color: #FFEBD4;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .order-info {
            margin-bottom: 10px;
        }
        .order-info div {
            margin-bottom: 5px;
        }
        .assign-button {
            display: inline-block;
            padding: 10px 15px;
            background-color: #F0A8D0;
            color: black;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .assign-button:hover {
            background-color: #0056b3;
        }
        select{
            background-color: #FFC6C6;
        }
    </style>
</head>
<body>
    <h2>배차 대기 중인 주문</h2>

    <c:forEach var="order" items="${orders}">
        <div class="order-box">
            <div class="order-info">
                <div><strong>주문 번호:</strong> ${order.orders_id}</div>
                <div><strong>식당:</strong> ${order.shop_name}</div>
                <div><strong>가격:</strong> ${order.orders_price}원</div>
                <div><strong>요청사항:</strong> ${order.orders_srequest}</div>
            </div>
            <form action="${pageContext.request.contextPath}/riders/assign" method="post">
                <input type="hidden" name="orders_id" value="${order.orders_id}" />
                <input type="hidden" name="riders_id" value="${riders_id}" />
                <label for="method-${order.orders_id}">배송 수단:</label>
                <select id="method-${order.orders_id}" name="method" required>
                    <option value="오토바이" ${order.deliveries_method == '오토바이' ? 'selected' : ''}>오토바이</option>
                    <option value="자동차" ${order.deliveries_method == '자동차' ? 'selected' : ''}>자동차</option>
                    <option value="자전거" ${order.deliveries_method == '자전거' ? 'selected' : ''}>자전거</option>
                    <option value="도보" ${order.deliveries_method == '도보' ? 'selected' : ''}>도보</option>
                </select>
                <button type="submit" class="assign-button">배차 받기</button>
            </form>
            
            </form>
        </div>
    </c:forEach>

</body>
</html>
