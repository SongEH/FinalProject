<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Owner List</title>
  </head>
  <body>
    <h1>Owner List</h1>
    <table border="1">
      <tr>
        <th>INDEX</th>
        <th>Name</th>
        <th>ID</th>
        <th>Email</th>
        <th>Phone</th>
        <th>License</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
      <c:forEach var="owner" items="${owner_list}">
        <tr>
          <td>${owner.owner_id}</td>
          <td>${owner.owner_name}</td>
          <td>${owner.owner_accountId }</td>
          <td>${owner.owner_email}</td>
          <td>${owner.owner_phone}</td>
          <td>${owner.owner_license}</td>
          <td>${owner.approval_status}</td>
          <td>
            <a href="delete_owner.do?owner_id=${owner.owner_id}">Delete</a>
          </td>
        </tr>
      </c:forEach>
    </table>
  </body>
</html>
