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
    <h1>완료된 배달 정보</h1>

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

    <h3>총 수입: ${totalCommission} 원</h3>

    <!-- 페이징 -->
    <div style="text-align: center; margin-top: 20px; font-size: 15px">
      ${pageMenu}
    </div>

    <script>
      // 페이지 이동 시 동작하는 함수
      $(document).on("click", ".page-link", function (e) {
        e.preventDefault();
        var page = $(this).data("page");

        // 현재 페이지를 hidden 필드에 설정하여 폼 데이터로 전송
        $("#currentPage").val(page);

        // 폼 데이터를 전송하여 다시 페이지를 렌더링
        $("#filter-btn").click(); // 필터링 버튼을 강제로 트리거
      });
    </script>
  </body>
</html>
