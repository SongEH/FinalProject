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

    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="inquiries_type" value="${vo.inquiries_type}">
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
            <div class="inquiries-card">
                <div class="inquiries-title">
                    <a href="${pageContext.request.contextPath}/inquiries/detail.do?inquiries_id=${inquiries.inquiries_id}">${inquiries.inquiries_title}</a>
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
    
</div>
</body>
</html>
