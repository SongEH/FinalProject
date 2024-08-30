<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니 목록</title>
    <style>
        .cart-summary {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="my-4">장바구니 목록</h1>

        <!-- 장바구니 항목 테이블 -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>메뉴명</th>
                    <th>메뉴개수</th>
                    <th>메뉴가격</th>
                </tr>
            </thead>
            <tbody id="cartItems">
                <!-- JavaScript로 여기에 장바구니 항목을 동적으로 추가할 수 있습니다. -->
                <!-- 예시 항목: -->
                <tr>
                    <td id="cart_menu_name_1">메뉴1</td>
                    <td id="cart_menu_quantity_1">2</td> 
                    <td id="cart_menu_price_1">₩10,000</td>
                </tr>
                <tr>
                    <td id="cart_menu_name_2">메뉴2</td>
                    <td id="cart_menu_quantity_2">1</td>
                    <td id="cart_menu_price_2">₩15,000</td>
                </tr>
                <tr>
                    <td id="cart_menu_name_3">메뉴3</td>
                    <td id="cart_menu_quantity_3">3</td>
                    <td id="cart_menu_price_3">₩20,000</td>
                </tr>
            </tbody>
        </table>

        <!-- 장바구니 요약 -->
        <div class="cart-summary">
            <h4>장바구니 요약</h4>
            <p><strong>총 메뉴 개수:</strong> <span id="totalQuantity">6</span></p>
            <p><strong>총 가격:</strong> <span id="totalPrice">₩45,000</span></p>
        </div>
    </div>
</body>
</html>
