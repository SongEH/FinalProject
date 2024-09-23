<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<style>
.search-bar {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 0;
  background-image: url('../resources/images/배경이미지.jpeg'); /* Replace with the actual image path */
  background-size: cover; /* Ensures the image covers the entire background */
  background-position: center; /* Centers the image */
  padding: 10px; /* Adds padding around the search input and button */
}
.navbar-nav .nav-link {
    transition: background-color 0.3s; /* Smooth transition */
}

.navbar-nav .nav-link:hover {
    background-color: #F7B5CA; /* Change this to your desired color */
    cursor: pointer; /* Change cursor to pointer */
}
.nav-link.active {
    background-color: #F7B5CA; /* Example background color */
    color: white; /* Example text color */
}
</style>
<script>
    function shopLis(element){
      var food_category = element.getAttribute('food_category');
      alert(food_category);
      let order_addr = $("#order_addr").val().trim();
      if(order_addr==null || order_addr==""){
        alert("주소를 입력하시거나 로그인 후 이용할 수 있습니다.")
        return;
      }
      alert(order_addr);
      // var activeCategory = food_category;
      // alert(activeCategory);

      $.ajax({
      url     :     "../shop/food_list.do",
      data    :      {"food_category": food_category,
                      "order_addr": order_addr,
                      },
      success :   function(res_data){
              $("#store_list").hide();
              $("#select_one_display").hide();
              $("#store_list_display").hide();
              $("#select_list_category_display").html(res_data).show();
              // $("#sort_display").html(res_data);
              $(".nav-link").removeClass("active");
              $("#" + food_category).addClass("active");
      },
      error   :   function(err){
      alert(error.responseText)
      }
      });
      }
      // location.href="../shop/list.do?food_category=" + food_category + "&order_addr=" + order_addr;
</script>
<html lang="ko">
  <body>
    <c:set var="activeCategory" value="${param.activeCategory}" />
    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-10" id="nav">
      <div class="container">
       <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item" >
              <a class="nav-link" id="all" aria-current="page" food_category="all" onclick="shopLis(this)">전체보기</a>
            </li>
            <li class="nav-item">
              <!-- <a class="nav-link" href="list.do?food_category=pork_trotters">족발·보쌈</a> -->
              <a class="nav-link" id="pork_trotters" food_category="pork_trotters" onclick="shopLis(this)">족발·보쌈</a>
            </li>
            <li class="nav-item" >
              <a class="nav-link" id="pizza" food_category="pizza" onclick="shopLis(this)">피자</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="chicken" food_category="chicken" onclick="shopLis(this)">치킨</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="japanese_food" food_category="japanese_food" onclick="shopLis(this)">돈까스·회·일식</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="korea_food" food_category="korea_food" onclick="shopLis(this)">한식</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="chinese_food" food_category="chinese_food" onclick="shopLis(this)">중식</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="asian_food" food_category="asian_food" onclick="shopLis(this)">아시안</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="porridge_noodle" food_category="porridge_noodle" onclick="shopLis(this)">백반·죽·국수</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="snack_food" food_category="snack_food" onclick="shopLis(this)">분식</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="desserts" food_category="desserts" onclick="shopLis(this)">카페·디저트</a> 
            </li>
            <li class="nav-item">
              <a class="nav-link" id="fast_food" food_category="fast_food" onclick="shopLis(this)">패스트푸드</a>
            </li>
          </ul>
          <form class="d-flex">
            <input class="form-control" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success" type="button" value="Search"></button>
          </form>
        </div>
      </div>
    </nav>
    

</body>
</html>
