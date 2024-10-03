<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <%@include file="../common.jsp" %> <%@include file="../header.jsp" %>
    <%@include file="../sidebar.jsp" %>
    <main id="main" class="main">
      <h1>${member.member_name}님의 보유쿠폰</h1>

      <table>
        <tr>
          <th>쿠폰코드</th>
          <th>할인금액</th>
          <th>발급일</th>
          <th>만료일</th>
        </tr>
        <c:forEach var="coupon" items="${member.coupons}">
          <tr>
            <td>${coupon.coupon_code}</td>
            <td>${coupon.discount_amount}원</td>
            <td>${coupon.start_date}</td>
            <td>${coupon.end_date}</td>
          </tr>
        </c:forEach>
      </table>
    </main>
  </body>
</html>
