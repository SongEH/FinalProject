<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>배차 대기 중인 주문</title>
</head>
<body>
    <h2>배차 대기 중인 주문</h2>

    <div id="result-message" class="alert alert-info" style="display:none;"></div>

    <c:forEach var="order" items="${orders}">
        <div class="order-box">
            <div class="order-info">
                <div><strong>주문 번호:</strong> ${order.orders_id}</div>
                <div><strong>식당:</strong> ${order.shop_name}</div>
                <div><strong>가격:</strong> ${order.orders_price}원</div>
                <div><strong>요청사항:</strong> ${order.orders_srequest}</div>
            </div>
            <form id="assignForm-${order.orders_id}" onsubmit="assignOrder(${order.orders_id}, ${raiders_id}); return false;">
                <label for="method-${order.orders_id}">배송 수단:</label>
                <select id="method-${order.orders_id}" name="deliveries_method" required>
                    <option value="오토바이">오토바이</option>
                    <option value="자동차">자동차</option>
                    <option value="자전거">자전거</option>
                    <option value="도보">도보</option>
                </select>
                <button type="submit" class="assign-button">배차 받기</button>
            </form>
        </div>
    </c:forEach>

    <script>
        function assignOrder(orderId, raiderId) {
            const method = document.getElementById(`method-${orderId}`).value;
            fetch('${pageContext.request.contextPath}/riders/assign', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'orders_id': orderId,
                    'raiders_id': raiderId,
                    'deliveries_method': method
                })
            })
            .then(response => response.json())
            .then(data => {
                const resultMessageDiv = document.getElementById('result-message');
                resultMessageDiv.textContent = data.resultMessage;
                resultMessageDiv.style.display = 'block';
                if (data.success) {
                    loadPage('${pageContext.request.contextPath}/riders/progress');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }

        function loadPage(url) {
            fetch(url)
                .then(response => response.text())
                .then(data => {
                    document.getElementById('content').innerHTML = data;
                });
        }
    </script>
</body>
</html>
