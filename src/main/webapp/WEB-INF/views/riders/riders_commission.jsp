<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>완료된 배달 목록</title>

    <!-- Bootstrap 3.x -->
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
      body {
        background-color: #f8f9fa;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }

      .container {
        max-width: 800px;
        margin: 50px auto;
        background-color: #fff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      .header h2 {
        text-align: center;
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 30px;
      }

      .form-inline {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
      }

      .form-group {
        margin-bottom: 15px;
      }

      .form-control {
        border-radius: 5px;
        height: 45px;
        width: 200px;
      }

      .button_style {
        background-color: #f0a8d0;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        transition: background-color 0.3s ease;
      }

      .button_style:hover {
        background-color: #e090b5;
      }

      .table {
        margin-top: 20px;
      }

      h3 {
        margin-top: 20px;
        text-align: center;
      }

      .pagination {
        text-align: center;
        margin-top: 20px;
      }

      /* Center pagination */
      .pagination {
        display: flex;
        justify-content: center;
      }

      /* Responsive Styles */
      @media (max-width: 768px) {
        .form-inline {
          flex-direction: column;
        }

        .form-group {
          margin-bottom: 10px;
        }

        .button_style {
          width: 100%;
          margin-bottom: 10px;
        }

        .form-control {
          width: 100%;
        }
      }
    </style>
  </head>

  <body>
    <div class="container">
      <div class="header">
        <h2>완료된 배달 목록</h2>
      </div>

      <form action="list.do" method="get" class="form-inline">
        <input type="hidden" name="raiders_id" value="${param.raiders_id}" />

        <div class="form-group">
          <label for="startDate">시작 날짜:</label>
          <input
            type="date"
            id="startDate"
            name="startDate"
            value="${param.startDate}"
            class="form-control"
          />
        </div>

        <div class="form-group">
          <label for="endDate">종료 날짜:</label>
          <input
            type="date"
            id="endDate"
            name="endDate"
            value="${param.endDate}"
            class="form-control"
          />
        </div>

        <button type="submit" class="button_style">필터 적용</button>
        <input
          type="button"
          class="button_style"
          id="btn_popup_update"
          value="마이페이지"
          onclick="location.href ='../mypage.do'"
        />
      </form>

      <table id="delivery-table" class="table table-striped">
        <thead>
          <tr>
            <th>가게 이름</th>
            <th>주문 금액</th>
            <th>주문 날짜</th>
            <th>배달 주소</th>
            <th>수수료</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="vo" items="${completedDeliveries}">
            <tr>
              <td>${vo.shop_name}</td>
              <td>${vo.orders_price} 원</td>
              <td>${vo.orders_cdate}</td>
              <td>${vo.addr_line1}, ${vo.addr_line2}</td>
              <td>${vo.commission} 원</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <h3>총 수입: ${totalCommission} 원</h3>

      <div class="pagination">${pageMenu}</div>
    </div>
  </body>
</html>
