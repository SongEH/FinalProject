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
      <h1>쿠폰이 성공적으로 발행되었습니다.</h1>
      <a href="/coupon/issue.do">다시 발행하기</a>
    </main>
  </body>
</html>
