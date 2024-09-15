<%@ page language='java' contentType='text/html; charset=UTF-8'
pageEncoding='UTF-8'%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN''http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
    <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<title>Insert title here</title>

<body>
    <%@include file="../common.jsp" %>

    <!-- header import -->
    <%@include file="../header.jsp" %>

    <!-- side bar import -->
    <%@include file="../sidebar.jsp" %>


        <main id="main" class="main">
        <div class="pagetitle">

            <h1>Form Layouts</h1>

            <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item">Forms</li>
                <li class="breadcrumb-item active">Layouts</li>
            </ol>
            </nav>

            <section class="section">
                <div class="row">
                <div class="col-lg-10">
                    <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Floating labels Form</h5>

                        <!-- Floating Labels Form -->
                        <form class="row g-3" method="POST" action="insert.do" enctype="multipart/form-data">
                        <input type="hidden" value="${vo.orders_id}" />
                        <div class="col-md-12">
                            <div class="form-floating">
                                <div class="reviews_item" style="border: 1px solid gray; height: 120px; display: flex; align-items: center; padding: 10px;">
                                    <div>
                                        <!-- <input type="hidden" value="${vo.reviews_id}"/> -->
                                        <div>${vo.shop_name}</div>
                                        <div>
                                            ${vo.reviews_rating}
                                            <!-- <span><input type="button" value="삭제" onclick="reviews_del('${vo.reviews_id}');"/></span>  -->
                                        </div>
                                        <div>${vo.reviews_content}</div>
                                            <c:forEach var="img" items="${vo.reviews_img_list}">
                                                <img src="${pageContext.request.contextPath }/resources/images/${img.reviews_img}"/>
                                            </c:forEach>
                                        <div><strong>${item.menu_price}</strong></div>
                                    </div>
                                    <img src="${pageContext.request.contextPath }/resources/images/${item.menu_img}" alt="menu_image" style="margin-left:auto;">
                                </div>
                            </div>
                        </div>
</body>
</html>