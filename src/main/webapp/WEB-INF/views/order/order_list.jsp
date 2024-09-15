<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
  function delete_menu(orders_id){
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
    location.href="../reviews/insert_form.do?orders_id=" + orders_id;
    }
</script>
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

    <section class="section">
      <table>
      <div class="row align-items-top">
        <div class="col-lg-6">
          
            <c:forEach var="vo" items="${list}">
              <!-- Card with an image on left -->
              <tr>
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
                            ${vo.shop_name}
                          </h5>
                          <p class="card-text">${vo.orders_name}, ${vo.menu_count}개</p>
                          <p class="card-text">가격 ${vo.orders_price}원</p>
                </td>
                <td>
                  <input class="btn btn-info" type="button" id="btn_popup_update" value="상세보기"  onclick="window.location.href='order_show.do?orders_id=' + ${vo.orders_id}">
                  <input class="btn btn-info" type="button" id="btn_popup_update" value="배송조회"
                    onclick="modify_menu('${vo.orders_id}');">
                  <input class="btn btn-danger" type="button" id="btn_popup_delete" value="리뷰작성"
                    onclick="delete_menu('${vo.orders_id}');">
                </td>

        </div>
      </div>

      </div><!-- End Card with an image on left -->
      </div>
      </tr>
      </c:forEach>
      
      </div>
      </div>
    </table>
    </section>
  </main><!-- End #main -->
</body>

</html>