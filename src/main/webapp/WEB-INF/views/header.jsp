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
    /* background-color: #F0A8D0; */
    padding: 8px 15px;
    /* border-radius: 5px; */
    /* color: black; */
    /* text-decoration: none; */
    /* border: none; */
    margin-left: 10px; /* Space between the welcome text and button */
}
header .insert {
    /* background-color: #F0A8D0; */
    /* padding: 8px 15px; */
    /* border-radius: 5px; */
    /* color: black; */
    /* text-decoration: none; */
    /* border: none; */
    margin-left: 10px; /* Space between the welcome text and button */
}
header .logout{
  /* background-color: #F0A8D0; */
  /* padding: 8px 15px; */
  /* border-radius: 5px; */
  /* color: black; */
  /* text-decoration: none; */
  /* border: none; */
  margin-left:10px;
}
.button_style {
  background-color: #f0a8d0;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  padding: 10px 15px;
} 

.button_style:hover {
  background-color: #e090b5;
}
</style>
<script>
  $(document).ready(function() {
    if ('${sessionScope.user}' === '' || '${sessionScope.user}' === 'null') {
      $("#logOut").click(); // Trigger logout if user is not logged in
    }
  });
  </script>
<script>
//   window.onload = function() {
//   // Check if this script has been executed before in the current session
//   if (!sessionStorage.getItem('logoutChecked')) {
//     var user = '${sessionScope.user}';
//     if (!user || user === 'null') {
//       sessionStorage.setItm('logoutChecked', 'false');
//         window.location.href = '/logout.do';  // Redirect to logout or login page
//     }
//     // Set the flag so this check won't run again in this session
//     sessionStorage.setItem('logoutChecked', 'true');
//   }
// };
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
              <a href="/admin/member_list.do" style="text-decoration: none; color: inherit;">
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
              <span>${sessionScope.user.member_name}님 안녕하세요👋
                  <input class="button_style" type="button" value="마이페이지" onclick="location.href='/member/mypage.do'"/>
                  <input class="button_style" type="button" id="logOut" value="로그아웃" onclick="location.href='/logout.do'"/>
                </span>
            </c:when>
            <c:when test="${sessionScope.userType == 'OWNER'}">
              <span>${sessionScope.user.owner_name}님 안녕하세요👋
                  <!-- <input class="button_style" type="button" value="관리페이지" onclick="location.href='/owner/ownerpage.do'"> -->
                  <input class="button_style" type="button" id="logOut" value="로그아웃" onclick="location.href='/logout.do'"/>
              </span>
            </c:when>
            <c:when test="${sessionScope.userType == 'ADMIN'}">
              <span>${sessionScope.user.admin_accountId}님 안녕하세요👋
                <!-- <input class="button_style" type="button" value="가맹점관리페이지" onclick="location.href='/admin/member_list.do'"> -->
                <input class="button_style" type="button" id="logOut" value="로그아웃" onclick="location.href='/logout.do'"/>

              </span>
            </c:when>

          </c:choose>
        </c:when>
        <c:otherwise>
          <div class="login-section">
            <input class="button_style" type="button" value="로그인" 
            onclick="location.href='/login_form.do'"/>
            <input class="button_style" type="button" value="회원가입" 
            onclick="location.href='/insert_form.do'"/>
          </div>
        </c:otherwise>
      </c:choose>
    </header>
</body>
</html>

