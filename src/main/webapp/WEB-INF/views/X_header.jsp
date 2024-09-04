<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Header Example</title>
    <link rel="stylesheet" href="styles.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
    />
    <script src="scripts.js" defer></script>
  </head>
  <body>
    <header id="header" class="header fixed-top d-flex align-items-center">
      <div class="d-flex align-items-center justify-content-between">
        <a href="index.html" class="logo d-flex align-items-center">
          <img src="../resources/assets/img/logo.png" alt="Logo" />
          <span class="d-none d-lg-block">Logo</span>
        </a>
        <i class="bi bi-list toggle-sidebar-btn"></i>
      </div>

      <div class="search-bar">
        <form
          class="search-form d-flex align-items-center"
          method="POST"
          action="#"
        >
          <input
            type="text"
            name="query"
            placeholder="Search"
            title="Enter search keyword"
          />
          <button type="submit" title="Search">
            <i class="bi bi-search"></i>
          </button>
        </form>
      </div>

      <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">
          <li class="nav-item d-block d-lg-none">
            <a class="nav-link nav-icon search-bar-toggle" href="#">
              <i class="bi bi-search"></i>
            </a>
          </li>

          <li class="nav-item dropdown">
            <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
              <i class="bi bi-bell"></i>
              <span class="badge bg-primary badge-number">4</span>
            </a>
            <ul
              class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications"
            >
              <li class="dropdown-header">
                You have 4 new notifications
                <a href="#"
                  ><span class="badge rounded-pill bg-primary p-2 ms-2"
                    >View all</span
                  ></a
                >
              </li>
              <li><hr class="dropdown-divider" /></li>
              <li class="notification-item">
                <i class="bi bi-exclamation-circle text-warning"></i>
                <div>
                  <h4>Lorem Ipsum</h4>
                  <p>Quae dolorem earum veritatis oditseno</p>
                  <p>30 min. ago</p>
                </div>
              </li>
              <li><hr class="dropdown-divider" /></li>
              <li class="notification-item">
                <i class="bi bi-x-circle text-danger"></i>
                <div>
                  <h4>Atque rerum nesciunt</h4>
                  <p>Quae dolorem earum veritatis oditseno</p>
                  <p>1 hr. ago</p>
                </div>
              </li>
              <li><hr class="dropdown-divider" /></li>
              <li class="notification-item">
                <i class="bi bi-check-circle text-success"></i>
                <div>
                  <h4>Sit rerum fuga</h4>
                  <p>Quae dolorem earum veritatis oditseno</p>
                  <p>2 hrs. ago</p>
                </div>
              </li>
              <li><hr class="dropdown-divider" /></li>
              <li class="notification-item">
                <i class="bi bi-info-circle text-primary"></i>
                <div>
                  <h4>Dicta reprehenderit</h4>
                  <p>Quae dolorem earum veritatis oditseno</p>
                  <p>4 hrs. ago</p>
                </div>
              </li>
              <li><hr class="dropdown-divider" /></li>
              <li class="dropdown-footer">
                <a href="#">Show all notifications</a>
              </li>
            </ul>
          </li>

          <!-- 내비게이션 바 -->
    <li class="nav-item dropdown pe-3">
      <div class="text-end">
          <c:if test="${empty sessionScope.user}">
              <!-- 로그인 버튼 -->
              <input type="button" value="로그인" data-toggle="modal" data-target="#authModal" style="font-size: 15px;">
              <!-- 회원가입 버튼 -->
              <input type="button" value="회원가입" data-toggle="modal" data-target="#authModal" style="font-size: 15px;">
          </c:if>
          <c:if test="${not empty sessionScope.user}">
              <!-- 로그아웃 버튼 -->
              <input class="btn btn-default" type="button" value="로그아웃"
                     onclick="location.href='${pageContext.request.contextPath}/member/logout.do'">
              <!-- 마이페이지 버튼 -->
              <input class="btn btn-default" type="button" value="마이페이지" onclick="location.href='${pageContext.request.contextPath}/member/mypage.do'">
              <!-- 관리자 페이지 버튼 -->
              <c:if test="${sessionScope.user.m_grade == '관리자'}">
                  <input class="btn btn-info" type="button" value="관리자페이지" onclick="location.href='${pageContext.request.contextPath}/admin/menu'" style="font-size:15px; color:#333333;">
              </c:if>
          </c:if>
      </div>
  </li>

  <!-- 로그인 및 회원가입 선택 모달 -->
  <div class="modal fade" id="authModal" tabindex="-1" role="dialog" aria-labelledby="authModalLabel" aria-hidden="false">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title" id="authModalLabel">로그인 또는 회원가입 선택</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <div class="modal-body">
                  <div class="form-group">
                      <button class="btn btn-primary btn-block" onclick="showAuthForm('member')">회원 로그인/회원가입</button>
                      <button class="btn btn-secondary btn-block" onclick="showAuthForm('owner')">사장 로그인/회원가입</button>
                  </div>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
              </div>
          </div>
      </div>
  </div>

  <!-- 자바스크립트 -->
  <script>
      function showAuthForm(type) {
          var basePath = '${pageContext.request.contextPath}';
          if (type === 'member') {
              window.location.href = basePath + '/member/login_form.do'; // 회원 로그인 폼으로 이동
          } else if (type === 'owner') {
              window.location.href = basePath + '/owner/login_form.do'; // 사장 로그인 폼으로 이동
          }
      }
  </script>


          <!-- <%--
          <li class="nav-item dropdown pe-3">
            <c:choose>
              <c:when test="${sessionScope.user}">
                <!-- 로그인 상태 -->
                <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                  <span class="d-none d-md-block dropdown-toggle ps-2"
                    >마이페이지</span
                  >
                </a>
                <ul
                  class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile"
                >
                  <li class="dropdown-header">
                    <h6>마이페이지</h6>
                    <span>User Role</span>
                  </li>
                  <li><hr class="dropdown-divider" /></li>
                  <li>
                    <a
                      class="dropdown-item d-flex align-items-center"
                      href="users-profile.html"
                      ><i class="bi bi-person"></i><span>My Profile</span></a
                    >
                  </li>
                  <li><hr class="dropdown-divider" /></li>
                  <li>
                    <a
                      class="dropdown-item d-flex align-items-center"
                      href="users-profile.html"
                      ><i class="bi bi-gear"></i
                      ><span>Account Settings</span></a
                    >
                  </li>
                  <li><hr class="dropdown-divider" /></li>
                  <li>
                    <a
                      class="dropdown-item d-flex align-items-center"
                      href="pages-faq.html"
                      ><i class="bi bi-question-circle"></i
                      ><span>Need Help?</span></a
                    >
                  </li>
                  <li><hr class="dropdown-divider" /></li>
                  <li>
                    <a
                      class="dropdown-item d-flex align-items-center"
                      href="logout.do"
                      ><i class="bi bi-box-arrow-right"></i
                      ><span>Sign Out</span></a
                    >
                  </li>
                </ul>
              </c:when>
              <c:otherwise>
                <!-- 로그인되지 않은 상태 -->
                <button
                  type="button"
                  class="btn btn-primary"
                  onclick="location.href='insert_form.do'"
                >
                  회원가입
                </button>
                <button
                  type="button"
                  class="btn btn-secondary"
                  onclick="location.href='login_form.do'"
                >
                  로그인
                </button>
              </c:otherwise>
            </c:choose>
          </li>
          --%> -->
        </ul>
      </nav>
    </header>
  </body>
</html>
