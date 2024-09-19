<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Addr List</title>
    <script type="text/javascript">

      function del(addr_id){
          
        if(confirm("정말 삭제 하시겠습니까?")==false) return;
        
        location.href = "addr_delete.do?addr_id=" + addr_id;   
        
      }

    </script>
  </head>
  <body>
    <h1>Addr List</h1>
    <!-- <input type="hidden" name="addr_id" id="${addr.addr_id}" /> -->

    <input
      type="button"
      value="주소 등록"
      onclick="location.href='/addr/addr_insert_form.do?nextPath=addr_list'"
    />

    <table border="1">
      <tr>
        <td>Index</td>
        <td>Zipcode</td>
        <td>Addr Line1</td>
        <td>Addr Line2</td>
        <td>Addr Name</td>
        <td>수정</td>
        <td>삭제</td>
      </tr>
      <c:forEach var="addr" items="${addr_list}">
        <tr>
          <td>${addr.addr_id}</td>
          <td>${addr.addr_zipcode}</td>
          <td>${addr.addr_line1}</td>
          <td>${addr.addr_line2}</td>
          <td>${addr.addr_name}</td>
          <td>
            <input type="button" class="btn btn-success" value="수정" onclick="location.href='addr_modify_form.do?addr_id=${addr.addr_id}'">
          </td>
          <td>
            <input type="button" class="btn btn-success" value="삭제" onclick="del('${addr.addr_id}')">
          </td>
        </tr>
      </c:forEach>
    </table>
    <!-- Data가 없는경우  -->
	     <c:if test="${ empty requestScope.addr_list }">
	        <div id="empty_msg">등록된 회원정보가 없습니다</div>
	     </c:if>
  </body>
</html>
