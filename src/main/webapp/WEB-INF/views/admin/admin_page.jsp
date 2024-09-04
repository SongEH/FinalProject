<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>관리자 페이지</title>
  </head>
  <body>
    <ul>
      <li>
        <a href="${pageContext.request.contextPath}/admin/member_list.do"
          >회원 목록</a
        >
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/owner_list.do"
          >사장 목록</a
        >
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/pending_requests.do"
          >승인 요청 목록</a
        >
      </li>
    </ul>
  </body>
</html>
