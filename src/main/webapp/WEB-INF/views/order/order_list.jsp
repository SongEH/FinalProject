<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
    integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous">
  </script>

  <script>
    function insert_review(orders_id) {
      // $.ajax({
      // url     :     "../reviews/insert_form.do",
      // data    :      {"orders_id": orders_id},
      // success :   function(res_data){
      //         alert("리뷰 등록이 완료되었습니다.");
      //         ("reviews_list_display").html(res_data);
      // },
      // error   :   function(err){
      // alert(error.responseText)
      // }
      // });
      location.href = "../reviews/insert_form.do?orders_id=" + orders_id;
    }
  </script>


  <!-- polling 방식으로 주문상태 업데이트 -->
  <!-- <script>
    function fetchOrders() {
      $.ajax({
        url: `/order/order_list.do`, // 주문 내역을 가져오는 API 경로
        data: {
          type: 'member'
        }, // type 데이터를 전달
        method: 'GET',
        success: function (orders) {

          orders.forEach(order => {
            console.log(order.orders_id, order.orders_status);

            let orders_id = '#order-' + order.orders_id;
            let orderRow = $(orders_id);
            let orderStatusElement = orderRow.find('.orders-status')[0]; // jQuery로 선택한 후, 첫 번째 요소 가져오기

            console.log("orderRow" + orderRow);
            if (orderStatusElement) {
              orderStatusElement.textContent = order.orders_status; // 상태 업데이트
              console.log("Status updated for order " + order.orders_id);
            } else {
              console.log("요소를 찾을 수 없습니다: " + orders_id); // 요소를 찾지 못했을 경우 로그 출력
            }
          });
        },
        error: function (err) {
          console.error('주문을 가져오는 중 오류 발생:', err);
        }
      });
    }

    // 특정 주기 마다 주문 내역을 가져옵니다.
    setInterval(fetchOrders, 30000); // 10000ms = 10초
  </script> -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

  <script>
    var socket = new SockJS('${pageContext.request.contextPath}/ws-orders');
    var stompClient = Stomp.over(socket);

    // WebSocket 연결 설정
    stompClient.connect({}, function (frame) {
      // 주문 상태 업데이트 메시지 구독
      stompClient.subscribe('/topic/orders', function (message) {
        location.reload(); // 메시지 수신 시 페이지 새로고침
      });
    });
  </script>


  <style>
    header {
      display: flex;
      justify-content: space-between;
      /* Align logo to the left and login to the right */
      align-items: center;
      /* Vertically center the items */
      padding: 10px;
      /* Optional: Add some padding */
      background-color: #F0A8D0;
    }
  </style>

</head>


<body>

  <%@include file="../common.jsp" %>

  <%@include file="../header.jsp" %>

  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">

      <h1>주문내역</h1>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active">Layouts</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    <c:if test="${empty list}">
      <p>주문 내역이 없습니다.</p>
    </c:if>

    <c:if test="${not empty list}">
      <!-- 날짜 필터링 폼 -->
      <form action="list.do" method="get" class="form-inline">
        <input type="hidden" name="member_id" value="${param.member_id}" />
        <div class="form-group">
          <label for="startDate">시작 날짜:</label>
          <input type="date" id="startDate" name="startDate" value="${param.startDate}" class="form-control" />
        </div>
        <div class="form-group" style="margin-left: 10px">
          <label for="endDate">종료 날짜:</label>
          <input type="date" id="endDate" name="endDate" value="${param.endDate}" class="form-control" />
        </div>
        <button type="submit" class="btn btn-primary" style="margin-left: 10px">
          검색
        </button>
      </form>



      <section class="section">

        <div class="row align-items-top">
          <div class="col-lg-6">


            <table>
              <c:forEach var="vo" items="${list}">
                <c:if test="${vo.orders_isdelete == 0}">
                  <tr id="order-${vo.orders_id}">
                    <!-- 각 주문에 고유 ID를 부여 -->
                    <td>
                      <div class="card mb-3">
                        <div class="row g-0" lass="photo">
                          <!-- popup:Modal -->

                          <div class="col-md-4">
                            <img src="../resources/images/${vo.shop_img}" class="img-fluid rounded-start" alt="...">
                          </div>
                          <div class="col-md-8">
                            <div class="card-body">
                              <h5 class="card-title">
                                <p class="orders-status" style="color:red;">${vo.orders_status}</p>${vo.shop_name}
                              </h5>
                              <c:if test="${vo.orders_status != '배달 완료' && vo.delivery_time != 0}">
                                <p class="delivery-time">배달 예정 시간: ${vo.delivery_time}</p>
                              </c:if>
                              <p class="card-text">주문일시
                                <fmt:formatDate value="${vo.orders_cdate}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
                              </p>
                              <p class="card-text">${vo.orders_name}, ${vo.menu_count}개</p>
                              <p class="card-text">가격 ${vo.orders_price}원</p>
                    </td>
                    <td>
                      <input class="btn btn-info" type="button" id="btn_popup_update" value="상세보기"
                        onclick="window.location.href='order_show.do?orders_id=' + ${vo.orders_id}">
                      <input class="btn btn-info" type="button" id="btn_popup_update" value="배송조회"
                        onclick="modify_menu('${vo.orders_id}');">
                      <c:choose>
                        <c:when test="${vo.hasReview}">
                          <input class="btn btn-danger" type="button" id="btn_popup_delete" value="리뷰작성" disabled>
                        </c:when>
                        <c:otherwise>
                          <input class="btn btn-danger" type="button" id="btn_popup_delete" value="리뷰작성"
                            onclick="insert_review('${vo.orders_id}');">
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:if>
              </c:forEach>
            </table>
            <!-- 페이징 처리 -->
            <div style="text-align: center; margin-top: 20px; font-size: 15px">
              ${pageMenu}
            </div>

            <!-- 필터링된 페이지에서도 현재 날짜와 필터를 유지하기 위한 hidden 필드 -->
            <input type="hidden" name="startDate" value="${param.startDate}" />
            <input type="hidden" name="endDate" value="${param.endDate}" />
    </c:if>
    </div>
    </div>

    </section>




  </main><!-- End #main -->
</body>

</html>