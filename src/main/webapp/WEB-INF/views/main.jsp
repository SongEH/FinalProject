<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>메인 페이지</title>
    <style>
      /* 스타일을 적절히 수정하여 드롭다운 메뉴를 디자인하세요 */
      .dropdown {
        position: relative;
        display: inline-block;
      }

      .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
        z-index: 1;
      }

      .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
      }

      .dropdown-content a:hover {
        background-color: #f1f1f1;
      }

      .dropdown:hover .dropdown-content {
        display: block;
      }

      .dropdown:hover .dropbtn {
        background-color: #3e8e41;
      }
    </style>
  </head>
  <body>
    <h1>메인 페이지</h1>

    <%-- 로그인 여부 체크 --%> <% Boolean isLoggedIn = (Boolean)
    session.getAttribute("isLoggedIn"); %> <%-- 로그인 상태일 때만 드롭다운
    메뉴를 표시 --%> <% if (isLoggedIn != null && isLoggedIn) { %>
    <div class="dropdown">
      <button class="dropbtn">회원 기능</button>
      <div class="dropdown-content">
        <a href="mypage.do">회원정보</a>
        <a href="mypage/payment_info.do">결제정보</a>
        <a href="mypage/address_info.do">주소정보</a>
        <a href="mypage/cart.do">장바구니</a>
        <a href="mypage/order_history.do">주문내역</a>
      </div>
    </div>
    <a href="logout.do">로그아웃</a>
    <% } else { %>
    <p>로그인 후 이용할 수 있는 기능입니다.</p>
    <a href="login_form.do">로그인</a>
    <% } %>
  </body>
</html>
