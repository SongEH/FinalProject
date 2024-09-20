<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <style type="text/css">
    #box {
      width: 600px;
      margin: auto;
      margin-top: 50px;
    }

    textarea {
      width: 100%;
      resize: none;
    }

    input[type='button'] {
      width: 100px;
    }

    /* img {
      width: 200px;
    } */
  </style>


  <script type="text/javascript"> </script>



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

      <h1>Form Layouts</h1>

      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active">Layouts</li>
        </ol>
      </nav>

    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-10">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">주문 상세보기</h5>
              <p>${ vo.shop_name }</p>
              <p>${ vo.orders_name }</p>
              <p>주문일시
                <fmt:formatDate value="${vo.orders_cdate}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
              </p>
              <p>주문번호 ${vo.orders_merchant_uid}</p>

              <hr>
              메뉴 목록

              <table>
                <c:forEach var="vo" items="${list}">

                  <!-- 상점 항목 정보를 출력 -->
                  <tr>
                    <td class="cart_menuimg">
                      <div>
                        <img src="../resources/images/${vo.menu_img}" class="img-fluid rounded" alt="..." width="150px">
                      </div>
                    </td>
                    <td class="cart_menuname">${vo.menu_name}</td>

                    <td class="cart_quantity">
                      <input type="number" class="form-control quantity-input" id="quantity_${vo.carts_id}"
                        value="${vo.carts_quantity}" min="1" max="50" disabled>
                    </td>

                    <td class="cart_price">${vo.menu_price}</td>
                    <td class="cart_total_price">
                      ${vo.menu_price * vo.carts_quantity}
                    </td>
                    <td class="cart_cdate">${vo.carts_cdate}</td>


                  </tr>
                </c:forEach>
              </table>

              <hr>
              <p>주문금액 (쿠폰 구현되면 업데이트)</p>
              <p>쿠폰 (쿠폰 구현되면 업데이트) </p>
              <p>총 결제 금액 ${ vo.orders_price }</p>
              <p>결제방법 ${ vo.orders_payment }</p>

              <hr>
              <p>주소 ${ vo.addr_line1 } ${ vo.addr_line2 }</p>
              <p>회원 전화번호 ${vo.member_phone} </p>
              <p>가게 요청사항 ${ vo.orders_srequest }</p>
              <p>배달 요청사항 ${ vo.orders_drequest }</p>

              <button>주문내역 삭제</button>
              <button>같은 메뉴 담기</button>
            </div>
          </div>
        </div>
      </div>
    </section>

  </main><!-- End #main -->
</body>

</html>