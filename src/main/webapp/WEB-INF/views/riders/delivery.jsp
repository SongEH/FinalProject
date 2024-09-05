<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달 현황</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FFC6C6;
            color: #333;
        }
        .order-box {
            padding: 15px;
            margin: 10px 0;
            background-color: #FFEBD4;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .order-info {
            margin-bottom: 10px;
        }
        .order-info div {
            margin-bottom: 5px;
        }
        .assign-button {
            display: inline-block;
            padding: 10px 15px;
            background-color: #F0A8D0;
            color: black;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .assign-button:hover {
            background-color: #0056b3;
        }
        select{
            background-color: #FFC6C6;
        }
        .alert {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        .alert-info {
            color: #31708f;
            background-color: #d9edf7;
            border-color: #bce8f1;
        }
        .order-progress-box {
            padding: 20px;
            background-color: #FFEBD4;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .completed-order-box {
            padding: 20px;
            background-color: #FFEBD4;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container mx-auto p-5">
        <div class="bg-white border border-black">
            <div class="text-center font-bold p-4 border-b border-black">
                배달 현황
            </div>
            <div class="flex">
                <div class="w-1/3 text-center border-r border-black">
                    <button onclick="loadPage('${pageContext.request.contextPath}/riders/waiting-orders')" class="w-full h-full p-4">
                        주문 대기
                    </button>
                </div>
                <div class="w-1/3 text-center border-r border-black">
                    <button onclick="loadPage('${pageContext.request.contextPath}/riders/progress')" class="w-full h-full p-4">
                        진행 상황
                    </button>
                </div>
                <div class="w-1/3 text-center">
                    <button onclick="loadPage('${pageContext.request.contextPath}/riders/completed')" class="w-full h-full p-4">
                        배달 완료
                    </button>
                </div>
            </div>
            <div id="content" class="p-4">
                <!-- Content will be loaded here -->
            </div>
        </div>
    </div>

    <script>
        function loadPage(url) {
            fetch(url)
                .then(response => response.text())
                .then(data => {
                    document.getElementById('content').innerHTML = data;
                })
                .catch(error => {
                    console.error('Error loading page:', error);
                    document.getElementById('content').innerHTML = '<p>페이지를 불러오는 중 오류가 발생했습니다.</p>';
                });
        }
    </script>
</body>
</html>
