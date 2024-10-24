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

    <title>문의사항 수정</title>
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
        .content {
            white-space: pre-wrap;
            word-wrap: break-word;
        }
    </style>

    <script type="text/javascript">
        function send(f){
            let m_inquiries_title = f.m_inquiries_title.value.trim();
            let m_inquiries_type = f.m_inquiries_type.value.trim();
            let m_inquiries_content = f.m_inquiries_content.value.trim();
            

            if(m_inquiries_title ==""){
                alert("제목을 입력하시오");
                f.m_inquiries_title.value="";
                f.m_inquiries_title.focus();
                return;
            }

            if(m_inquiries_type ==""){
                alert("유형을 선택하시오");
                f.m_inquiries_type.value="";
                f.m_inquiries_type.focus();
                return;
            }

            if(m_inquiries_content ==""){
                alert("내용을 입력하시오");
                f.m_inquiries_content.value="";
                f.m_inquiries_content.focus();
                return;
            }

            f.action = "${pageContext.request.contextPath}/member_inquiries/modify.do";
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

        <h1>문의사항 수정</h1><br>

        <nav>
            <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">공지&문의</li>
            <li class="breadcrumb-item active">문의사항</li>
            </ol>
        </nav>

        </div>
        
            <div class="container">
                
                <form action="${pageContext.request.contextPath}/member_inquiries/modify_form.do" method="post">
                    <input type="hidden" name="m_inquiries_id" value="${vo.m_inquiries_id}">
                    <div class="form-group">
                        <label for="m_inquiries_title">제목</label>
                        <input type="text" id="m_inquiries_title" name="m_inquiries_title" value="${vo.m_inquiries_title}" required>
                    </div>
                    <div class="form-group">
                        <label for="m_inquiries_type">유형</label>
                        <select class="select, form-control" id="m_inquiries_type" name="m_inquiries_type" required>
                            <option value="전체" ${vo.m_inquiries_type == '전체' ? 'selected' : ''}>전체</option>
                            <option value="결제문의" ${vo.m_inquiries_type == '결제문의' ? 'selected' : ''}>결제 문의</option>
                            <option value="주문문의" ${vo.m_inquiries_type == '주문문의' ? 'selected' : ''}>주문 문의</option>
                            <option value="서비스이용" ${vo.m_inquiries_type == '서비스이용' ? 'selected' : ''}>서비스 이용</option>
                            <option value="배송문의" ${vo.m_inquiries_type == '배송문의' ? 'selected' : ''}>배송 문의</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="m_inquiries_content">내용</label>
                        <textarea id="m_inquiries_content" name="m_inquiries_content" rows="5" required>${vo.m_inquiries_content}</textarea>
                    </div>
                    <div class="form-group">
                        <button type="button" class="button_style" onclick="send(this.form);">
                            수정
                        </button>
                        <button type="button" class="button_style" onclick="location.href='${pageContext.request.contextPath}/member_inquiries/detail.do?m_inquiries_id=${vo.m_inquiries_id}';">
                            취소
                        </button>
                    </div>
                </form>
            </div>
         
    </main>
    
</body>
</html>
