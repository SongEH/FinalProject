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
              <th>Member Name</th>
              <th>Coupon Code</th>
              <th>Discount Amount</th>
              <th>Issued Date</th>
              <th>Used Date</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="coupon" items="${coupons}">
              <tr>
                <td>${coupon.member_name}</td>
                <td>${coupon.coupon_code}</td>
                <td>${coupon.discount_amount}</td>
                <td>${coupon.issued_date}</td>
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
        <p>No coupons issued yet.</p>
      </c:if>
    </main>
  </body>
</html>
