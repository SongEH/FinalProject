<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<style>
header {
    display: flex;
    justify-content: space-between; /* Align logo to the left and login to the right */
    align-items: center; /* Vertically center the items */
    padding: 10px; /* Optional: Add some padding */
    background-color: #F0A8D0;
}

header .logo {
    text-align: left;
    font-size: 24px; /* Optional: Adjust logo size */
}

header .login-section {
    display: flex;
    align-items: center;
}

header .login ,.insert {
    background-color: orange;
    padding: 8px 15px;
    border-radius: 5px;
    color: white;
    text-decoration: none;
    border: none;
    margin-left: 10px; /* Space between the welcome text and button */
}

</style>
<html lang="ko">
  <body>
    <header class="header">
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <c:choose>
            <c:when test="${sessionScope.user.member_name !=null}">
              <a href="/main/display.do" style="text-decoration: none;
              color: inherit; ">
              <div class="logo" style="text-align:left;">한입만</div>
              </a>
            </c:when>
            <c:when test="${sessionScope.user.owner_name !=null}">
              <a href="/order/accept.do" style="text-decoration: none;
              color: inherit; ">
              <div class="logo" style="text-align:left;">한입만</div>
              </a>
            </c:when>
          </c:choose>
        </c:when>
        <c:otherwise>
          <a href="/main/display.do" style="text-decoration: none;
          color: inherit; ">
          <div class="logo" style="text-align:left;">한입만</div>
          </a>
        </c:otherwise>

      </c:choose>

      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <c:choose>
              <c:when test="${sessionScope.user.member_name !=null}">
                  <span>Welcome ${sessionScope.user.member_name}님</span>
                  <input class="login" type="button" value="My Page" onclick="location.href='/member/mypage.do'">
              </c:when>
              <c:when test="${sessionScope.user.owner_name !=null}">
                  <span>Welcome ${sessionScope.user.owner_name}님</span>
                  <input class="login" type="button" value="Owner Dashboard" onclick="location.href='../owner/dashboard.do'">
              </c:when>
              
          </c:choose>
        </c:when>
        <c:otherwise>
          <div class="login-section">
            <input class="login" type="button" value="login" 
            onclick="location.href='/login_form.do'"/>
            <input class="insert" type="button" value="insert" 
            onclick="location.href='/insert_form.do'"/>
          </div>
        </c:otherwise>
      </c:choose>
    </header>
</body>
</html>
