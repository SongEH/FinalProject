<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">
    <div class="d-flex align-items-center justify-content-between">
      <a href="/shop/list.do" class="logo d-flex align-items-center">
        <img src="../resources/assets/img/logo.png" alt="" />
        <span class="d-none d-lg-block">Logo</span>
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div>
    <!-- End Logo -->

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
    <!-- End Search Bar -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">
        <li class="nav-item d-block d-lg-none">
          <a class="nav-link nav-icon search-bar-toggle" href="#">
            <i class="bi bi-search"></i>
          </a>
        </li>
        <!-- End Search Icon-->
        <c:if test="${empty sessionScope.user}">
          <li class="nav-item dropdown">
            <a href="/login_form.do"><button>Login</button></a>
            <a href="/insert_form.do"><button>Insert</button></a>
          </li>
        </c:if>

        <c:if test="${not empty sessionScope.user}">
          <li class="nav-item dropdown pe-3">
            <a
              class="nav-link nav-profile d-flex align-items-center pe-0"
              href="#"
              data-bs-toggle="dropdown"
            >
              <img
                src="../resources/assets/img/profile-img.jpg"
                alt="Profile"
                class="rounded-circle"
              />
              <span class="d-none d-md-block dropdown-toggle ps-2"
                >K. Anderson</span
              > </a
            ><!-- End Profile Iamge Icon -->

            <ul
              class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile"
            >
              <li class="dropdown-header">
                <h6>Kevin Anderson</h6>
                <span>Web Designer</span>
              </li>
              <li>
                <hr class="dropdown-divider" />
              </li>
              <li>
                <a
                  class="dropdown-item d-flex align-items-center"
                  href="/logout.do"
                >
                  <i class="bi bi-box-arrow-right"></i>
                  <span> Logout</span>
                </a>
              </li>
            </ul>
          </li>
        </c:if>
      </ul>
    </nav>
    <!-- End Icons Navigation -->
  </header>
  <!-- End Header -->
</html>
