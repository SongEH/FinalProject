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
  margin-top: 60px;
}

.search-bar input {
  width: 300px;
  height: 50px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
/* .search-bar button {
  background-color: #F7B5CA;
  color: black;
  border: none;
  padding: 10px 20px;
  margin-left: 10px;
  border-radius: 5px;
  cursor: pointer;
  height: 50px;
} */

.button_style {
  background-color: #f0a8d0;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  padding: 10px 15px;
  height: 50px;
  margin-left: 10px;
} 

.button_style:hover {
  background-color: #e090b5;
}

</style>
<html lang="ko">
  <body>
    <div class="search-bar" style="margin-top:60px;">
        <input type="text" id="order_addr" name="order_addr" placeholder="로그인 후 이용할 수 있습니다." value="${order_addr}" readonly>
        <button type="button" class="button_style" id="addressSearch" onclick="findAddr()">주소설정</button>
        <input type="hidden" id="order_addr_zipcode" name="order_addr_zipcode" value="${order_addr_zipcode}">
    </div>
</body>
</html>
