<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2" defer></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>공지사항 수정</title>
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
            resize: none;
        }
        .content {
            white-space: pre-wrap; 
            word-wrap: break-word;
        }
    </style>

    <script type="text/javascript">
        function send(f){
            let notice_title = f.notice_title.value.trim();
            let notice_type = f.notice_type.value.trim();
            let notice_content = f.notice_content.value.trim();

            if(notice_title ==""){
                alert("제목을 입력하시오");
                f.notice_title.value="";
                f.notice_title.focus();
                return;
            }

            if(notice_type ==""){
                alert("유형을 선택하시오");
                f.notice_type.value="";
                f.notice_type.focus();
                return;
            }

            if(notice_content ==""){
                alert("내용을 입력하시오");
                f.notice_content.value="";
                f.notice_content.focus();
                return;
            }

            f.action = "${pageContext.request.contextPath}/notice/modify.do";
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

        <h1>공지사항 수정</h1><br>

        <nav>
            <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
            <li class="breadcrumb-item">공지&문의</li>
            <li class="breadcrumb-item active">공지사항</li>
            </ol>
        </nav>

        </div>

        <c:if test="${userType == 'ADMIN'}">
            <div class="container">
                
                <form action="${pageContext.request.contextPath}/notice/modify_form.do" method="post">
                    <input type="hidden" name="notice_id" value="${vo.notice_id}">
                    <div class="form-group">
                        <label for="notice_title">제목</label>
                        <input type="text" id="notice_title" name="notice_title" value="${vo.notice_title}"
                        required>
                    </div>
                    <div class="form-group">
                        <label for="notice_type">유형</label>
                        <select class="select, form-control" id="notice_type" name="notice_type" required>
                            <option value="전체"  ${vo.notice_type == '전체' ? 'selected' : ''}>전체</option>
                            <option value="서비스안내" ${vo.notice_type == '서비스안내' ? 'selected' : ''}>서비스 안내</option>
                            <option value="점검안내" ${vo.notice_type == '점검안내' ? 'selected' : ''}>점검 안내</option>
                            <option value="약관안내" ${vo.notice_type == '약관안내' ? 'selected' : ''}>약관 안내</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="notice_content">내용</label>
                        <textarea id="notice_content" name="notice_content" rows="5" required>${vo.notice_content}</textarea>
                    </div>
                    <div class="form-group">
                        <button type="button" class="button_style" onclick="send(this.form);">
                            수정
                        </button>
                        <button type="button" class="button_style" 
                        onclick="location.href='${pageContext.request.contextPath}/notice/detail.do?notice_id=${vo.notice_id}';">
                            취소
                        </button>
                    </div>
                </form>
            </div>
        </c:if>
        
    </main>
    
</body>
</html>
