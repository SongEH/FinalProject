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
      <h1>쿠폰 발행하기</h1>
      <input
        class="button_style"
        type="button"
        id="btn_popup_update"
        value="3천원권 발행"
        onclick="location.href ='issue3000.do'"
      />

      <input
        class="button_style"
        type="button"
        id="btn_popup_update"
        value="5천원권 발행"
        onclick="location.href ='issue5000.do'"
      />
    </main>
  </body>
</html>
