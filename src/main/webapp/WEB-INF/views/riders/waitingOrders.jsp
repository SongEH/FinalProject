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
                <div><strong>가계 이름:</strong> ${order.shop_name}</div>
                <div><strong>가계 위치:</strong> ${order.shop_addr}</div>
                <div><strong>음식 가격:</strong> ${order.orders_price}원</div>
                <div><strong>요청 사항:</strong> ${order.orders_srequest}</div>
                <div><strong>배달 장소:</strong> ${order.addr_line1} ${order.addr_line2}</div>
                <div><strong>배달 요청:</strong> ${order.orders_drequest}</div>
            </div>
            <form action="${pageContext.request.contextPath}/riders/assign" method="post">
                <input type="hidden" name="orders_id" value="${order.orders_id}" />
                <input type="hidden" name="raiders_id" value="${raiders_id}" />
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
        // DOM이 로드된 후 폼에 이벤트 리스너 추가
        document.addEventListener("DOMContentLoaded", function() {
            const forms = document.querySelectorAll("form");  // 모든 폼 요소를 선택
    
            forms.forEach(function(form) {
                // 각 폼에 submit 이벤트 리스너 추가
                form.addEventListener("submit", function(event) {
                    event.preventDefault();  // 폼 기본 제출 동작을 막음
    
                // Fetch form data and submit using fetch
                const formData = new FormData(form);
    
                    // 서버로 POST 요청 보내기
                    fetch(form.action, {
                        method: 'POST',
                        body: formData,
                    })
                    .then(response => response.json())  // 응답을 JSON으로 변환
                    .then(data => {
                        alert(data.resultMessage);
    
                        // 배차 성공 시 진행 상황 페이지로 이동 (SPA 방식)
                        if (data.success) {
                            loadPage('/riders/progress'); // 성공 시 진행 상황 페이지 로드
                        }
                    })
                    .catch(error => {
                        console.error('에러 발생:', error);
                        alert('배차 요청 중 오류가 발생했습니다. 다시 시도해주세요.');
                    });
                });
            });
        });
    
        // SPA 방식으로 페이지 로드하는 함수
        function loadPage(url) {
            fetch(url)
                .then(response => {
                    if (!response.ok) { // 응답 상태가 OK인지 확인
                        throw new Error("네트워크 응답에 문제가 발생했습니다.");
                    }
                    return response.text(); // 텍스트 형식으로 응답 반환
                })
                .then(data => {
                    document.getElementById('content').innerHTML = data; // 컨텐츠 영역에 페이지 로드
                })
                .catch(error => {
                    console.error('페이지 로딩 중 에러:', error);
                    document.getElementById('content').innerHTML = '<p>페이지를 불러오는 중 오류가 발생했습니다.</p>';
                });
        }
    </script>
    
    
    
</body>
</html>
