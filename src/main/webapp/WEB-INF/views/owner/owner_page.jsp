<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
        <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>사장페이지</title>

        <script type="text/javascript">
            function del(owner_id) {
                //console.log(mem_idx,"삭제");
                if (confirm("정말 탈퇴 하시겠습니까?") == false) return;

                //삭제요청
                location.href = "ownerpage/delete.do?owner_id=" + owner_id;
            }
        </script>

        <style>
            body {
                background-color: #f4f4f4;
                margin: 0;
                padding: 0px;
            }

            .container {
                max-width: 800px;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .mb-4 {
                margin-bottom: 16px;
            }

            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 14px;
            }

            .form-control[readonly] {
                background-color: #f9f9f9;
            }

            .flex {
                display: flex;
                justify-content: flex-end;
            }



        </style>
    </head>

    <body>

        <%@ include file="../common.jsp" %>

        <%@ include file="../header.jsp" %>

        <%@ include file="../sidebar.jsp" %>

        <main id="main" class="main">
            <div class="pagetitle">

                <h1>사장정보</h1><br>

                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="../order/accept.do">Home</a></li>
                    <li class="breadcrumb-item">사장관리</li>
                    <li class="breadcrumb-item active">사장정보</li>
                    </ol>
                </nav>

            </div><!-- End Page Title -->

            
            
            <div class="container mx-auto p-6">
                <input type="hidden" name="owner_id" value="${owner.owner_id}" />
                <div class="mb-4">
                    <label for="name">이름:</label>
                    <input class="form-control" type="text" value="${owner.owner_name}" readonly />
                </div>
                <div class="mb-4">
                    <label for="accountId">아이디:</label>
                    <input class="form-control" type="text" value="${owner.owner_accountId}" readonly />
                </div>
                <div class="mb-4">
                    <label for="password">비밀번호:</label>
                    <input class="form-control" type="password" value="${owner.owner_pwd}" readonly />
                </div>
                <div class="mb-4">
                    <label for="email">이메일:</label>
                    <input class="form-control" type="text" value="${owner.owner_email}" readonly />
                </div>
                <div class="mb-4">
                    <label for="phone">전화번호:</label>
                    <input class="form-control" type="text" value="${owner.owner_phone}" readonly />
                </div>
                <div class="mb-4">
                     <label for="license">사업자등록번호:</label>
                     <input class="form-control" type="text" value="${owner.owner_license}" readonly />
                </div>
                 <div class="mb-4">
                    <label for="bankbook">법인통장번호:</label>
                    <input class="form-control" type="text" value="${owner.owner_bankbook}" readonly />
                 </div>
                <div class="flex justify-end">
                    <c:if test="${user.owner_id eq owner.owner_id}">
                         <input style="margin-right: 10px;" type="button" class="button_style" value="회원 수정"
                            onclick="location.href='ownerpage/modify_form.do?owner_id=${owner.owner_id}'" />
                        <input type="button" class="button_style" value="회원 탈퇴" onclick="del('${ owner.owner_id }');" />
                     </c:if>
                </div>
            </div>

        </main><!-- End #main -->

        
    </body>

    </html>