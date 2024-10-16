<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="delivery.jsp" />
<!DOCTYPE html>
<html>
  <head>
    <title>진행 중인 주문</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <script>
      var sessionId = '<%= session.getId() %>'; // 현재 세션 ID
      var raiders_id = '<%= session.getAttribute("raiders_id") %>';
    
      var socket = new SockJS('${pageContext.request.contextPath}/ws-orders');
      var stompClient = Stomp.over(socket);
    
      // WebSocket 연결 설정
      stompClient.connect({}, function (frame) {
          // 주문 상태 업데이트 메시지 구독
          stompClient.subscribe('/topic/orders', function (message) {
              var receivedMessage = JSON.parse(message.body); // JSON 형식으로 메시지 파싱
              // 자신의 배달이 아닌 것과 자신이 보낸 메시지는 무시
              if (receivedMessage.orders_status === '주문 정보가 업데이트되었습니다.') {
                  // 알림 메시지
                  alert("배달 하실 주문 정보가 업데이트되었습니다. : 주문 번호 - " + receivedMessage.orders_id);
                  location.reload();
              } else{
                  location.reload();
              }
          });
      });
    </script>
  </head>
  <body>
    <div class="container">
    <div class="content-wrapper">
    <div id="content">
    <h2>진행 중인 주문</h2>
    <c:choose>
      <c:when test="${empty orders}">
        <p>${message}</p>
      </c:when>
      <c:otherwise>
        <c:forEach var="order" items="${orders}">
          <div class="order-progress-box">
            <div class="order-progress-info">
              <div><strong>주문 번호:</strong> ${order.orders_id}</div>
              <div><strong>주문 상태:</strong> ${order.orders_status}</div>
              <div><strong>배달 상태:</strong> ${order.delivery_history_status}</div>
              <div><strong>가계 이름:</strong> ${order.shop_name}</div>
              <div><strong>가계 주소:</strong> ${order.shop_addr1} ${order.shop_addr2}</div>
              <div><strong>회원 이름:</strong> ${order.member_nickname}</div>
              <div>
                <strong>배달 장소:</strong> ${order.addr_line1}
                ${order.addr_line2}
              </div>
              <div><strong>배달 요청:</strong> ${order.orders_drequest}</div>
              <div><strong>배송 수단:</strong> ${order.deliveries_method}</div>
            </div>

            <button
               onclick="window.open('${pageContext.request.contextPath}/riders/route?orders_id=${order.orders_id}', '경로보기', 'width=800,height=600');"
               class="route-button"
            >
              경로 보기
            </button>

              <!-- orders_status가 '픽업 대기'일 때만 "픽업 하기" 버튼 표시 -->
              <c:if test="${order.orders_status == '픽업 대기'}">
                <form
                  action="${pageContext.request.contextPath}/riders/pickup"
                  method="post"
                >
                  <input
                    type="hidden"
                    name="orders_id"
                    value="${order.orders_id}"
                  />
                  <input
                    type="hidden"
                    name="raiders_id"
                    value="<%= session.getAttribute("raiders_id") %>"
                  />
                  <button type="submit" class="assign-button">픽업 하기</button>
                </form>
              </c:if>

            <!-- delivery_history_status가 '배달 예상 시간 입력 중'일때 select 표시-->
            <c:if test="${order.delivery_history_status == '배달 예상 시간 입력 중'}">
              <form
                action="${pageContext.request.contextPath}/riders/setDeliveryTime"
                method="post"
              >
                <input type="hidden" name="orders_id" value="${order.orders_id}"/>
                <select name="delivery_time">
                  <option value="5">5분</option>
                  <option value="10">10분</option>
                  <option value="15">15분</option>
                  <option value="20">20분</option>
                  <option value="25">25분</option>
                  <option value="30">30분</option>
                  <option value="35">35분</option>
                  <option value="40">40분</option>
                  <option value="45">45분</option>
                  <option value="50">50분</option>
                  <option value="55">55분</option>
                  <option value="60">60분</option>
                </select>
                <button type="submit" class="delivery-time-button">배달 예상 시간<br>입력</button>
              </form>
            </c:if>              

              <!-- orders_status가 '배달 중'일 때만 "배달 완료" 버튼 표시 -->
              <c:if test="${order.orders_status == '배달 중'}">
                <form
                  action="${pageContext.request.contextPath}/riders/completeDelivery"
                  method="post"
                >
                  <input
                    type="hidden"
                    name="orders_id"
                    value="${order.orders_id}"
                  />
                  <input
                    type="hidden"
                    name="raiders_id"
                    value="<%= session.getAttribute("raiders_id") %>"
                  />
                  <button type="submit" class="assign-button">배달 완료</button>
                </form>
              </c:if>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>
  </div>
  </div>
  </body>
</html>
