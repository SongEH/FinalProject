<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <script type="text/javascript">
    // JSP에서 userType 값을 JavaScript로 전달
    var userType = '<%= session.getAttribute("userType") %>';

    // 회원은 shop_listOne.jsp에서 장바구니 목록 표시
    if (userType === 'MEMBER') {
      $(document).ready(function () {
        updateCartList(); // 페이지 로딩 시 함수 실행
      });
    }


    // 사장용 메뉴상세 보기
    function show_menu(menu_id) {

      location.href = "show.do?menu_id=" + menu_id;
    }

    // 사장용 메뉴 삭제
    function delete_menu(menu_id) {

      if (confirm("정말 삭제하시겠습니까?") == false) return;

      location.href = "delete.do?menu_id=" + menu_id;
    }

    // 사장용 메뉴 수정
    function modify_menu(menu_id) {

      location.href = "modify_form.do?menu_id=" + menu_id;

    }

    // 회원용 장바구니담기 누르면 모달 팝업
    function menu_modal(menu_id, menu_soldout) {

      if (menu_soldout == 1) {
        alert("품절 상품은 담을 수 없습니다.");
        return;
      }

      // Show the modal
      var myModal = new bootstrap.Modal(document.getElementById('menuModal'), {
        backdrop: 'static',
        keyboard: false
      });
      myModal.show();

      // p_idx에 대한 사진정보 가져오기(Ajax이용 JSON형식)
      $.ajax({
        url: "/menu/menu_one.do", //PhotoOneAction
        data: {
          "menu_id": menu_id
        }, //parameter => photo_one.do?p_idx=5
        dataType: "json",
        success: function (res_data) {
          // res_data = {"p_idx":5, "p_title":"제목" , "p_content":"내용" , "p_filename":"a.jpg",....}
          console.log(res_data);

          $("#pop_image").prop("src", "../resources/images/" + res_data.menu_img);

          $("#pop_title").html(res_data.menu_name);
          $("#pop_content").html(res_data.menu_content);
          $("#pop_regdate").html(res_data.menu_cdate);
          $("#pop_price").html(res_data.menu_price);


          // popup modal에 hidden 필드에 넣을 값     
          $('#pop_hidden_menuid').val(menu_id);
          $('#pop_hidden_shopid').val(res_data.shop_id);
        },
        error: function (err) {
          alert(err.responseText);
        }
      });

    }

    // 회원용 장바구니 담기
    function input_cart() {

      // 모달창에서 hidden 태그의 값을 가져온다. 
      menu_id = document.getElementById("pop_hidden_menuid").value;
      shop_id = document.getElementById("pop_hidden_shopid").value;

      carts_quantity = document.getElementById("pop_quantity").value;

      // ajax로 장바구니 추가 
      // 회원ID, 가게ID, 메뉴ID, 수량 추가 
      $.ajax({
        url: '/carts/insert.do',
        type: 'POST',
        data: {
          menu_id: menu_id,
          shop_id: shop_id,
          carts_quantity: carts_quantity
        },
        success: function (response) {
          updateCartList();
          alert("장바구니에 추가되었습니다!");
          console.log("Item added to cart successfully:", response);
        },
        error: function (xhr, status, error) {
          alert("장바구니에 아이템을 추가하는 데 실패했습니다: " + xhr.responseText);
        }
      });
    }

    // 회원용 장바구니 리스트 업데이트
    function updateCartList() {
      // 장바구니 목록을 업데이트하기 위한 AJAX 요청 - 한지혜
      $.ajax({
        url: '/carts/list2.do',
        type: 'GET',
        success: function (response) {
          // 응답으로 받은 HTML을 장바구니 목록에 업데이트
          $('#cart_list').html(response);
        },
        error: function (xhr, status, error) {
          alert("장바구니 목록을 불러오는 데 실패했습니다: " + xhr.responseText);
        }
      });
    }
  </script>

</head>

<body>

  <%@include file="popup.jsp" %>
  <c:set var="userType" value="${sessionScope.userType}" />
  <!-- <section class="section" style="margin: auto;"> -->
  <!-- <div class="row align-items-top"> -->
  <!-- <div class="row"> -->
  <!-- <div class="col-lg-6"> -->
  <c:forEach var="item" items="${menu_list}">
    <!-- item.menu_status가 1인 경우만 표시 -->
    <c:if test="${item.menu_status == 1}">
      <!-- userType이 'MEMBER'일 때만 menu_hidden이 0인 경우를 표시합니다 -->
      <c:if test="${userType == 'MEMBER' ? item.menu_hidden == 0 : true}">
        <!-- Card with an image on left -->
        <div class="card mb-3">
          <div class="row g-0" lass="photo">
            <!-- popup:Modal -->

            <div class="col-md-4">
              <img src="../resources/images/${item.menu_img}" class="img-fluid rounded-start" alt="...">
            </div>
            <div class="col-md-8">
              <div class="card-body">
                <h5 class="card-title">
                  <div style="color:red;">
                    <c:choose>
                      <c:when test="${item.menu_popularity == 1}">
                        인기
                      </c:when>
                      <c:when test="${item.menu_hidden == 1}">
                        숨김
                      </c:when>
                      <c:when test="${item.menu_soldout == 1}">
                        품절
                      </c:when>
                      <c:otherwise>
                        <!-- 아무 조건에도 해당하지 않으면 빈 문자열 -->
                      </c:otherwise>

                    </c:choose>
                  </div>
                  ${item.menu_name}
                </h5>
                <p class="card-text">${item.menu_content}</p>
                <p class="card-text">${item.menu_price}원</p>


                <c:if test="${userType == 'MEMBER'}">
                  <input class="btn btn-info" type="button" value="장바구니담기"
                    onclick="menu_modal('${ item.menu_id }', '${ item.menu_soldout }');">
                </c:if>
                <c:if test="${userType == 'OWNER'}">
                  <input class="btn btn-info" type="button" id="btn_popup_update" value="상세보기"
                    onclick="show_menu('${item.menu_id}');">
                  <input class="btn btn-info" type="button" id="btn_popup_update" value="수정"
                    onclick="modify_menu('${item.menu_id}');">
                  <input class="btn btn-danger" type="button" id="btn_popup_delete" value="삭제"
                    onclick="delete_menu('${item.menu_id}');">
                </c:if>
              </div>
            </div>

          </div><!-- End Card with an image on left -->
        </div>
      </c:if>
    </c:if>
  </c:forEach>
  </div>
  </div>
  </section>
</body>

</html>