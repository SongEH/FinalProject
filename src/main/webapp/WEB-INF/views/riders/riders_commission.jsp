<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>완료된 배달 목록</title>
  </head>
  <body>
    <h1>완료된 배달 정보</h1>

    <table border="1">
      <thead>
        <tr>
          <th>배달 ID</th>
          <th>라이더 이름</th>
          <th>주문 ID</th>
          <th>주문 금액</th>
          <th>배달 상태</th>
          <th>주문 날짜</th>
          <th>가게 이름</th>
          <th>배달 주소</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${completedDeliveries}">
          <tr>
            <td>${vo.deliveries_id}</td>
            <td>${vo.rider_name}</td>
            <td>${vo.orders_id}</td>
            <td>${vo.orders_price}</td>
            <td>${vo.delivery_history_status}</td>
            <td>${vo.orders_cdate}</td>
            <td>${vo.shop_name}</td>
            <td>${vo.addr_line1}, ${vo.addr_line2}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </body>
</html>
