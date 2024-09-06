<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
contentType="text/html;charset=UTF-8" language="java" %>
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
            <div><strong>가계 이름:</strong> ${order.shop_name}</div>
            <div><strong>가계 주소:</strong> ${order.shop_addr}</div>
            <div><strong>회원 이름:</strong> ${order.member_nickname}</div>
            <!-- <div><strong>회원 이름:</strong> ${order.member_nickname}</div> -->
            <div>
              <strong>배달 장소:</strong> ${order.addr_line1}
              ${order.addr_line2}
            </div>
            <div><strong>배달 요청:</strong> ${order.orders_drequest}</div>
            <div><strong>배송 수단:</strong> ${order.deliveries_method}</div>
            <button
              onclick="window.open('${pageContext.request.contextPath}/riders/route?orders_id=${order.orders_id}', '경로보기', 'width=800,height=600');"
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
                <button type="submit">픽업 하기</button>
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
                <button type="submit">배달 완료</button>
              </form>
            </c:if>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </body>
</html>
