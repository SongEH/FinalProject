<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ page import="first.final_project.vo.OwnerVo" %> <%@
page import="first.final_project.vo.MemberVo" %> <%@ page
import="first.final_project.vo.AdminVo" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
  <head>
    <meta charset="utf-8" />

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
    <script>
      // 문의사항 답변 상황 확인
      $(document).ready(function () {
        // Only execute if ajaxExecuted is false and status is 0
        let ajaxExecuted = false; // Flag to prevent multiple AJAX calls
        let status = 0; // Example status
        if (!ajaxExecuted && status === 0) {
          $.ajax({
            url: "../member_inquiries/answer_count.do", // Adjust the URL if needed
            method: "GET",
            data: { m_inquiries_type: "전체" }, // Pass any parameters if necessary
            success: function (response) {
              // response now contains the integer value of null_answer_count directly
              // alert("Null Answer Count: " + response.null_answer_count);
              // alert("owner_null_answer_count:" + response.owner_null_answer_count)

              // Update the HTML to show the count next to the link
              if (
                response.null_answer_count !== null &&
                response.null_answer_count > 0
              ) {
                $("#null_answer_count").text(response.null_answer_count); // Set the count in the span
              }

              if (
                response.owner_null_answer_count !== null &&
                response.owner_null_answer_count > 0
              ) {
                $("#owner_null_answer_count").text(
                  response.owner_null_answer_count
                ); // Set the count in the span
              }

              // Set ajaxExecuted to true to prevent future executions
            },
            error: function (err) {
              alert(err.responseText);
            },
          });
        }
      });
    </script>
    <!-- ======= Sidebar ======= -->
    <aside id="sidebar" class="sidebar">
      <c:choose>
        <c:when test="${not empty sessionScope.userType}">
          <c:choose>
            <c:when test="${sessionScope.userType == 'MEMBER'}">
              <ul class="sidebar-nav" id="sidebar-nav">
                <li class="nav-item">
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#member-management"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-person"></i><span>회원관리</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="member-management"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
                    <li>
                      <a href="/member/mypage.do">
                        <i class="bi bi-circle"></i><span>회원정보</span>
                      </a>
                    </li>
                    <li>
                      <a href="/addr/addr_list.do">
                        <i class="bi bi-circle"></i><span>주소목록</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <li class="nav-item">
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#forms-nav"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-journal-text"></i><span>주문&리뷰</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="forms-nav"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
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
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#tables-nav"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-layout-text-window-reverse"></i
                    ><span>공지&문의</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="tables-nav"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
                    <li>
                      <a href="/notice/list.do">
                        <i class="bi bi-circle"></i><span>공지사항</span>
                      </a>
                    </li>
                    <li>
                      <a href="/member_inquiries/list.do">
                        <i class="bi bi-circle"></i><span>문의사항</span>
                      </a>
                    </li>
                  </ul>
                </li>
              </ul>
            </c:when>
            <c:when test="${sessionScope.userType == 'ADMIN'}">
              <ul class="sidebar-nav" id="sidebar-nav">
                <li class="nav-item">
                  <a
                    class="nav-link"
                    data-bs-target="#forms-nav"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-person"></i><span>관리자페이지</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="forms-nav"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
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
                      <a href="/admin/shop_list.do">
                        <i class="bi bi-circle"></i><span>가게리스트</span>
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
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#tables-nav"
                    data-bs-toggle="collapse"
                    href="#"
                    onclick="null_count();"
                  >
                    <i class="bi bi-layout-text-window-reverse"></i
                    ><span>공지&문의</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="tables-nav"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
                    <li>
                      <a href="/notice/list.do">
                        <i class="bi bi-circle"></i><span>공지사항</span>
                      </a>
                    </li>
                    <li>
                      <a href="/member_inquiries/list.do">
                        <i class="bi bi-circle"></i><span>회원 문의사항</span>
                        <span
                          id="null_answer_count"
                          class="badge rounded-pill bg-warning"
                          style="margin-left: 5px"
                        ></span>
                      </a>
                    </li>
                    <li>
                      <a href="/owner_inquiries/list.do">
                        <i class="bi bi-circle"></i><span>사장 문의사항</span>
                        <span
                          id="owner_null_answer_count"
                          class="badge rounded-pill bg-warning"
                          style="margin-left: 5px"
                        ></span>
                      </a>
                    </li>
                  </ul>
                </li>
                <li class="nav-item">
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#coupon-nav"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-person"></i><span>쿠폰</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="coupon-nav"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
                    <li>
                      <a href="/coupon/main.do"
                        ><i class="bi bi-circle"></i><span>쿠폰발행</span></a
                      >
                    </li>
                    <li>
                      <a href="/coupon/list.do"
                        ><i class="bi bi-circle"></i><span>쿠폰조회</span></a
                      >
                    </li>
                  </ul>
                </li>
              </ul>
            </c:when>
            <c:when test="${sessionScope.userType == 'OWNER'}">
              <ul class="sidebar-nav" id="sidebar-nav">
                <li class="nav-item">
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#owner-management"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-person"></i><span>사장관리</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="owner-management"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
                    <li>
                      <a href="/owner/ownerpage.do">
                        <i class="bi bi-circle"></i><span>사장정보</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <li class="nav-item">
                  <a
                    class="nav-link"
                    data-bs-target="#forms-nav"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-journal-text"></i><span>메뉴관리</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="forms-nav"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
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
                <li class="nav-item">
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#tables-nav"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-layout-text-window-reverse"></i
                    ><span>가맹점관리</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="tables-nav"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
                    <li>
                      <c:choose>
                        <c:when test="${hasShop}">
                          <a href="#" class="disabled-link">
                            <i class="bi bi-circle"></i
                            ><span>가맹점 등록 완료</span>
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
                <li class="nav-item">
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#orders-nav"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-box"></i><span>주문 관리</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="orders-nav"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
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
                <li class="nav-item">
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#icons-nav"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-gem"></i><span>리뷰관리</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="icons-nav"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
                    <li>
                      <a href="/reviews/listByOwner.do">
                        <i class="bi bi-circle"></i><span>리뷰관리</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <li class="nav-item">
                  <a
                    class="nav-link collapsed"
                    data-bs-target="#notice-management"
                    data-bs-toggle="collapse"
                    href="#"
                  >
                    <i class="bi bi-star"></i><span>공지&문의</span
                    ><i class="bi bi-chevron-down ms-auto"></i>
                  </a>
                  <ul
                    id="notice-management"
                    class="nav-content collapse"
                    data-bs-parent="#sidebar-nav"
                  >
                    <li>
                      <a href="/notice/list.do">
                        <i class="bi bi-circle"></i><span>공지사항</span>
                      </a>
                    </li>
                    <li>
                      <a href="/owner_inquiries/list.do">
                        <i class="bi bi-circle"></i><span>문의사항</span>
                      </a>
                    </li>
                  </ul>
                </li>
              </ul>
            </c:when>
          </c:choose>
        </c:when>
      </c:choose>

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
