<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review List</title>
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
        .mySlides {
            margin-left: 5px;
        }
        .mySlides img {
            width: 500px;
            height: 300px;
        }
        .slideshow-container {
            position: relative;
            max-width: 500px;
            margin: auto;
            margin-left: 5px;
        }
        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: white;
            font-weight: bold;
            font-size: 18px;
            border-radius: 0 3px 3px 0;
            user-select: none;
        }
        .next {
            right: 0;
            border-radius: 3px 0 0 3px;
        }
        .prev:hover, .next:hover {
            background-color: rgba(0,0,0,0.8);
        }
        .btn-delete {
            margin-left: auto;
        }
    </style>
    <script>
        function reviews_del(reviews_id){
            $.ajax({
            url     :     "delete.do",
            data    :      {"reviews_id": reviews_id},
            success :   function(res_data){
                alert("성공");
            },
               
            error   :   function(err){
            alert(error.responseText)
            }
            });
            }
    </script>
    <script>
        let slideIndex = 1;
        showSlides();

        function showSlides() {
            let i;
            let slides = document.getElementsByClassName("mySlides");
            let containers = document.getElementsByClassName("slideshow-container");
            for (i = 0; i < containers.length; i++) {
                let containerSlides = containers[i].getElementsByClassName("mySlides");
                for (let j = 0; j < containerSlides.length; j++) {
                    containerSlides[j].style.display = "none";  
                }
                slideIndex++;
                if (slideIndex > containerSlides.length) {slideIndex = 1}    
                containerSlides[slideIndex-1].style.display = "block";  
            }
            setTimeout(showSlides, 3000); // Change image every 2 seconds
        }

        function plusSlides(n) {
            slideIndex += n;
            showSlides();
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
                                    <div class="col-md-12">
                                        <div class="reviews-item d-flex flex-column">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h4>${vo.shop_name}</h4>
                                                <button class="btn btn-danger btn-sm btn-delete" onclick="reviews_del('${vo.reviews_id}')">Delete</button>
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
                                            <div class="slideshow-container" id="slideshow-${vo.reviews_id}">
                                                <c:forEach var="img" items="${vo.reviews_img_list}">
                                                    <div class="mySlides">
                                                        <img src="${pageContext.request.contextPath}/resources/images/${img.reviews_img}" alt="Review Image" />
                                                    </div>
                                                </c:forEach>
                                                <!-- <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                                                <a class="next" onclick="plusSlides(1)">&#10095;</a> -->
                                            </div>
                                            <div class="mt-3">
                                                <div>${vo.orders_name}</div>
                                                <fmt:formatNumber value="${vo.orders_price}" type="number" patten="#,###" />
                                            </div>
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
