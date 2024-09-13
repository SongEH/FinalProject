<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="delivery.jsp" />
<!DOCTYPE html>
<html>
  <head>
    <title>진행 중인 주문</title>
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
              <div><strong>가계 주소:</strong> ${order.shop_addr}</div>
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
