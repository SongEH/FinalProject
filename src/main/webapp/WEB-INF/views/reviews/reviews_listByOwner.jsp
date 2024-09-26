<%@ page language='java' contentType='text/html; charset=UTF-8'
pageEncoding='UTF-8'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script>
    $(document).ready(function() {
        // Toggle the display of the answer box when the button is clicked
        $('.btn-toggle-answer').click(function() {
            var reviewId = $(this).data('id');
            $('#answer-box-' + reviewId).toggle();  // Toggle the corresponding answer box
        });
    });
</script>
<script>
    function ceoReviewDel(ceoreviews_id){
        if(confirm("정말 삭제하시겠습니까?")==false) return;
        // alert(ceoreviews_id);
        $.ajax({
        url     :     "../ceoReview/delete.do",
        data    :      {"ceoreviews_id": ceoreviews_id},
        success :   function(res_data){
                    alert("삭제성공")
                    location.href="listByOwner.do";
        },
        error   :   function(err){
        alert(error.responseText)
        }
        });
    }

//     document.addEventListener("DOMContentLoaded", function() {
//     document.querySelectorAll('.slideshow-container').forEach(container => {
//         const slides = container.querySelectorAll('.mySlides');
//         const numSlides = slides.length;

//         if (numSlides === 1) {
//             container.classList.add('image-size-1');
//         } else if (numSlides === 2) {
//             container.classList.add('image-size-2');
//         } else if (numSlides === 3) {
//             container.classList.add('image-size-3');
//             slides[0].classList.add('image-size-3-first');
//             slides[1].classList.add('image-size-3-second');
//             slides[2].classList.add('image-size-3-third');
//         }
//     });
// });


</script>
<script>
function ceoWriteReview(f){
  let ceoreviews_content = f.ceoreviews_content.value.trim();
  // alert(f.ceoreviews_content.value);
  let owner_id = f.owner_id.value;
  // alert(f.owner_id.value);
  let reviews_id = f.reviews_id.value;
  // alert(f.reviews_id.value);

  $.ajax({
  url     :     "../ceoReview/insert.do",
  data    :      {"owner_id": owner_id,
                  "ceoreviews_content": ceoreviews_content,
                  "reviews_id": reviews_id},
  success :   function(res_data){
              location.href="listByOwner.do"
              // alert("ceoReview 성공 ")
  },
  error   :   function(err){
  alert(error.responseText)
  }
  });
}
</script>
</head>
<body>
  <div>
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
                <c:forEach var="reviews" items="${list}">
                  <div class="col-md-12">
                    <div class="reviews-item d-flex flex-column">
                      <div class="d-flex justify-content-between align-items-center">
                        <h4>${reviews.member_name} &nbsp;&nbsp; ${reviews.reviews_cdate}</h4>
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
                      <div>
                        <c:choose>
                          <c:when test="${reviews.hasCeoReview}">
                            <input type="button" value="답변" class="btn-toggle-answer" data-id="${reviews.reviews_id}" style="display: none;"/>
                            <div>
                              <div class="row">
                                <div class="col-lg-12">
                                  <div class="ceoreview_display">
                                    <div>⮑ 사장님 (${reviews.ceoreviews_cdate})</div>
                                    <c:if test="${sessionScope.user.owner_id == reviews.owner_id}">
                                      <input type="button" value="삭제" class="btn btn-danger" style="float: right;"
                                      onclick="ceoReviewDel('${reviews.ceoreviews_id}');"/>
                                    </c:if>
                                    <div style="margin-top: 3px;">${reviews.ceoreviews_content}</div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </c:when>
                          <c:otherwise>
                            <input type="button" value="답변" class="btn-toggle-answer" data-id="${reviews.reviews_id}"/>
                          </c:otherwise>    
                        </c:choose>
                      </div>
                      <!-- Hidden textarea for answer -->
                      <form method="POST">
                      <input type="hidden" name="reviews_id" value="${reviews.reviews_id}">
                      <input type="hidden" name="owner_id" value="${reviews.owner_id}">
                      <div id="answer-box-${reviews.reviews_id}" class="answer-box" style="display: none;">
                        <textarea class="form-control" name="ceoreviews_content" rows="3" placeholder="답변을 입력하세요"></textarea>
                          <input class="btn btn-primary mt-2" type="button"  value="답변달기" onclick="ceoWriteReview(this.form);">
                        <!-- <input type="button" value="답변달기" class="btn btn-primary mt-2" onclick="ceoWriteReview(this.form);"/> -->
                      </div>
                      </form>
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
  </div>
</body>
</html>


                    