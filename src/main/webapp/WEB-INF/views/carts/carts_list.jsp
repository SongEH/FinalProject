<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        .cart-summary {
            margin-top: 20px;
        }
    </style>
</head>


<body>

    <%@include file="../common.jsp" %>

    <%@include file="../header.jsp" %>

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

        </div><!-- End Page Title -->

        <section class="section">
            <div class="row align-items-top">
                <div class="col-lg-12">

                    <!-- Card with an image on left -->
                    <!-- 장바구니 항목 테이블 -->
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>가게명</th>
                                <th>이미지</th>
                                <th>메뉴명</th>
                                <th>메뉴개수</th>
                                <th>메뉴가격</th>
                                <th>추가일자</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="cartItems">
                            <c:forEach var="vo" items="${list}">
                                <tr>
                                    <td id="shop_name">${vo.shop_name}</td>
                                    <td id="cart_menuimg">
                                        <div>
                                            <img src="../resources/images/${vo.menu_img}"
                                                class="img-fluid rounded" alt="..." width="150px"></div>
                                    </td>
                                    <td id="cart_menuname">${vo.menu_name}</td>
                                    <td id="cart_quantity">${vo.carts_quantity}</td>
                                    <td id="cart_price">${vo.menu_price}</td>
                                    <td id="cart_cdate">${vo.carts_cdate}</td>
                                    <td id="cart_cdate">
                                        <input class="btn btn-info" type="button" id="btn_popup_update" value="수정"
                                            onclick="modify_menu('${vo.carts_id}');">
                                        <input class="btn btn-danger" type="button" id="btn_popup_delete" value="삭제"
                                            onclick="delete_menu('${vo.carts_id}');">
                                    </td>
                                </tr>

                            </c:forEach>
                        </tbody>
                    </table>

                </div>
            </div>

        </section>
</body>

</html>