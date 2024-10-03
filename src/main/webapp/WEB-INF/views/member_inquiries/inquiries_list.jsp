<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>문의사항 목록</title>
    <style>
        body {
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
        .member-actions {
            text-align: center;
            margin-bottom: 20px;
        }
        .member-actions a {
            text-decoration: none;
            padding: 10px 20px;
            color: #fff;
            background-color: #007bff;
            border-radius: 5px;
            font-size: 16px;
        }
        .member-actions a:hover {
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


  <%@include file="../common.jsp" %>

  <%@include file="../header.jsp" %>

  <%@include file="../sidebar.jsp" %>

  <main id="main" class="main">
    <div class="pagetitle">

      <h1>문의사항</h1><br>

      <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="../index.html">Home</a></li>
          <li class="breadcrumb-item">공지&문의</li>
          <li class="breadcrumb-item active">문의사항</li>
        </ol>
      </nav>

    </div>

    <div class="container">
        <input type="hidden" id="inquiries_type" value="${vo.m_inquiries_type}">       
        <div class="filter">
            
            <a href="${pageContext.request.contextPath}/member_inquiries/list.do?m_inquiries_type=전체" class="${m_inquiries_type == '전체' ? 'active' : ''}">전체</a>
        
            
            <a href="${pageContext.request.contextPath}/member_inquiries/list.do?m_inquiries_type=결제문의" class="${m_inquiries_type == '결제문의' ? 'active' : ''}">결제문의</a>
         
          
            <a href="${pageContext.request.contextPath}/member_inquiries/list.do?m_inquiries_type=주문문의" class="${m_inquiries_type == '주문문의' ? 'active' : ''}">주문문의</a>
            
            
            <a href="${pageContext.request.contextPath}/member_inquiries/list.do?m_inquiries_type=서비스이용" class="${m_inquiries_type == '서비스이용' ? 'active' : ''}">서비스이용</a>
            
           
            <a href="${pageContext.request.contextPath}/member_inquiries/list.do?m_inquiries_type=배송문의" class="${m_inquiries_type == '배송문의' ? 'active' : ''}">배송문의</a>
           
        </div>

        <c:if test="${sessionScope.userType == 'MEMBER'}">
            <div class="member-actions">
                <button class="button_style" onclick="location.href='${pageContext.request.contextPath}/member_inquiries/insert_form.do'">문의사항 등록</button>
            </div>
        </c:if>
       

        <div class="inquiries-list">
            <c:forEach var="inquiries" items="${list}">
                <div class="inquiries-card">
                    <div class="inquiries-title">
                        <a href="${pageContext.request.contextPath}/member_inquiries/detail.do?m_inquiries_id=${inquiries.m_inquiries_id}">${inquiries.m_inquiries_title}
                            <c:if test="${inquiries.m_answer_content == null}">
                                <span class="badge rounded-pill bg-warning">
                                ❗️미답변 
                                </span>
                            </c:if>
                        </a>
                    </div>
                    <div class="inquiries-date">
                        작성일자: ${inquiries.m_inquiries_cdate}
                    </div>
                    <div class="inquiries-author">
                        작성자: ${inquiries.memberAccountId}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

  </main>

</body>
</html>
