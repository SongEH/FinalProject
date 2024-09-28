<%@ page language='java' contentType='text/html; charset=UTF-8'
pageEncoding='UTF-8'%>
<!DOCTYPE html>
<html>
<head>
<style>
.creator{
  width: 20%;
}
.footer{
  padding-bottom: 65px;
  font-size: 12px;
  color: #999;
  /* box-sizing: border-box; */
  width: 100%;
}

.footer-menu ul {
  display: flex;
  justify-content: space-around; /* Or use `space-between` or `center` */
  padding: 0;
  margin: 0;
  list-style: none;
}

.footer-menu ul li {
  display: flex;
  justify-content: center; /* Horizontally centers the <a> */
  align-items: center;     /* Vertically centers the <a> */
  height: 50px;            /* Set a height if needed for vertical centering */
  margin-right: 20px;      /* Adjust for spacing between items */
}

.footer-menu ul li:last-child {
  margin-right: 0;
}

.footer-menu ul li a {
  text-align: center; /* To make sure text inside the <a> is centered */
  display: block;     /* Ensure the <a> behaves like a block for easier centering */
  color: black;
  text-decoration: none;
}

  </style>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> -->
<title>Insert title here</title>
</head>
<body>
   <!-- ======= Footer ======= -->
   <footer id="footer" class="footer">
      <div class="footer">
        <div class="footer-menu" style="border-top: 1px solid gray; border-bottom: 1px solid gray;">
          <ul>
            <li class="mb" ng-show="!is_mobile_device">
              <a href="#/policy/">이용약관</a>
            </li>
            <li class="mb privacy-txt" ng-show="!is_mobile_device">
              <a href="#/privacy/">개인정보처리방침</a>
            </li>
            <li class="mb cscenter" ng-show="!is_mobile_device">
              <a href="#/point_policy/">포인트정책</a>
            </li>
            <li class="mb ng-hide" ng-show="is_mobile_device">
              <a ng-bind="check_login() ? '로그아웃' : '로그인'" ng-click="login()" class="ng-binding">로그인</a>
            </li>
            <li class="mb cscenter ng-hide" ng-show="is_mobile_device">
              <a href="#/contact/">고객만족센터</a>
            </li>
            <li class="mb">
              <a href="https://www.wesang.com/" rel="noopener noreferrer" target="_blank">회사소개</a>
            </li>
            <li>
              <a href="https://www.yogiyo.co.kr/owner/login/" target="_blank">요기요사장님</a>
            </li>
            <li class="mb lst">
              <a href="https://owner.yogiyo.co.kr/owner/join/request/">입점문의</a>
            </li>
            <li class="mb down_app ng-hide" ng-show="is_mobile_device">
              <a href="" ng-click="download_app('footer')" class="app">APP설치</a>
            </li>
            <li class="mb notice">
              <a href="#/notice/">공지사항</a>
            </li>
            <li class="mb faq">
              <a href="#/faq/">FAQ</a>
            </li>
            <li class="sns-link">
              <a href="https://www.facebook.com/Yogiyokorea/" class="facebook" rel="noopener noreferrer" target="_blank"><span></span>페이스북</a>
              <a href="https://blog.naver.com/rgpkorea" class="blog" rel="noopener noreferrer" target="_blank"><span></span>블로그</a>
            </li>
          </ul>
        </div>  <!-- foot_menu_list end -->

        <div class="row" style="margin-top: 30px;">
          <div class="col-lg-2 col-md-2" style="width:20%">
            <div class="card" style="width:100%">
              <img class="card-img-top" src="../bootstrap4/img_avatar1.png" alt="Card image" style="width:100%">
              <div class="card-body">
                <h4 class="card-title">김수만</h4>
                <a href="#" class="btn btn-primary">See Profile</a>
              </div>
            </div>
          </div>
          <div class="col-lg-2 col-md-2" style="width:20%">
            <div class="card" style="width:100%">
              <img class="card-img-top" src="../bootstrap4/img_avatar1.png" alt="Card image" style="width:100%">
              <div class="card-body">
                <h4 class="card-title">송은호</h4>
                <a href="#" class="btn btn-primary">See Profile</a>
              </div>
            </div>
          </div>
          <div class="col-lg-2 col-md-2" style="width:20%">
            <div class="card" style="width:100%">
              <img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/천태광.png" alt="Card image" style="width:100%; padding: 0;border-radius: 10px;">
              <div class="card-body">
                <h4 class="card-title">천태광</h4>
                <a href="#" class="btn btn-primary">See Profile</a>
              </div>
            </div>
          </div>
          <div class="col-lg-2 col-md-2" style="width:20%">
            <div class="card" style="width:100%">
              <img class="card-img-top" src="../bootstrap4/img_avatar1.png" alt="Card image" style="width:100%">
              <div class="card-body">
                <h4 class="card-title">한지혜</h4>
                <a href="#" class="btn btn-primary">See Profile</a>
              </div>
            </div>
          </div>
          <div class="col-lg-2 col-md-2" style="width:20%">
            <div class="card" style="width:100%">
              <img class="card-img-top" src="../bootstrap4/img_avatar1.png" alt="Card image" style="width:100%">
              <div class="card-body">
                <h4 class="card-title">손유정</h4>
                <a href="#" class="btn btn-primary">See Profile</a>
              </div>
            </div>
          </div>
        </div> row card end
        
        <!-- <div class="row" style="margin-top: 30px;">
          <div class="col-lg-2 col-md-2">
            <img src="" alt="로고 이미지 ">
          </div>
          <div class="col-lg-10 col-md-10">
            <div><strong>A Bite Project Team</strong></div>
            <div>주소 서울 관악구 남부순환로 1820 에그옐로우 14층</div>
          </div>
        </div> -->

        <div style="margin-top: 200px; align-items: end !important;;" >
          <P> Copyright <strong>2024 [Developer / A Bite project Team]. All right reserved. </strong></P>
        </div>
      </div>
  </footer>
  <!-- End Footer -->
</body>
</html>