<%@ page language='java' contentType='text/html; charset=UTF-8'
pageEncoding='UTF-8'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN''http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<title>Insert title here</title>
<style>
  .shop_info p{
      color: #FFC6C6;
      display: inline-block;
  }
</style>
</head>

<body>
  <div class="shop_info">
      <br>
    <div>📢 <strong>사장님 알림</strong> </div>
      <hr>
    <div>${vo.shop_content}</div>
      <br>
      <br>
    <div>🏪 <strong>업체 정보</strong></div>
      <hr>
    <div><span><p>영업시간</p> 
      &nbsp;&nbsp;&nbsp; ${fn:substring(vo.shop_open_hour, 0, 5)}&nbsp;~&nbsp;${fn:substring(vo.shop_close_hour, 0, 5)}</span></div>
    <div><span><p>전화번호</p> &nbsp;&nbsp;&nbsp; ${vo.shop_call}</span></div>
    <div><span><p>주소</p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      ${vo.shop_addr}</span></div>
      <br>
      <br>
    <div>💳<strong>결제 정보</strong></div>
      <hr>
    <div><span><p>최소주문금액</p> &nbsp;&nbsp;&nbsp; ${vo.shop_min_price}</span></div>
    <div><span><p>결제수단</p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    요기서결제</span></div>
      <br>
      <br>
    <div>📇<strong>사업자정보</strong></div>
      <hr>
    <div><span><p>상호명</p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      ${vo.shop_name}</span></div>
    <div><span><p>사업자등록번호</p> &nbsp;&nbsp;&nbsp; ${vo.owner_license}</span></div>
    <br>
    <br>
  </div>
  
</body>
</html>