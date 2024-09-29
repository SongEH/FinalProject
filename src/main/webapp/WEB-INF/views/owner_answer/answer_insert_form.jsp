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
    <title>답변 등록</title>
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
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group textarea {
            resize: vertical;
        }
        .form-group button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }
        .content {
            white-space: pre-wrap; /* 줄 바꿈과 공백을 유지합니다 */
            word-wrap: break-word; /* 긴 단어를 자동으로 줄 바꿈 */
        }
    </style>

    <script type="text/javascript">
        function send(f){
            let o_answer_content = f.o_answer_content.value.trim();

            if(o_answer_content ==""){
                alert("내용을 입력하시오");
                f.o_answer_content.value="";
                f.o_answer_content.focus();
                return;
            }

            f.action = "${pageContext.request.contextPath}/owner_inquiries/answer_insert.do";
            f.submit();
        }
    </script>
</head>
<body>

    
    <%@include file="../common.jsp" %>

    <%@include file="../header.jsp" %>

    <%@include file="../sidebar.jsp" %>

    <main id="main" class="main">
        <div class="pagetitle">

        <h1>답변 등록</h1>

        <nav>
            <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">Forms</li>
            <li class="breadcrumb-item active">Layouts</li>
            </ol>
        </nav>

        </div><!-- End Page Title -->

        <div class="container">
        
        <form action="${pageContext.request.contextPath}/owner_inquiries/answer_insert_form.do" method="post">
            
            <input type="hidden" name="o_inquiries_id" value="${param.o_inquiries_id}">
            <input type="hidden" name="o_answer_id" value="${answer.o_answer_id}">
            <div class="form-group">
                <label for="o_answer_content">내용</label>
                <textarea id="o_answer_content" name="o_answer_content" rows="5" required></textarea>
            </div>
            <div class="form-group">
                <button type="button" class="button_style" onclick="send(this.form);">
                    등록
                </button>
                <button type="button" class="button_style" onclick="location.href='${pageContext.request.contextPath}/owner_inquiries/detail.do?o_inquiries_id='+'${param.o_inquiries_id}'">
                    취소
                </button>
            </div>
        </form>
    </div>

    </main><!-- End #main -->


    
</body>
</html>
