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
      <!-- 영업중인 가게  -->
      <c:forEach var="vo" items="${list}">
        <c:if test="${vo.status =='영업중'}">
          <div class="store" onclick="selectOne('${vo.shop_id}', '${vo.status}');">
            <div class="store-left">
              <div class="store-logo">
                <div class="image-container">
                  <!-- 가게 로고 이미지 -->
                  <img class="image-z2" src="${pageContext.request.contextPath}/resources/images/${vo.shop_img}" alt="Store 1 Logo">
                  <!-- 이미지 위에 표시할 텍스트 -->
                  <div class="overlay-text">Closed</div>
                </div>
              </div>
              <div class="store-info">
                <strong>${vo.shop_name}</strong>
                <div>
                  <span class="rating">★ ${vo.shop_rating}</span> 
                  | 리뷰 ${vo.reviews_count} | 사장님 댓글 ${vo.ceoreview_count}
                </div>
                <div>${vo.shop_min_price}원 이상 배달</div>
                <div class="delivery-time"></div>
              </div>
            </div>
          </div>
        </c:if>
      </c:forEach>
      <div>
        
      </div>
      <!-- 영업중이 아닌 가게 -->
      <c:forEach var="vo" items="${list}">
        <c:if test="${vo.status == '영업전' || vo.status=='휴무일'}">
          <div class="store" onclick="selectOne('${vo.shop_id}', '${vo.status}');">
            <img class="image-z1" src="${pageContext.request.contextPath}/resources/images/back_black.png">
          <c:if test="${vo.status == '영업전'}">
            <div class="text-over-image">가게 오픈 시간  ${fn:substring(vo.shop_open_hour, 0, 5)}</div>
          </c:if>
          <c:if test="${vo.status == '휴무일'}">
            <div class="text-over-image">금일은 휴무일입니다.</div>
          </c:if>
            <div class="store-left">
              <div class="store-logo">
                <div class="image-container">
                  <!-- 가게 로고 이미지 -->
                  <img class="image-z2" src="${pageContext.request.contextPath}/resources/images/${vo.shop_img}" alt="Store 1 Logo">
                  <!-- 이미지 위에 표시할 텍스트 -->
                  <div class="overlay-text">Closed</div>
                </div>
              </div>
              <div class="store-info">
                <strong>${vo.shop_name}</strong>
                <div>
                  <span class="rating">★ ${vo.shop_rating}</span> 
                  | 리뷰 ${vo.reviews_count} | 사장님 댓글 ${vo.ceoreview_count}
                </div>
                <div>${vo.shop_min_price}원 이상 배달</div>
                <div class="delivery-time"></div>
              </div>
            </div>
          </div>
        </c:if>
      </c:forEach>
    </div>
  </div>
</body>
</html>
