<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>문의사항 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .filter {
            text-align: center;
            margin-bottom: 20px;
        }
        .filter a {
            text-decoration: none;
            color: #007bff;
            margin: 0 10px;
            font-size: 16px;
        }
        .filter a.active {
            font-weight: bold;
            color: #ff5733;
        }
        .actions {
            text-align: center;
            margin-bottom: 20px;
        }
        .actions a {
            text-decoration: none;
            padding: 10px 20px;
            color: #fff;
            background-color: #007bff;
            border-radius: 5px;
            font-size: 16px;
        }
        .actions a:hover {
            background-color: #0056b3;
        }
        .inquiries-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .inquiries-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .inquiries-title {
            font-size: 18px;
            font-weight: bold;
            flex: 2;
        }
        .inquiries-date {
            flex: 1;
            text-align: center;
            color: #888;
        }
        .inquiries-author {
            flex: 1;
            text-align: right;
            color: #555;
        }
        .inquiries-title a {
            text-decoration: none;
            color: #007bff;
        }
        .inquiries-title a:hover {
            text-decoration: underline;
        }
        .modal {
            display: none; /* Initially hidden */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 300px;
            border-radius: 8px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="inquiries_pwd" value="${vo.inquiries_pwd}">
    <input type="hidden" id="inquiries_id" value="${vo.inquiries_id}">
    <h1>문의사항</h1>

    <% 
        // 세션에서 user 객체를 가져옴
        String userType = (String)session.getAttribute("userType");
        if(userType == null){
            userType = "UNKNOWN";   //기본갑을 설정
        }
        
    %>
    

    <div class="filter">
        <a href="${pageContext.request.contextPath}/inquiries/list.do?inquiries_type=전체" class="${inquiries_type == '전체' ? 'active' : ''}">전체</a>
        <a href="${pageContext.request.contextPath}/inquiries/list.do?inquiries_type=결제문의" class="${inquiries_type == '결제문의' ? 'active' : ''}">결제문의</a>
        <a href="${pageContext.request.contextPath}/inquiries/list.do?inquiries_type=주문문의" class="${inquiries_type == '주문문의' ? 'active' : ''}">주문문의</a>
        <a href="${pageContext.request.contextPath}/inquiries/list.do?inquiries_type=서비스이용" class="${inquiries_type == '서비스이용' ? 'active' : ''}">서비스이용</a>
        <a href="${pageContext.request.contextPath}/inquiries/list.do?inquiries_type=배송문의" class="${inquiries_type == '배송문의' ? 'active' : ''}">배송문의</a>
    </div>

    <c:if test="${userType == 'MEMBER'}">
        <div class="actions">
            <a href="${pageContext.request.contextPath}/inquiries/insert_form.do">문의사항 등록</a>
        </div>
    </c:if>
    <c:if test="${userType == 'OWNER'}">
        <div class="actions">
            <a href="${pageContext.request.contextPath}/inquiries/insert_form.do">문의사항 등록</a>
        </div>
    </c:if>

    <div class="inquiries-list">
        <c:forEach var="inquiries" items="${list}">
            <div class="inquiries-card" onclick="showPasswordModal('${inquiries.inquiries_id}','${inquiries.memberAccountId}','${inquiries.ownerAccountId}')">
                <div class="inquiries-title">
                    ${inquiries.inquiries_title}
                </div>
                <div class="inquiries-date">
                    작성일자: ${inquiries.inquiries_cdate}
                </div>
                <div class="inquiries-author">
                    <c:choose>
                        <c:when test="${inquiries.memberAccountId != null}">
                            작성자: ${inquiries.memberAccountId}
                        </c:when>
                        <c:when test="${inquiries.ownerAccountId != null}">
                            작성자: ${inquiries.ownerAccountId}
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>

                <!-- 비밀번호 입력 모달 -->
    <input type="hidden" id="hidden_inquiries_pwd" value="${vo.inquiries_pwd}">             
    <div id="passwordModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>비밀번호 입력</h2>
            <input type="password" id="inquiries_pwd" placeholder="비밀번호를 입력하세요" />
            <button type="button" onclick="checkPassword()">확인</button>
            <div id="modal_password_message" style="color: red;"></div>
        </div>
    </div>
    

</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let inquiries_id;

    function showPasswordModal(inquiries_id,memberAccountId,ownerAccountId) {
        inquiries_id = inquiries_id;
        memberAccountId = memberAccountId;
        ownerAccountId = ownerAccountId;

        alert("memberAccountId : " + memberAccountId);
        alert("ownerAccoountId : " + ownerAccountId);
        document.getElementById("passwordModal").style.display = "block";
        document.getElementById("modal_password_message").innerText = ""; // 초기화
    }

    function closeModal() {
        document.getElementById("passwordModal").style.display = "none";
    }

    function checkPassword() {
    let inquiries_pwd = document.getElementById("inquiries_pwd").value;
    let hidden_inquiries_pwd = document.getElementById("hidden_inquiries_pwd").value;
    let inquiries_id = document.getElementById("inquiries_id").value;

    if (inquiries_id.trim() === "") {
        document.getElementById("modal_password_message").innerText = "유효하지 않은 ID입니다.";
        return;
    }

    if (inquiries_pwd.length === 0) {
        document.getElementById("modal_password_message").innerText = "비밀번호를 입력하세요.";
        return;
    }

    // 비밀번호 비교
    if (inquiries_pwd !== hidden_inquiries_pwd) {
        document.getElementById("modal_password_message").innerText = "비밀번호가 일치하지 않습니다.";
        return;
    }

    // AJAX 요청
    $.ajax({
        url: "/inquiries/check_password.do",
        type: "POST",
        data: {
            inquiries_id: inquiries_id,
            inquiries_pwd: inquiries_pwd
        },
        dataType: "json",
        success: function (res_data) {
            if (res_data.result) {
                // 비밀번호 확인 성공 시 detail.do로 이동
                window.location.href = `/inquiries/detail.do?inquiries_id=${inquiries_id}&password=${inquiries_pwd}`;
            } else {
                document.getElementById("modal_password_message").innerText = "비밀번호가 일치하지 않습니다.";
            }
        },
        error: function () {
            alert("서버 오류가 발생했습니다.");
        }
    });
}

</script>

</body>
</html>
