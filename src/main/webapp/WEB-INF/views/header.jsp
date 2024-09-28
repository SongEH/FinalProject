<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<style>
header {
    display: flex;
    justify-content: space-between; /* Align logo to the left and login to the right */
    align-items: center; /* Vertically center the items */
    padding: 10px; /* Optional: Add some padding */
    background-color: #FFC6C6;
}

header .logo {
    text-align: left;
    font-size: 24px; /* Optional: Adjust logo size */
}

header .login-section {
    display: flex;
    align-items: center;
}


header .login, .insert {
    background-color: #F0A8D0;
    padding: 8px 15px;
    border-radius: 5px;
    color: black;
    text-decoration: none;
    border: none;
    margin-left: 10px; /* Space between the welcome text and button */
}
header .insert {
    background-color: #F0A8D0;
    padding: 8px 15px;
    border-radius: 5px;
    color: black;
    text-decoration: none;
    border: none;
    margin-left: 10px; /* Space between the welcome text and button */
}
header .logout{
  background-color: #F0A8D0;
  padding: 8px 15px;
  border-radius: 5px;
  color: black;
  text-decoration: none;
  border: none;
  margin-left:10px;
}
</style>
<script>
  window.onload = function() {
            // Check if this script has been executed before in the current session
            if (!sessionStorage.getItem('logoutChecked')) {
                var user = '${sessionScope.user}';
                if (!user || user === 'null') {
                  sessionStorage.setItm('logoutChecked', 'false');
                    window.location.href = '/logout.do';  // Redirect to logout or login page
                }
                // Set the flag so this check won't run again in this session
                sessionStorage.setItem('logoutChecked', 'true');
            }
        };
</script>
<html lang="ko">
  <body>
    <header class="header fixed-top d-flex align-items-center">
      <c:choose>
        <c:when test="${not empty sessionScope.userType}">
          <c:choose>
            <c:when test="${sessionScope.userType == 'MEMBER'}">
              <a href="/main/display.do" style="text-decoration: none;
              color: inherit; ">
              <div class="logo" style="text-align:left;">한입만</div>
              </a>
            </c:when>
            <c:when test="${sessionScope.userType == 'OWNER'}">
              <a href="/order/accept.do" style="text-decoration: none;
              color: inherit; ">
                <div class="logo" style="text-align:left;">한입만</div>
              </a>
            </c:when>
            <c:when test="${sessionScope.userType == 'ADMIN'}">
              <a href="/admin/dashboard.do" style="text-decoration: none; color: inherit;">
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
        <c:when test="${not empty sessionScope.userType}">
          <c:choose>
            <c:when test="${sessionScope.userType == 'MEMBER'}">
              <span>Welcome ${sessionScope.user.member_name}님 안녕하세요.
                  <input class="login" type="button" value="My Page" onclick="location.href='../member/mypage.do'"/>
                  <input class="logout" type="button" value="logOut" onclick="location.href='../logout.do'"/>
                </span>
            </c:when>
            <c:when test="${sessionScope.userType == 'OWNER'}">
              <span>Welcome ${sessionScope.user.owner_name}님
                  <input class="login" type="button" value="Owner Dashboard" onclick="location.href='../owner/ownerpage.do'">
                  <input class="logout" type="button" value="logOut" onclick="location.href='../logout.do'"/>
              </span>
            </c:when>
            <c:when test="${sessionScope.userType == 'ADMIN'}">
              <span>Welcome ${sessionScope.user.admin_accountId}님
                <input class="login" type="button" value="Admin Dashboard" onclick="location.href='../admin/member_list.do'">
                <input class="logout" type="button" value="logOut" onclick="location.href='../logout.do'"/>
              </span>
            </c:when>

          </c:choose>
        </c:when>
        <c:otherwise>
          <div class="login-section">
            <input class="login" type="button" value="로그인" 
            onclick="location.href='/login_form.do'"/>
            <input class="insert" type="button" value="회원가입" 
            onclick="location.href='/insert_form.do'"/>
          </div>
        </c:otherwise>
      </c:choose>
    </header>
</body>
</html>
