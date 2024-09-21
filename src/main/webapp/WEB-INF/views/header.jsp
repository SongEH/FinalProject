<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<style>
.header {
  background-color: #f0a8d0;
  color: black;
  padding: 20px;
}

.header h1 {
  text-align: left;
}

.container{
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0;
}
</style>
<html lang="ko">
  <body>
    <header class="header">
      <div class="container">
        <a href="/main/display.do" style="text-decoration: none;
        color: inherit; ">
        <h1 style="text-align:left;">한입만</h1>
        </a>
        <c:choose>
          <c:when test="${not empty sessionScope.user}">
            <div>
              <span>Welcome, 유저네임</span>
              <input type="button" value="my page" onclick="location.href='../main.do'">
            </div>
          </c:when>
        </c:choose>
        <c:if test="${empty sessionScope.user}">
          <input type="button" value="login" 
          onclick="location.href='../member/login.do'"/>
        </c:if>
      </div>
    </header>
</body>
</html>
