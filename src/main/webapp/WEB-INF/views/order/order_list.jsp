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

  <script>
    function insert_review(orders_id) {
      location.href = "../reviews/insert_form.do?orders_id=" + orders_id;
    }
  </script>

  <style>
    .menu-card {
      background-color: white;
      border-radius: 8px;
      padding: 20px 20px;
      /* 상하 2px, 좌우 15px */
      margin-bottom: 20px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      width: 65%;
    }

    .menu-img {
      border-radius: 8px;
      width: 100%;
      height: auto;
      /* 자동 높이 조정 */
      object-fit: cover;
      /* 비율 유지 */
    }

    #btns .button_style {
      margin-left: 100px;

      width: 150px;
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
      <br>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="../index.html">Home</a></li>
          <li class="breadcrumb-item">주문&리뷰</li>
          <li class="breadcrumb-item active">주문내역</li>
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
        <button type="submit" class="button_style" style="margin-left: 10px">
          검색
        </button>
      </form>
      <br>
      <c:forEach var="vo" items="${list}">
        <c:if test="${vo.orders_isdelete == 0}">
          <div class="menu-card">
            <table style="table-layout: fixed;">
              <tr id="order-${vo.orders_id}">
                <!-- 각 주문에 고유 ID를 부여 -->
                <td style="width: 250px; vertical-align: center;" style="flex: 1;">
                  <img src="../resources/images/${vo.shop_img}" class="menu-img" alt="...">
                </td>
                <td style="padding-left: 15px; vertical-align: top;" style="flex: 1;">
                  <h5>
                    ${vo.shop_name}
                    <span class="orders-status" style="color:red;">${vo.orders_status}</span>
                  </h5>
                  <c:if test="${vo.orders_status != '배달 완료' && vo.delivery_time != 0}">
                    <p class="delivery-time">배달 소요 시간: ${vo.delivery_time}분</p>
                  </c:if>
                  <p class="card-text">주문일시 :
                    <fmt:formatDate value="${vo.orders_cdate}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
                  </p>
                  <p class="card-text">메뉴 : ${vo.orders_name}, ${vo.menu_count}개</p>
                  <p class="card-text">가격 :
                    <fmt:formatNumber value="${vo.orders_price}" pattern="#,###" />원</p>
                </td>
                <td style="flex: 1;">
                  <div id="btns">
                    <input class="button_style" type="button" id="btn_popup_update" value="상세보기"
                      onclick="window.location.href='order_show.do?orders_id=' + ${vo.orders_id}">
                    <br><br>
                    <c:choose>
                      <c:when test="${vo.hasReview}">
                        <input class="button_style" type="button" id="btn_popup_delete" value="리뷰작성완료"
                          style="cursor: default; pointer-events: none; background-color:gray" disabled>
                      </c:when>
                      <c:otherwise>
                        <input class="button_style" type="button" id="btn_popup_delete" value="리뷰작성"
                          onclick="insert_review('${vo.orders_id}');">
                      </c:otherwise>
                    </c:choose>
                  </div>
                </td>
              </tr>
            </table>
          </div>
        </c:if>
      </c:forEach>
      <!-- 페이징 처리 -->
      <div style="text-align: center; margin-top: 20px; font-size: 15px">
        ${pageMenu}
      </div>

      <!-- 필터링된 페이지에서도 현재 날짜와 필터를 유지하기 위한 hidden 필드 -->
      <input type="hidden" name="startDate" value="${param.startDate}" />
      <input type="hidden" name="endDate" value="${param.endDate}" />
    </c:if>



  </main><!-- End #main -->
</body>

</html>