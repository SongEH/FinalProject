<%@ page language='java' contentType='text/html; charset=UTF-8'
pageEncoding='UTF-8'%>
<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN''http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<title>Insert title here</title>
</head>

<body>
            <br>
        <div>📢 <strong>사장님 알림</strong> </div>
            <hr>
        <div>${vo.shop_content}</div>
            <br>
            <br>
        <div>🏪 <strong>업체 정보</strong></div>
            <hr>
        <div>영업시간 &nbsp;&nbsp;&nbsp; ${vo.shop_hours}</div>
        <div>전화번호 &nbsp;&nbsp;&nbsp; ${vo.shop_call}</div>
        <div>주소 &nbsp;&nbsp;&nbsp; ${vo.shop_addr}</div>
            <br>
            <br>
        <div>💳<strong>결제 정보</strong></div>
            <hr>
        <div>최소주문금액 &nbsp;&nbsp;&nbsp; ${vo.shop_min_price}</div>
        <div>결제수단 &nbsp;&nbsp;&nbsp; 요기서결제</div>
            <br>
            <br>
        <div>📇<strong>사업자정보</strong></div>
            <hr>
        <div>상호명 &nbsp;&nbsp;&nbsp; ${vo.shop_name}</div>
        <div>사업자등록번호 &nbsp;&nbsp;&nbsp; ${vo.owner_license}</div>

        
</body>
</html>