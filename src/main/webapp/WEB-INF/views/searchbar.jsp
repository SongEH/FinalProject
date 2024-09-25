<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<style>
.container{
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0;
}
.search-bar {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 0;
  background-color: rgba(0, 0, 0, 1); /* 50% dark overlay */
  background-image: url('../resources/images/배경이미지.png'); /* Replace with the actual image path */
  background-size: cover; /* Ensures the image covers the entire background */
  background-position: center; /* Centers the image */
  padding: 10px; /* Adds padding around the search input and button */
  height: 100px;
}


.search-bar input {
  width: 300px;
  height: 50px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
.search-bar button {
  background-color: #F7B5CA;
  color: black;
  border: none;
  padding: 10px 20px;
  margin-left: 10px;
  border-radius: 5px;
  cursor: pointer;
  height: 50px;
}
</style>
<html lang="ko">
  <body>
    <div class="search-bar" style="margin-top:0;">
        <input type="text" id="order_addr" name="order_addr" placeholder="주소 설정 또는 로그인 후 이용할 수 있습니다." value="${order_addr}" readonly>
        <button type="button" id="addressSearch" onclick="findAddr()">주소설정</button>
    </div>
</body>
</html>
