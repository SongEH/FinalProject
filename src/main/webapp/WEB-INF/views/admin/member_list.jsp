<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Member List</title>
  </head>
  <body>
    <h1>Member List</h1>
    <table border="1">
      <tr>
        <th>INDEX</th>
        <th>Name</th>
        <th>NickName</th>
        <th>ID</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Actions</th>
      </tr>
      <c:forEach var="member" items="${member_list}">
        <tr>
          <td>${member.member_id}</td>
          <td>${member.member_name}</td>
          <td>${member.member_nickname}</td>
          <td>${member.member_accountId }</td>
          <td>${member.member_email}</td>
          <td>${member.member_phone}</td>
          <td>
            <a href="delete_member.do?member_id=${member.member_id}">Delete</a>
          </td>
        </tr>
      </c:forEach>
    </table>
  </body>
</html>
