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
          <th>가게 이름</th>
          <th>주문 금액</th>
          <th>주문 날짜</th>
          <th>배달 주소</th>
          <th>수수료</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${completedDeliveries}">
          <tr>
            <td>${vo.shop_name}</td>
            <td>${vo.orders_price} 원</td>
            <td>${vo.orders_cdate}</td>
            <td>${vo.addr_line1}, ${vo.addr_line2}</td>
            <td>${vo.commission} 원</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <h3>총 수입: ${totalCommission} 원</h3>
  </body>
</html>
