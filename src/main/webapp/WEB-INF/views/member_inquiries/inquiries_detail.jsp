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
        .inquiries_type {
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
        .admin-answer {
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
         .answer-cdate {
            font-size: 14px;
            color: #888;
            margin-bottom: 20px;
        }
        .answer-content {
            font-size: 16px;
            line-height: 1.6;
        }
        .answer-author {
            font-size: 14px;
            color: #555;
            margin-top: 20px;
            text-align: right;
        }
        .admin-actions {
            text-align: center;
            margin-bottom: 20px;
        }
        .admin-actions a {
            text-decoration: none;
            padding: 10px 20px;
            color: #fff;
            background-color: #007bff;
            border-radius: 5px;
            font-size: 16px;
        }
        .admin-actions a:hover {
            background-color: #0056b3;
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
        function del(m_inquiries_id) {
            if (confirm("정말 삭제 하시겠습니까?") == false) return;
            location.href = "delete.do?m_inquiries_id=" + m_inquiries_id;
        }
    </script>
     <script type="text/javascript">
        function del(m_answer_id) {
            if (confirm("정말 삭제 하시겠습니까?") == false) return;
            $.ajax({
                url: "${pageContext.request.contextPath}/member_inquiries/answer_delete.do",
                type: "POST",
                data: { m_answer_id: m_answer_id, m_inquiries_id: '${param.m_inquiries_id}' },
                success: function(response) {
                    alert("답변이 삭제되었습니다.");
                    location.href = "${pageContext.request.contextPath}/member_inquiries/detail.do?m_inquiries_id=" + '${param.m_inquiries_id}';
                },
                error: function(xhr) {
                    alert("답변 삭제에 실패했습니다. 다시 시도해 주세요.");
                }
            });
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
                <li class="breadcrumb-item">공지&문의</li>
                <li class="breadcrumb-item active">문의사항</li>
            </ol>
        </nav>

        </div><!-- End Page Title -->

        
        <div class="container">

            <!-- 상세 정보 표시 영역 -->
            <div class="inquiries_detail">
                <div class="inquiries_title">
                    ${vo.m_inquiries_title}
                </div>
                <div class="inquiries_cdate">
                    ${vo.m_inquiries_cdate}
                </div>
                <div class="inquiries_type">
                    ${vo.m_inquiries_type}
                </div>
                <div class="inquiries_content">
                    ${vo.m_inquiries_content}
                </div>
                <div class="inquiries-author">
                    작성자: ${vo.memberAccountId}
                </div>    

                <button class="back-button button_style" onclick="location.href='${pageContext.request.contextPath}/member_inquiries/list.do?m_inquiries_type=전체'">목록으로</button>
                <c:if test="${userType == 'MEMBER' && vo.memberAccountId == currentUser }">
                    <button class="button_style" onclick="location.href='${pageContext.request.contextPath}/member_inquiries/modify_form.do?m_inquiries_id=${vo.m_inquiries_id}&m_inquiries_type=${vo.m_inquiries_type}'">수정</button>
                    <button class="button_style" onclick="del('${vo.m_inquiries_id}');">삭제</button>
                </c:if>
                
            </div>    
        </div>
        <div class="container" style="margin-top: 20px;">

            <c:if test="${sessionScope.userType == 'ADMIN'}">
                <div class="admin-actions">
                    <button class="button_style" onclick="location.href='${pageContext.request.contextPath}/member_inquiries/answer_insert_form.do?m_inquiries_id=${param.m_inquiries_id}'">답변 등록</button>
                </div>
            </c:if>

            <div class="admin-answer">
                <c:forEach var="answer" items="${answer_list}">
                    <c:if test="${not empty answer}">
                        <div class="answer-content">
                            <strong>답변 :</strong> ${answer.m_answer_content}
                        </div>
                        <div class="answer-cdate">
                            ${answer.m_answer_cdate}
                        </div>
                        <div class="answer-author">
                            <strong>작성자 :</strong> ${answer.admin_accountId}
                        </div>
                    </c:if>
                
                    <c:if test="${sessionScope.userType == 'ADMIN'}">
                        <div class="admin-actions">
                            <button type="button" class="button_style" onclick="location.href='${pageContext.request.contextPath}/member_inquiries/answer_modify_form.do?m_answer_id=${answer.m_answer_id}&m_inquiries_id=${param.m_inquiries_id}'">수정</button>
                            <button type="button" class="button_style" onclick="del('${answer.m_answer_id}');">삭제</button>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

    </main><!-- End #main -->

</body>
</html>
