<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>배차 대기 중인 주문</title>
</head>
<body>
    <h2>배차 대기 중인 주문</h2>

    <!-- 메시지를 표시할 영역 -->
    <div id="result-message" class="alert" style="display:none;"></div>

    <c:forEach var="order" items="${orders}">
        <div class="order-box">
            <div class="order-info">
                <div><strong>주문 번호:</strong> ${order.orders_id}</div>
                <div><strong>식당:</strong> ${order.shop_name}</div>
                <div><strong>가격:</strong> ${order.orders_price}원</div>
                <div><strong>요청사항:</strong> ${order.orders_srequest}</div>
            </div>
            <form action="${pageContext.request.contextPath}/riders/assign" method="post" onsubmit="return assignOrder(${order.orders_id}, ${raiders_id}, this);">
                <input type="hidden" name="orders_id" value="${order.orders_id}" />
                <input type="hidden" name="raiders_id" value="${raiders_id}" />
                <label for="method-${order.orders_id}">배송 수단:</label>
                <select id="method-${order.orders_id}" name="deliveries_method" required>
                    <option value="오토바이" ${order.deliveries_method == '오토바이' ? 'selected' : ''}>오토바이</option>
                    <option value="자동차" ${order.deliveries_method == '자동차' ? 'selected' : ''}>자동차</option>
                    <option value="자전거" ${order.deliveries_method == '자전거' ? 'selected' : ''}>자전거</option>
                    <option value="도보" ${order.deliveries_method == '도보' ? 'selected' : ''}>도보</option>
                </select>
                <button type="submit" class="assign-button">배차 받기</button>
            </form>
        </div>
    </c:forEach>

    <script>
        function assignOrder(orders_id, raiders_id, form) {
            const method = document.getElementById(`method-${orders_id}`).value;
            fetch(form.action, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams(new FormData(form))
            })
            .then(response => response.json())
            .then(data => {
                // 메시지 표시 영역을 업데이트
                const messageDiv = document.getElementById('result-message');
                messageDiv.innerText = data.resultMessage;
                messageDiv.classList.remove('alert-success', 'alert-danger');
                
                if (data.success) {
                    messageDiv.classList.add('alert-success');
                    if (data.redirectUrl) {
                        window.location.href = data.redirectUrl; // 리다이렉트
                    }
                } else {
                    messageDiv.classList.add('alert-danger');
                }

                messageDiv.style.display = 'block'; // 메시지 표시
            })
            .catch(error => {
                console.error('Error:', error);
                alert('배차 요청 중 오류가 발생했습니다. 다시 시도해주세요.');
            });

            return false; // 폼이 실제로 제출되지 않도록 함
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