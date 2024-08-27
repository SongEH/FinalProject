<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>

            <!--  Bootstrap  3.x  -->
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 0;
                    padding: 0;
                    background-color: #f5f5f5;
                }

                .container {
                    display: flex;
                    justify-content: space-between;
                    padding: 20px;
                }

                .menu-section {
                    width: 70%;
                }

                .order-section {
                    width: 25%;
                    background-color: white;
                    padding: 15px;
                    border: 1px solid #ccc;
                }

                .menu-section img,
                .order-section img {
                    max-width: 100%;
                }

                .menu-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 20px;
                }

                .menu-header h1 {
                    margin: 0;
                    font-size: 24px;
                }

                .menu-header p {
                    margin: 0;
                    color: #999;
                }

                .menu-list {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 10px;
                }

                .menu-item {
                    width: 48%;
                    background-color: white;
                    border: 1px solid #ccc;
                    padding: 10px;
                    text-align: center;
                }

                .menu-item h3 {
                    margin: 10px 0;
                    font-size: 18px;
                }

                .order-summary {
                    background-color: white;
                    border: 1px solid #ccc;
                    padding: 15px;
                }

                .order-summary h2 {
                    margin-top: 0;
                }

                .order-summary ul {
                    list-style: none;
                    padding: 0;
                }

                .order-summary li {
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 10px;
                }

                .order-summary .total {
                    font-size: 18px;
                    font-weight: bold;
                }

                .order-button {
                    width: 100%;
                    padding: 10px;
                    background-color: #ff3366;
                    color: white;
                    border: none;
                    cursor: pointer;
                    font-size: 18px;
                    font-weight: bold;
                }


                #box {
                    width: 770px;
                    margin: auto;
                    margin-top: 30px;
                }

                #title {
                    text-align: center;
                    font-size: 32px;
                    font-weight: bold;
                    color: green;
                    text-shadow: 1px 1px 1px black;
                    margin-bottom: 50px;
                }

                #photo-box {

                    height: 470px;
                    border: 2px solid blue;
                    margin-top: 10px;

                    /* 상하스크롤 */
                    /* overflow-y: scroll; */
                }

                .photo {
                    width: 140px;
                    height: 180px;
                    border: 1px solid green;
                    margin: 25px;
                    padding: 10px;

                    box-shadow: 2px 2px 2px black;

                    float: left;
                }

                .photo:hover {
                    border-color: red;
                }

                .photo>img {
                    width: 120px;
                    height: 120px;
                    border: 1px solid gray;
                    outline: 1px solid black;
                }

                .title {
                    width: 120px;
                    border: 1px solid gray;
                    outline: 1px solid black;
                    padding: 5px;
                    margin-top: 5px;

                    /* ellipsis */
                    overflow: hidden;
                    white-space: nowrap;
                    text-overflow: ellipsis;
                    word-break: break-all;


                }
            </style>

            <script>
                function showPhoto(menu_id) {

                    //alert(p_idx + " 그림정보 조회");

                    $("#photoModal").modal({ backdrop: "static" });


                    // p_idx에 대한 사진정보 가져오기(Ajax이용 JSON형식)
                    $.ajax({
                        url: "menu_one.do",     //PhotoOneAction
                        data: { "menu_id": menu_id },   //parameter => photo_one.do?p_idx=5
                        dataType: "json",
                        success: function (res_data) {
                            // res_data = {"p_idx":5, "p_title":"제목" , "p_content":"내용" , "p_filename":"a.jpg",....}
                            console.log(res_data);

                            //download받을 화일명...
                            g_menu_img = res_data.menu_img;
                            g_menu_id = res_data.menu_id;


                            $("#pop_image").prop("src", "../resources/images/" + res_data.menu_img);

                            $("#pop_title").html(res_data.menu_name);
                            $("#pop_content").html(res_data.menu_content);
                            $("#pop_price").html(res_data.menu_price);
                            $("#pop_category").html(res_data.menu_category);
                            $("#pop_popularity").html(res_data.menu_popularity);
                            $("#pop_regdate").html(res_data.menu_cdate);

                            //버튼 보여지기 유/무
                            // $("#btn_popup_download").hide();//다운
                            // $("#btn_popup_update").hide();//수정
                            // $("#btn_popup_delete").hide();//삭제

                            //버튼숨기기 (구현하기@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@)
                            $("#btn_popup_update").show();//수정
                            $("#btn_popup_delete").show();//삭제

                            //로그인된 상태에는 다운로드 가능
                            if ("${ not empty user}" == "true") {
                                $("#btn_popup_download").show();
                            }

                            // 메뉴를 올린 사람이 가게 사장일 경우 -> 보이게한다. 
                            //alert("${ user.mem_idx }" == res_data.mem_idx);
                            if ("${ user.mem_idx }" == res_data.mem_idx) {

                                $("#btn_popup_update").show();//수정
                                $("#btn_popup_delete").show();//삭제
                            }

                        },
                        error: function (err) {
                            alert(err.responseText);
                        }
                    });
                }
            </script>
        </head>

        <body>
            <!-- popup:Modal -->
            <%@include file="popup.jsp" %>

                <div class="container">
                    <div class="menu-section">
                        <div class="menu-header">
                            <div>
                                <h1>가게이름</h1>
                                <p>최소주문금액 - 10000원</p>
                            </div>
                            <div>
                                <p>결제 - 신용카드, 현금, 간편결제</p>
                            </div>
                        </div>
                        <div id="photo-box">
                            <div class="menu-list">
                                <c:forEach var="vo" items="${list}">
                                    <!-- vo.menu_status가 1인 경우만 표시 -->
                                    <c:if test="${vo.menu_status == 1}">
                                        <div class="menu-item">
                                            <div class="photo" onclick="showPhoto('${vo.menu_id}');">
                                                <img src="../resources/images/${vo.menu_img}">
                                                <div class="title">(${vo.menu_id}) ${vo.menu_name}</div>
                                                <div class="title">${vo.menu_content}</div>
                                                <div class="title">${vo.menu_price}</div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <div class="order-section">
                        <div class="order-summary">
                            <h2>주문표</h2>
                            <ul>
                                <li>
                                    <span>NEW고구마치즈돈까스</span>
                                    <span>14,000원</span>
                                </li>
                                <li>
                                    <span>배달요금</span>
                                    <span>1,000원</span>
                                </li>
                                <li class="total">
                                    <span>합계</span>
                                    <span>15,000원</span>
                                </li>
                            </ul>
                            <button class="order-button">주문하기</button>
                        </div>
                    </div>
                </div>

        </body>

        </html>