<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <title>주문 수락 목록</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <style>
    .assign-button {
      width: 200px;
      height: 100px;
      padding: 10px 15px;
      background-color: #f0a8d0;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      font-size: 30px;
    }

    .assign-button:hover {
      background-color: #e090b5;
    }

    .cancel-button {
      width: 200px;
      height: 100px;
      padding: 10px 15px;
      background-color: red;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      font-size: 30px;
    }

    .button-container {
      display: flex;
      gap: 10px;
      margin-left: 20px;
      margin-bottom: 20px;
    }

    .button_style {
      background-color: #f0a8d0;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      padding: 10px 15px;
    }

    .button_style:hover {
      background-color: #e090b5;
    }
  </style>
  </style>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

  <script>
    var currentShopId = '<%= session.getAttribute("shop_id") %>';

    var socket = new SockJS('${pageContext.request.contextPath}/ws-orders');
    var stompClient = Stomp.over(socket);

    // WebSocket 연결 설정
    stompClient.connect({}, function (frame) {
      console.log('Connected: ' + frame);

      // 주문 상태 업데이트 메시지 구독
      stompClient.subscribe('/topic/orders', function (message) {
        var receivedMessage = JSON.parse(message.body); // JSON 형식으로 메시지 파싱

        // 메시지에 있는 shopId와 현재 가게의 ID가 일치하는지 확인
        if (receivedMessage.shop_id == currentShopId && receivedMessage.orderStatus ===
          '주문이 들어왔습니다.') {
          alert("새로운 주문이 도착했습니다: 주문 번호 - " + receivedMessage.orders_id);
          location.reload(); // 페이지 새로고침
        } else {
          location.reload();
        }
      });
    });
  </script>

</head>

<body>

  <%@include file="../common.jsp" %>

  <%@include file="../header.jsp" %>

  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">
      <h1>주문 목록</h1><br>
      <div style="display: flex; justify-content: flex-end;">
      </div>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">주문 관리</li>
          <li class="breadcrumb-item active">주문 목록</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->
    <!-- 주문 목록이 없을 때 메시지 표시 -->
    <c:if test="${empty orders}">
      <p>현재 진행 중인 주문이 없습니다.</p>
    </c:if>

    <!-- 주문 목록 테이블 -->
    <section class="section">
      <div class="row align-items-top">
        <div class="col-lg-12">
          <c:forEach var="order" items="${orders}">
            <!-- 주문 카드 -->
            <div class="card mb-3">
              <div class="row g-0" onclick="show_menu('${order.orders_id}');" id="order-${vo.orders_id}">

                <div class="col-md-8">
                  <div class="card-body">
                    <h5 class="card-title">
                      <p class="orders-status" style="color:red;">${order.orders_status}</span>
                    </h5>
                    <p class="card-text">주문 번호: ${order.orders_id}</p>
                    <p class="card-text">주문 메뉴 : ${order.orders_name}</p>
                    <p class="card-text">가게 요청사항 : ${order.orders_srequest}</p>
                    <p class="card-text">배달 요청사항 : ${order.orders_drequest}</p>
                    <p class="card-text">결제 금액 : ${order.orders_price} 원</p>

                  </div>
                  <div class="button-container">
                    <!-- orders_status가 '주문 대기'일 때만 "주문 대기" 버튼 표시 -->
                    <c:if test="${order.orders_status == '주문 대기'}">
                      <button
                        onclick="window.open('${pageContext.request.contextPath}/riders/route?orders_id=${order.orders_id}', '경로보기', 'width=800,height=600');"
                        class="button_style">
                        위치 확인
                      </button>
                      <form action="${pageContext.request.contextPath}/order/accept">
                        <input type="hidden" name="orders_id" value="${order.orders_id}" />
                        <button type="submit" class="button_style">주문 받기</button>
                      </form>
                      <form action="${pageContext.request.contextPath}/order/cancel">
                        <input type="hidden" name="orders_id" value="${order.orders_id}" />
                        <button type="submit" class="button_style">주문 거절</button>
                      </form>
                    </c:if>
                    <!-- orders_status가 '배차 완료'일 때만 "조리 시작" 버튼 표시 -->
                    <c:if test="${order.orders_status == '배차 완료'}">
                      <form action="${pageContext.request.contextPath}/order/startCooking">
                        <input type="hidden" name="orders_id" value="${order.orders_id}" />
                        <button type="submit" class="button_style">조리 시작</button>
                      </form>
                    </c:if>
                    <!-- orders_status가 '조리 중'일 때만 "조리 완료" 버튼 표시 -->
                    <c:if test="${order.orders_status == '조리 중'}">
                      <form action="${pageContext.request.contextPath}/order/endCooking">
                        <input type="hidden" name="orders_id" value="${order.orders_id}" />
                        <button type="submit" class="button_style">조리 완료</button>
                      </form>
                    </c:if>
                  </div>
                </div>
              </div>
            </div><!-- End 주문 카드 -->
          </c:forEach>
        </div>
      </div>
    </section>

</body>

</html>