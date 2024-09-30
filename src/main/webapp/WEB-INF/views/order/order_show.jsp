<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <style>
    .card {
      background-color: #fff;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    h5,
    h6 {
      margin-bottom: 10px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    td {
      padding: 10px;
      border: none;
      text-align: left;
      font-weight: bold;

    }

    td:nth-child(2),
    td:nth-child(4),
    td:nth-child(5) {
      text-align: left;
      font-weight: normal;
    }

    .button_style {
      margin-top: 10px;
      padding: 10px 15px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .button_style:hover {
      background-color: #0056b3;
    }

    #menuList table {
      border-collapse: collapse;
      /* 테이블 경계 제거 */
    }

    #menuList td {
      padding: 10px;
      text-align: left;
      font-weight: normal;
    }

    #menuList img {
      width: 70px;
      border-radius: 10px;
    }
  </style>



  <script type="text/javascript">
    function delete_order(orders_id) {

      if (confirm("정말 삭제하시겠습니까?") == false) return;

      location.href = "delete.do?orders_id=" + orders_id;
    }
  </script>



</head>

<body>

  <%@include file="../common.jsp" %>

  <!-- header import -->
  <%@include file="../header.jsp" %>

  <!-- side bar import -->
  <%@include file="../sidebar.jsp" %>



  <!--화일업로드용 폼  -->
  <form enctype="multipart/form-data" id="ajaxForm" method="post">
    <input id="ajaxFile" type="file" style="display:none;" onChange="ajaxFileChange();">
  </form>




  <main id="main" class="main">

    <div class="pagetitle">

      <h1>주문상세보기</h1><br>
      <br>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">주문&리뷰</li>
          <li class="breadcrumb-item">주문내역</li>
          <li class="breadcrumb-item active">상세보기</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-10">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title" style="font-weight: bold; ">주문 상세보기</h5>
              <hr>
              <table>
                <tr>
                  <td>가게명</td>
                  <td>${vo.shop_name}</td>
                </tr>
                <tr>
                  <td>주문명</td>
                  <td>${vo.orders_name}</td>
                </tr>
                <tr>
                  <td>주문일시</td>
                  <td>
                    <fmt:formatDate value="${vo.orders_cdate}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
                  </td>
                </tr>
                <tr>
                  <td>주문번호</td>
                  <td>${vo.orders_merchant_uid}</td>
                </tr>
              </table>
              <hr>
              <table>
                <tr>
                  <td>주문금액</td>
                  <td>${vo.orders_price}원</td>
                </tr>
                <tr>
                  <td>쿠폰</td>
                  <td>(쿠폰 구현되면 업데이트)</td>
                </tr>
                <tr>
                  <td>총 결제 금액</td>
                  <td>${vo.orders_price}원</td>
                </tr>
                <tr>
                  <td>결제방법</td>
                  <td>${vo.orders_payment}</td>
                </tr>
              </table>
              <hr>
              <table>
                <tr>
                  <td>주소</td>
                  <td>${vo.addr_line1} ${vo.addr_line2}</td>
                </tr>
                <tr>
                  <td>회원 전화번호</td>
                  <td>${vo.member_phone}</td>
                </tr>
                <tr>
                  <td>가게 요청사항</td>
                  <td>${vo.orders_srequest}</td>
                </tr>
                <tr>
                  <td>배달 요청사항</td>
                  <td>${vo.orders_drequest}</td>
                </tr>
              </table>

              <hr>

              <h5>메뉴 목록</h5>
              <table id="menuList">
                <tr>
                  <td>이미지</td>
                  <td>이름</td>
                  <td>개수</td>
                  <td>가격</td>
                </tr>
                <c:forEach var="menu" items="${list}">

                  <tr>
                    <td>
                      <img src="../resources/images/${menu.menu_img}" alt="..." width="100px">
                    </td>
                    <td>${menu.menu_name}</td>
                    <td>${menu.carts_quantity}개
                    </td>
                    <td>${menu.menu_price * menu.carts_quantity}원</td>
                  </tr>
                </c:forEach>
              </table>

              <input class="button_style" type="button" value="주문내역삭제" onclick="delete_order('${vo.orders_id}');">
            </div>
          </div>
        </div>
      </div>
    </section>


</body>

</html>