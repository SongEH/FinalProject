<%@ page language='java' contentType='text/html; charset=UTF-8'
pageEncoding='UTF-8'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.reviews-item {
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 15px;
  margin-top: 20px;
  background-color: #f9f9f9;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.reviews-item .stars {
  color: gold;
}
.reviews-item .star-empty {
  color: #ddd;
}
  .ceoreview_display{
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 15px;
  margin-top: 20px;
  background-color: lightgray;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.slideshow-container {
  display: flex;
  max-width: 500px;
  margin: auto;
  margin-left: 5px;
}
.mySlides { 
width: 100%;
/* flex: 0 0 auto; */
  /* position: relative; */
}
/* Default size */
.first-slide-1 img {
  width: 300px;
  height: 200px;
  border: 1px solid black;
  margin-left: 0;
}
.second-slide-1 img {
  width: 300px;
  height: 200px;
  border: 1px solid black;
}
.second-slide-2 img {
  width: 300px;
  height: 200px;
  border: 1px solid black;
  margin-left: 10px;
}
.btn-delete {
  margin-left: auto;
}
</style>
</head>
<body>
<div class="container">
  <!-- <c:if test="${empty list}">
      <p>No reviews available.</p>
  </c:if> -->
  <c:forEach var="reviews" items="${list}">
    <div class="col-md-12">
      <div class="reviews-item d-flex flex-column">
        <div class="d-flex justify-content-between align-items-center">
          <h4>${reviews.member_name} &nbsp;&nbsp; ${reviews.reviews_cdate}</h4>
          <!-- <button class="btn btn-danger btn-sm btn-delete" onclick="reviews_del('${reviews.reviews_id}')">Delete</button> -->
        </div>
        <div class="stars">
          <c:forEach begin="1" end="${reviews.reviews_rating}">
            <i class="fa fa-star"></i>
          </c:forEach>
          <c:forEach begin="1" end="${5 - reviews.reviews_rating}">
            <i class="fa fa-star star-empty"></i>
          </c:forEach>
        </div>
        <div class="slideshow-container" id="slideshow-${reviews.reviews_id}">
          <c:if test="${not empty reviews.reviews_img_list }">
            <c:set var="imageCount" value="${fn:length(reviews.reviews_img_list)}" />
            <c:if test="${imageCount == 2}">
              <c:forEach var="img" items="${reviews.reviews_img_list}" varStatus="status">
                <div class="mySlides second-slide-${status.index + 1}">
                  <img src="${pageContext.request.contextPath}/resources/images/${img.reviews_img}" />
                </div>
              </c:forEach>
            </c:if>
            <c:if test="${imageCount == 1}">
              <c:forEach var="img" items="${reviews.reviews_img_list}" varStatus="status">
                <div class="mySlides first-slide-${status.index + 1}">
                  <img src="${pageContext.request.contextPath}/resources/images/${img.reviews_img}" />
                </div>
              </c:forEach>
            </c:if>
          </c:if>
        </div>
        <div class="mt-3">
          <div>${reviews.orders_name}</div>
          <div>${reviews.reviews_content}</div>
        </div>
        <c:choose>
          <c:when test="${reviews.hasCeoReview}">
            <div>
              <div class="row">
                <div class="col-lg-12">
                  <div class="ceoreview_display">
                    <div>⮑ 사장님 (${reviews.ceoreviews_cdate})</div>
                    <div style="margin-top: 3px;">${reviews.ceoreviews_content}</div>
                  </div>
                </div>
              </div>
            </div>
          </c:when>
          <c:otherwise>
          </c:otherwise> 
        </c:choose>
      </div>
    </div>
  </c:forEach>
</div>
</body>

</html>