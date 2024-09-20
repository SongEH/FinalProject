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
      여긴 쿠폰
      <button onclick="location.href ='issue.do'">쿠폰발행</button>
    </main>
  </body>
</html>
