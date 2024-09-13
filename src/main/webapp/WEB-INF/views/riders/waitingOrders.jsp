<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="delivery.jsp" />
<!DOCTYPE html>
<html>
  <head>
    <title>배차 대기 중인 주문</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
  </head>
  <body>
    <div class="container">
    <div class="content-wrapper">
    <div id="content">
    <h2>배차 대기 중인 주문</h2>

    <!-- 메시지를 표시할 영역 -->
    <div id="result-message" class="alert" style="display: none"></div>

    <c:forEach var="order" items="${orders}">
      <div class="order-box">
        <div class="order-info">
          <div><strong>주문 번호:</strong> ${order.orders_id}</div>
          <div><strong>가계 이름:</strong> ${order.shop_name}</div>
          <div><strong>가계 위치:</strong> ${order.shop_addr}</div>
          <div><strong>음식 가격:</strong> ${order.orders_price}원</div>
          <div><strong>요청 사항:</strong> ${order.orders_srequest}</div>
          <div>
            <strong>배달 장소:</strong> ${order.addr_line1} ${order.addr_line2}
          </div>
          <div><strong>배달 요청:</strong> ${order.orders_drequest}</div>
        </div>
        <form
          action="${pageContext.request.contextPath}/riders/assign"
          method="post"
        >
          <input type="hidden" name="orders_id" value="${order.orders_id}" />
          <input type="hidden" name="raiders_id" value="${raiders_id}" />
          <label for="method-${order.orders_id}">배송 수단:</label>
          <select
            id="method-${order.orders_id}"
            name="deliveries_method"
            required
          >
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
      var socket = new SockJS('${pageContext.request.contextPath}/ws-orders');
      var stompClient = Stomp.over(socket);
  
      // WebSocket 연결 설정
      stompClient.connect({}, function (frame) {
          // 주문 상태 업데이트 메시지 구독
          stompClient.subscribe('/topic/orders', function (message) {
              // 서버에서 메시지가 올 때마다 DOM 업데이트
              location.reload(); // 페이지를 새로고침하여 새로운 데이터를 반영
          });
      });
    </script>
  </div>
  </div>
  </div>
  </body>
</html>
