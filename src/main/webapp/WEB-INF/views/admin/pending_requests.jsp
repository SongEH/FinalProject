<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>승인 요청 사장 목록</title>
  </head>
  <body>
    <h1>승인 요청 사장 목록</h1>
    <table border="1">
      <thead>
        <tr>
          <th>사장 ID</th>
          <th>사장 이름</th>
          <th>사장 계정 ID</th>
          <th>이메일</th>
          <th>전화번호</th>
          <th>사업자등록번호</th>
          <th>승인 상태</th>
          <th>승인</th>
          <th>거절</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="request" items="${requests}">
          <tr>
            <td>${request.owner_id}</td>
            <td>${request.owner_name}</td>
            <td>${request.owner_accountId}</td>
            <td>${request.owner_email}</td>
            <td>${request.owner_phone}</td>
            <td>${request.owner_license}</td>
            <td>${request.approval_status}</td>
            <td>
              <a
                href="${pageContext.request.contextPath}/admin/approve_request.do?owner_id=${request.owner_id}"
                >승인</a
              >
            </td>
            <td>
              <a
                href="${pageContext.request.contextPath}/admin/reject_request.do?owner_id=${request.owner_id}"
                >거절</a
              >
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </body>
</html>
