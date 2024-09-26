<%@ page language='java' contentType='text/html; charset=UTF-8'
pageEncoding='UTF-8'%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Review List</title>
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
  rel="stylesheet"
/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
/>
<style>
.reviews-item {
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 15px;
  margin-top: 20px;
  background-color: #f9f9f9;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
.reviews-item .stars {
  color: gold;
}
.reviews-item .star-empty {
  color: #ddd;
}
.ceoreview_display {
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 15px;
  margin-top: 20px;
  background-color: lightgray;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
/* Layout for three images */

.btn-delete {
  margin-left: auto;
}
</style>
<script>
  function reviews_del(reviews_id) {
    if (!confirm("해당 리뷰를 정말 삭제하시겠습니까?\n삭제 이후에는 댓글을 작성할 수 없습니다.")) return;

    $.ajax({
      url: "delete.do",
      data: { reviews_id: reviews_id },
      success: function (res_data) {
        // alert("성공");
        location.href = "list.do";
      },
      error: function (err) {
        alert(error.responseText);
      },
    });
  }

</script>
</head>

  <body>
    <%@ include file="../common.jsp" %> 
    <%@ include file="../header.jsp" %>
    <%@ include file="../sidebar.jsp" %>

    <main id="main" class="main">
      <div class="container">
        <div class="pagetitle">
          <h1>Reviews</h1>
          <nav>
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.html">Home</a></li>
              <li class="breadcrumb-item">Reviews</li>
            </ol>
          </nav>
        </div>

        <section class="section">
          <div class="row">
            <div class="col-lg-10">
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">Floating labels Form</h5>
                  <c:forEach var="vo" items="${list}">
                    <input type="hidden" value="${vo.shop_id}" />
                    <div class="col-md-12">
                      <div class="reviews-item d-flex flex-column">
                        <div
                          class="d-flex justify-content-between align-items-center"
                        >
                          <h5>${vo.shop_name}</h5>
                          <button
                            class="btn btn-danger btn-sm btn-delete"
                            onclick="reviews_del('${vo.reviews_id}')"
                          >
                            Delete
                          </button>
                        </div>
                        <div class="stars">
                          <c:forEach begin="1" end="${vo.reviews_rating}">
                            <i class="fa fa-star"></i>
                          </c:forEach>
                          <c:forEach begin="1" end="${5 - vo.reviews_rating}">
                            <i class="fa fa-star star-empty"></i>
                          </c:forEach>
                        </div>
                        <p class="mt-2">${vo.reviews_content}</p>
                        <div
                          class="slideshow-container"
                          id="slideshow-${vo.reviews_id}"
                        >
                          <c:if test="${not empty vo.reviews_img_list }">
                            <c:set
                              var="imageCount"
                              value="${fn:length(vo.reviews_img_list)}"
                            />
                            <c:if test="${imageCount == 2}">
                              <c:forEach
                                var="img"
                                items="${vo.reviews_img_list}"
                                varStatus="status"
                              >
                                <div
                                  class="mySlides second-slide-${status.index + 1}"
                                >
                                  <img
                                    src="${pageContext.request.contextPath}/resources/images/${img.reviews_img}"
                                  />
                                </div>
                              </c:forEach>
                            </c:if>
                            <c:if test="${imageCount ==1}">
                              <c:forEach
                                var="img"
                                items="${vo.reviews_img_list}"
                                varStatus="status"
                              >
                                <div
                                  class="mySlides first-slide-${status.index + 1}"
                                >
                                  <img
                                    src="${pageContext.request.contextPath}/resources/images/${img.reviews_img}"
                                  />
                                </div>
                              </c:forEach>
                            </c:if>
                          </c:if>
                        </div>

                        <div class="mt-3">
                          <div>주문한 메뉴 : ${vo.orders_name}</div>
                          <div>주문한 가격 : ${vo.orders_price}</div>
                        </div>
                        <c:choose>
                          <c:when test="${vo.hasCeoReview}">
                            <div class="row">
                              <div class="col-lg-12">
                                <div class="ceoreview_display">
                                  <div>
                                    <strong
                                      >⮑ 사장님 (${vo.ceoreviews_cdate})</strong
                                    >
                                  </div>
                                  <div style="margin-top: 3px">
                                    ${vo.ceoreviews_content}
                                  </div>
                                </div>
                              </div>
                            </div>
                          </c:when>
                          <c:otherwise> </c:otherwise>
                        </c:choose>
                      </div>
                    </div>
                  </c:forEach>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </main>
  </body>
</html>
