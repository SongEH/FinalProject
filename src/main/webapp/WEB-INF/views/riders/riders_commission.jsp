<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
  <head>
    <title>완료된 배달 목록</title>
  </head>
  <link
    rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
  />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <body>
    <!-- 완료된 배달 정보 테이블 -->
    <table border="1" id="delivery-table">
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

    <!-- 총 수수료 -->
    <h3>총 수입: ${totalCommission} 원</h3>

    <!-- 페이징 처리 -->
    <div style="text-align: center; margin-top: 20px; font-size: 15px">
      ${pageMenu}
    </div>

    <!-- 필터링된 페이지에서도 현재 날짜와 필터를 유지하기 위한 hidden 필드 -->
    <input type="hidden" name="startDate" value="${param.startDate}" />
    <input type="hidden" name="endDate" value="${param.endDate}" />
  </body>
</html>
