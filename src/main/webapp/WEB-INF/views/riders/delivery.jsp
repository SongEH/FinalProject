<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배달 현황</title>
    <script src="https://cdn.tailwindcss.com"></script>
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
                });
        }
    </script>
</body>
</html>
