<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>문의사항 상세</title>
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
        .inquiries_detail {
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .inquiries_title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .inquiries_cdate {
            font-size: 14px;
            color: #888;
            margin-bottom: 20px;
        }
        .inquiries_content {
            font-size: 16px;
            line-height: 1.6;
        }
        .inquiries_author {
            font-size: 14px;
            color: #555;
            margin-top: 20px;
            text-align: right;
        }
        .back-button {
            display: block;
            width: 150px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border-radius: 5px;
            text-decoration: none;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
        .content {
            white-space: pre-wrap; /* 줄 바꿈과 공백을 유지합니다 */
            word-wrap: break-word; /* 긴 단어를 자동으로 줄 바꿈 */
        }
    </style>

    <script type="text/javascript">
        function del(inquiries_id) {
            if (confirm("정말 삭제 하시겠습니까?") == false) return;
            location.href = "delete.do?inquiries_id=" + inquiries_id;
        }
    </script>
</head>
<body>


    <%@include file="../common.jsp" %>

    <%@include file="../header.jsp" %>

    <%@include file="../sidebar.jsp" %>

    <main id="main" class="main">
        <div class="pagetitle">

        <h1>문의사항 상세</h1>

        <nav>
            <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">Forms</li>
            <li class="breadcrumb-item active">Layouts</li>
            </ol>
        </nav>

        </div><!-- End Page Title -->

        <input type="hidden" id="inquiries_id" value="${vo.inquiries_id}">
        <div class="container">

            <!-- 상세 정보 표시 영역 -->
            <div class="inquiries_detail">
                <div class="inquiries_title">
                    ${vo.inquiries_title}
                </div>
                <div class="inquiries_cdate">
                    ${vo.inquiries_cdate}
                </div>
                <div class="inquiries_content">
                    ${vo.inquiries_content}
                </div>
                <div class="inquiries-author">
                        작성자: 
                        <c:choose>
                            <c:when test="${not empty inquiries.memberAccountId}">
                                ${vo.memberAccountId}
                            </c:when>
                            <c:when test="${not empty inquiries.ownerAccountId}">
                                ${vo.ownerAccountId}
                            </c:when>
                        </c:choose>
                </div>
                <c:if test="${isAuthor}">
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/inquiries/modify_form.do?inquiries_id=${vo.inquiries_id}'">수정</button>
                    <button type="button" onclick="del('${vo.inquiries_id}');">삭제</button>
                </c:if>
                
            </div>

            <a href="${pageContext.request.contextPath}/inquiries/list.do" class="back-button">목록으로</a>
        </div>

    </main><!-- End #main -->

</body>
</html>
