<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
  <div class="container">
    <input type="hidden" id="order_addr" value="${order_addr}"/>
    <input type="hidden" id="food_category" value="${food_category}"/>
    <div class="store-list mt-10" id="store-list" >
      <c:forEach var="vo" items="${list}">
        <div class="store" onclick="selectOne('${vo.shop_id}');">
            <div class="store-left">
                <div class="store-logo">
                  <img src="${pageContext.request.contextPath }/resources/images/${vo.shop_img}" alt="Store 1 Logo">
                </div>
                <div class="store-info">
                    <strong>${vo.shop_name}</strong>
                    <div>
                        <span class="rating">★ ${vo.shop_rating}</span>
                        | 리뷰${vo.reviews_count} | 사장님댓글 ${vo.ceoreview_count}
                    </div>
                    <div>${vo.shop_min_price} 11,000원 이상 배달</div>
                    <div class="delivery-time">47~62분</div>
                </div>
            </div>
            <!-- <div class="coupon">2,000원 할인</div> -->
        </div>
      </c:forEach>
    </div>
  </div>
</body>
</html>
