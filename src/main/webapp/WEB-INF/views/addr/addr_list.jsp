<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>  
    <title>Addr List</title>
    <script type="text/javascript">

      function del(addr_id){
          
        if(confirm("정말 삭제 하시겠습니까?")==false) return;
        
        location.href = "addr_delete.do?addr_id=" + addr_id;   
        
      }

    </script>
    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0px;
      }

      .container {
        max-width: 800px;
        margin: auto;
        background: white;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }

      h1 {
        text-align: center;
        color: #333;
      }

      input[type="button"] {
        background-color: #5cb85c;
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        border-radius: 5px;
        transition: background-color 0.3s;
      }

      input[type="button"]:hover {
        background-color: #4cae4c;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }

      table, th, td {
        border: 1px solid #ddd;
      }

      th, td {
        padding: 12px;
        text-align: left;
      }

      th {
        background-color: #f2f2f2;
      }

      tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      tr:hover {
        background-color: #f1f1f1;
      }

      #empty_msg {
        text-align: center;
        color: #888;
        margin-top: 20px;
      }
    </style>
  </head>
  <body>
    <%@include file="../common.jsp" %>

    <%@include file="../header.jsp" %>

    <%@include file="../sidebar.jsp" %>

    <main id="main" class="main">
      <div class="pagetitle">

        <h1>주소 정보</h1>

        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">Forms</li>
            <li class="breadcrumb-item active">Layouts</li>
          </ol>
        </nav>

      </div><!-- End Page Title -->

      
      <!-- <input type="hidden" name="addr_id" id="${addr.addr_id}" /> -->
      <div class="container">
        <input
        type="button"
        value="주소 등록"
        onclick="location.href='/addr/addr_insert_form.do?nextPath=addr_list'"
        />

        <table border="1">
          <tr>
            <td>우편번호</td>
            <td>기본주소</td>
            <td>상세주소</td>
            <td>별칭</td>
            <td>수정</td>
            <td>삭제</td>
          </tr>
          <c:forEach var="addr" items="${addr_list}">
            <tr>
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
      </div>
    </main><!-- End #main -->
  
  </body>
</html>
