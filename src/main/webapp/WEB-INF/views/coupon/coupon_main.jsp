<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Coupon Main</title>
  </head>
  <body>
    <%@include file="../common.jsp" %> <%@include file="../header.jsp" %>
    <%@include file="../sidebar.jsp" %>

    <main id="main" class="main">
      <h1>Coupon Issuance</h1>
      <button onclick="location.href ='issue.do'">Issue Coupons</button>
    </main>
  </body>
</html>
