<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

<%@ page import="first.final_project.vo.OwnerVo" %>
<%@ page import="first.final_project.vo.MemberVo" %>
<%@ page import="first.final_project.vo.AdminVo" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
  // 세션에서 user 객체를 가져옴
  Object user = session.getAttribute("user"); 

  // 사용자 객체 타입에 따라 문자열을설정합니다 

  String userType = "UNKNOWN"; 
  if (user instanceof AdminVo) { userType = "ADMIN"; } 
  else if (user instanceof MemberVo) { userType = "MEMBER"; } 
  else if (user instanceof OwnerVo) { userType = "OWNER"; } 

  session.setAttribute("userType",userType);

%>

<!DOCTYPE html>

<html lang="ko">

<head>
  <meta charset="utf-8" />
  <script type="text/javascript">
    var userType = "<%= userType %>";
    console.log("User Type: " + userType);

    // 다른 JavaScript 코드
  </script>
  <style>
  .disabled-link {
  color: gray; /* Set your desired color */
  pointer-events: none; /* Disable clicking */
  text-decoration: none; /* Remove underline */
}
.disabled-link:hover {
    color: gray; /* Prevent color change */
    cursor: default; /* Show a default cursor instead of a pointer */
}
  </style>

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">
    <!--------------------- 사용자 로그인 시 --------------------->
    <% // switch 문을 사용하여 userType에 따라 다르게 처리 
    
    switch (userType) {
      case "MEMBER": %>
    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-layout-text-window-reverse"></i><span>회원페이지</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          <li>
            <a href="/member/mypage.do">
              <i class="bi bi-circle"></i><span>회원정보</span>
            </a>
          </li>
          <li>
            <a href="/addr/addr_list.do">
              <i class="bi bi-circle"></i><span>주소정보</span>
            </a>
          </li>
        </ul>
      </li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-layout-text-window-reverse"></i><span>장바구니</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          
          <li>
            <a href="/order/list.do">
              <i class="bi bi-circle"></i><span>주문내역</span>
            </a>
          </li>
          <li>
            <a href="/carts/list.do">
              <i class="bi bi-circle"></i><span>장바구니</span>
            </a>
          </li>
          <li>
            <a href="/reviews/list.do">
              <i class="bi bi-circle"></i><span>리뷰내역</span>
            </a>
          </li>
        </ul>
      </li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-layout-text-window-reverse"></i><span>공지&문의</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          
          <li>
            <a href="/notice/list.do">
              <i class="bi bi-circle"></i><span>공지사항</span>
            </a>
          </li>
          <li>
            <a href="/inquiries/list.do">
              <i class="bi bi-circle"></i><span>문의사항</span>
            </a>
          </li>
        </ul>
      </li>
    </ul>

    <!--------------------- 사용자 로그인 시 END--------------------->

    <!--------------------- 관리자 로그인 시 --------------------->
    <% break; case "ADMIN": %>
    <ul class="sidebar-nav" id="sidebar-nav">
      

      <li class="nav-item">
        <a class="nav-link" data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-journal-text"></i><span>관리자페이지</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="forms-nav" class="nav-content collapse show" data-bs-parent="#sidebar-nav">
          <li>
            <a href="/admin/member_list.do">
              <i class="bi bi-circle"></i><span>회원리스트</span>
            </a>
          </li>
          <li>
            <a href="/admin/owner_list.do">
              <i class="bi bi-circle"></i><span>사장리스트</span>
            </a>
          </li>
          <li>
            <a href="/admin/pending_requests.do">
              <i class="bi bi-circle"></i><span>승인요청</span>
            </a>
          </li>
        </ul>
      </li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-layout-text-window-reverse"></i><span>공지&문의</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          <li>
            <a href="/notice/list.do">
              <i class="bi bi-circle"></i><span>공지사항</span>
            </a>
          </li>
          <li>
            <a href="/inquiries/list.do">
              <i class="bi bi-circle"></i><span>문의사항</span>
            </a>
          </li>
        </ul>
      </li>
    </ul>
    <!--------------------- 관리자 로그인 시 END--------------------->

    <!--------------------- 사장 로그인 시 --------------------->
    <% break; case "OWNER": %>
    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link" data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-journal-text"></i><span>메뉴관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="forms-nav" class="nav-content collapse show" data-bs-parent="#sidebar-nav">
          <li>
            <a href="/menu/list.do">
              <i class="bi bi-circle"></i><span>메뉴목록</span>
            </a>
          </li>
          <li>
            <a href="/menu/insert_form.do">
              <i class="bi bi-circle"></i><span>메뉴등록</span>
            </a>
          </li>
        </ul>
      </li>
      <!-- End Forms Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-layout-text-window-reverse"></i><span>가맹점관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          <li>
            <c:choose>
              <c:when test="${hasShop}">
                <a href="#" class="disabled-link">
                  <i class="bi bi-circle"></i><span>가맹점</span>
                </a>
              </c:when>
              <c:otherwise>
                 <a href="/shop/insert_form.do">
                  <i class="bi bi-circle"></i><span>가맹점 등록</span>
                </a>
              </c:otherwise>
            </c:choose>
          </li>
          <li>
            <a href="/shop/modify_form.do">
              <i class="bi bi-circle"></i><span>가맹점 수정</span>
            </a>
          </li>
        </ul>
      </li>
      <!-- 새로운 주문관리 메뉴 추가 -->
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#orders-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-box"></i><span>주문 관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="orders-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
          <li>
            <a href="/order/accept.do">
              <i class="bi bi-circle"></i><span>주문 내역</span>
            </a>
          </li>
          <li>
            <a href="/order/complete.do">
              <i class="bi bi-circle"></i><span>완료 주문 내역</span>
            </a>
          </li>
        </ul>
      </li>
      <!-- 리뷰 관리 메뉴 추가 -->
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#icons-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-gem"></i><span>리뷰관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="icons-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        <li>
            <a href="/reviews/listByOwner.do">
                <i class="bi bi-circle"></i><span>리뷰관리</span>
            </a>
        </li>
        </ul>
      </li>
    </ul>
    </li>
    <% } %>

    <!--------------------- 사장 로그인 시 END --------------------->

    <!-- End Tables Nav -->
    <!-- <li class="nav-item">
        <a
          class="nav-link collapsed"
          data-bs-target="#components-nav"
          data-bs-toggle="collapse"
          href="#"
        >
          <i class="bi bi-menu-button-wide"></i><span>Components</span
          ><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul
          id="components-nav"
          class="nav-content collapse"
          data-bs-parent="#sidebar-nav"
        >
          <li>
            <a href="components-alerts.html">
              <i class="bi bi-circle"></i><span>Alerts</span>
            </a>
          </li>
          <li>
            <a href="components-accordion.html">
              <i class="bi bi-circle"></i><span>Accordion</span>
            </a>
          </li>
          <li>
            <a href="components-badges.html">
              <i class="bi bi-circle"></i><span>Badges</span>
            </a>
          </li>
          <li>
            <a href="components-breadcrumbs.html">
              <i class="bi bi-circle"></i><span>Breadcrumbs</span>
            </a>
          </li>
          <li>
            <a href="components-buttons.html">
              <i class="bi bi-circle"></i><span>Buttons</span>
            </a>
          </li>
          <li>
            <a href="components-cards.html">
              <i class="bi bi-circle"></i><span>Cards</span>
            </a>
          </li>
          <li>
            <a href="components-carousel.html">
              <i class="bi bi-circle"></i><span>Carousel</span>
            </a>
          </li>
          <li>
            <a href="components-list-group.html">
              <i class="bi bi-circle"></i><span>List group</span>
            </a>
          </li>
          <li>
            <a href="components-modal.html">
              <i class="bi bi-circle"></i><span>Modal</span>
            </a>
          </li>
          <li>
            <a href="components-tabs.html">
              <i class="bi bi-circle"></i><span>Tabs</span>
            </a>
          </li>
          <li>
            <a href="components-pagination.html">
              <i class="bi bi-circle"></i><span>Pagination</span>
            </a>
          </li>
          <li>
            <a href="components-progress.html">
              <i class="bi bi-circle"></i><span>Progress</span>
            </a>
          </li>
          <li>
            <a href="components-spinners.html">
              <i class="bi bi-circle"></i><span>Spinners</span>
            </a>
          </li>
          <li>
            <a href="components-tooltips.html">
              <i class="bi bi-circle"></i><span>Tooltips</span>
            </a>
          </li>
        </ul>
      </li> -->
    <!-- End Components Nav -->

    <!-- <li class="nav-item">
        <a
          class="nav-link collapsed"
          data-bs-target="#charts-nav"
          data-bs-toggle="collapse"
          href="#"
        >
          <i class="bi bi-bar-chart"></i><span>Charts</span
          ><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul
          id="charts-nav"
          class="nav-content collapse"
          data-bs-parent="#sidebar-nav"
        >
          <li>
            <a href="charts-chartjs.html">
              <i class="bi bi-circle"></i><span>Chart.js</span>
            </a>
          </li>
          <li>
            <a href="charts-apexcharts.html">
              <i class="bi bi-circle"></i><span>ApexCharts</span>
            </a>
          </li>
          <li>
            <a href="charts-echarts.html">
              <i class="bi bi-circle"></i><span>ECharts</span>
            </a>
          </li>
        </ul>
      </li> -->
    <!-- End Charts Nav -->

    <!-- <li class="nav-item">
        <a
          class="nav-link collapsed"
          data-bs-target="#icons-nav"
          data-bs-toggle="collapse"
          href="#"
        >
          <i class="bi bi-gem"></i><span>Icons</span
          ><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul
          id="icons-nav"
          class="nav-content collapse"
          data-bs-parent="#sidebar-nav"
        >
          <li>
            <a href="icons-bootstrap.html">
              <i class="bi bi-circle"></i><span>Bootstrap Icons</span>
            </a>
          </li>
          <li>
            <a href="icons-remix.html">
              <i class="bi bi-circle"></i><span>Remix Icons</span>
            </a>
          </li>
          <li>
            <a href="icons-boxicons.html">
              <i class="bi bi-circle"></i><span>Boxicons</span>
            </a>
          </li>
        </ul>
      </li> -->
    <!-- End Icons Nav -->

    <!-- <li class="nav-heading">Pages</li>

  <li class="nav-item">
    <a class="nav-link collapsed" href="users-profile.html">
      <i class="bi bi-person"></i>
      <span>Profile</span>
    </a>
  </li> -->
    <!-- End Profile Page Nav -->

    <!-- <li class="nav-item">
    <a class="nav-link collapsed" href="pages-faq.html">
      <i class="bi bi-question-circle"></i>
      <span>F.A.Q</span>
    </a>
  </li> -->
    <!-- End F.A.Q Page Nav -->

    <!-- <li class="nav-item">
    <a class="nav-link collapsed" href="pages-contact.html">
      <i class="bi bi-envelope"></i>
      <span>Contact</span>
    </a>
  </li> -->
    <!-- End Contact Page Nav -->

    <!-- <li class="nav-item">
    <a class="nav-link collapsed" href="pages-register.html">
      <i class="bi bi-card-list"></i>
      <span>Register</span>
    </a>
  </li> -->
    <!-- End Register Page Nav -->

    <!-- <li class="nav-item">
    <a class="nav-link collapsed" href="pages-login.html">
      <i class="bi bi-box-arrow-in-right"></i>
      <span>Login</span>
    </a>
  </li> -->
    <!-- End Login Page Nav -->

    <!-- <li class="nav-item">
    <a class="nav-link collapsed" href="pages-error-404.html">
      <i class="bi bi-dash-circle"></i>
      <span>Error 404</span>
    </a>
  </li> -->
    <!-- End Error 404 Page Nav -->

    <!-- <li class="nav-item">
    <a class="nav-link collapsed" href="pages-blank.html">
      <i class="bi bi-file-earmark"></i>
      <span>Blank</span>
    </a>
  </li> -->
    <!-- End Blank Page Nav -->
  </aside>
  <!-- End Sidebar-->
</head>

</html>