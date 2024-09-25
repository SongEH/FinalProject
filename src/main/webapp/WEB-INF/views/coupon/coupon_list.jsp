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
    <%@include file="../common.jsp" %>

    <!-- header import -->
    <%@include file="../header.jsp" %>

    <!-- side bar import -->
    <%@include file="../sidebar.jsp" %>
    <main id="main" class="main">
      <h1>Issued Coupon List</h1>
      <c:if test="${not empty coupons}">
        <table border="1">
          <thead>
            <tr>
              <th>회원명</th>
              <th>쿠폰 번호</th>
              <th>할인 금액</th>
              <th>발행날짜</th>
              <th>사용여부</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="coupon" items="${coupons}">
              <tr>
                <td>${coupon.member_name}</td>
                <td>${coupon.coupon_code}</td>
                <td>${coupon.discount_amount}</td>
                <td>${coupon.start_date}</td>
                <td>
                  <c:choose>
                    <c:when test="${coupon.used_date != null}">
                      ${coupon.used_date}
                    </c:when>
                    <c:otherwise>Unused</c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:if>
      <c:if test="${empty coupons}">
        <p>발행된 쿠폰이 없습니다.</p>
      </c:if>
    </main>
  </body>
</html>
