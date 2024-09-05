<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="utf-8">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>



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
            <%@include file="../common.jsp" %>

                <!-- header import -->
                <%@include file="../header.jsp" %>

                    <!-- side bar import -->
                    <%@include file="../sidebar.jsp" %>

                        <!-- popup:Modal -->
                        <%@include file="popup.jsp" %>

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
                                        <div class="col-lg-6">
                                            <c:forEach var="vo" items="${list}">
                                                <!-- vo.menu_status가 1인 경우만 표시 -->
                                                <c:if test="${vo.menu_status == 1}">
                                                    <!-- Card with an image on left -->
                                                    <div class="card mb-3">
                                                        <div class="row g-0" lass="photo"
                                                            onclick="showPhoto('${vo.menu_id}');">
                                                            <div class="col-md-4">
                                                                <img src="../resources/images/${vo.menu_img}"
                                                                    class="img-fluid rounded-start" alt="...">
                                                            </div>
                                                            <div class="col-md-8">
                                                                <div class="card-body">
                                                                    <h5 class="card-title">메뉴명 (${vo.menu_id})
                                                                        ${vo.menu_name}
                                                                    </h5>
                                                                    <p class="card-text">설명 ${vo.menu_content}</p>
                                                                    <p class="card-text">가격 ${vo.menu_price}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div><!-- End Card with an image on left -->
                                                </c:if>
                                            </c:forEach>
                                        </div>


                                    </div>

                                    </div>
                                </section>

                            </main><!-- End #main -->

        </body>

        </html>