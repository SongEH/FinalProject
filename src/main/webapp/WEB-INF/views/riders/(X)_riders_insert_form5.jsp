<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Final Project</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- <style>
        body {
            background-color: #000;
            color: #fff;
            font-family: Arial, sans-serif;
        }
        .navbar {
            background-color: #333;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            color: #fff;
            font-weight: bold;
            text-decoration: none;
        }
        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            background-color: #000;
            color: #fff;
            border: none;
            border-bottom: 3px solid #fff;
        }
        .nav-tabs .nav-link {
            border: none;
            color: #ccc;
            font-weight: bold;
            padding: 15px;
        }
        .nav-tabs .nav-link:hover {
            color: #fff;
        }
        .content {
            padding: 15px;
        }
        .notification {
            background-color: #333;
            color: #ddd;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        .empty-state {
            color: #555;
            text-align: center;
            margin-top: 50px;
        }
        .btn-custom {
            background-color: #F0A8D0;
            border-color: #F0A8D0;
            color: #fff;
            margin-left: 5px;
        }
        .navbar .btn-custom {
            margin-left: 10px;
        }
        .navbar-buttons {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-end;
        }
    </style> -->
</head>
<body>

    <h2>배차 대기 중인 주문</h2>

    <div id="result-message" class="alert alert-info" style="display:none;"></div>

    <c:forEach var="order" items="${orders}">
        <div class="order-box">
            <div class="order-info">
                <div><strong>주문 번호:</strong> ${order.orders_id}</div>
                <div><strong>식당:</strong> ${order.shop_name}</div>
                <div><strong>가격:</strong> ${order.orders_price}원</div>
                <div><strong>요청사항:</strong> ${order.orders_srequest}</div>
            </div>
            <form action="${pageContext.request.contextPath}/riders/assign" method="post">
                <input type="hidden" name="orders_id" value="${order.orders_id}" />
                <input type="hidden" name="riders_id" value="${riders_id}" />
                <label for="method-${order.orders_id}">배송 수단:</label>
                <select id="method-${order.orders_id}" name="deliveries_method" required>
                    <option value="오토바이" ${order.deliveries_method == '오토바이' ? 'selected' : ''}>오토바이</option>
                    <option value="자동차" ${order.deliveries_method == '자동차' ? 'selected' : ''}>자동차</option>
                    <option value="자전거" ${order.deliveries_method == '자전거' ? 'selected' : ''}>자전거</option>
                    <option value="도보" ${order.deliveries_method == '도보' ? 'selected' : ''}>도보</option>
                </select>
                <button type="submit" class="assign-button">배차 받기</button>
            </form>
        </div>
    </c:forEach>

    <script>
        function assignOrder(orders_id, riders_id) {
            console.log("assignOrder 호출됨");  // 이 부분 추가
            const method = document.getElementById(`method-${order_id}`).value;
            fetch('${pageContext.request.contextPath}/riders/assign', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'orders_id': orders_id,
                    'riders_id': riders_id,
                    'deliveries_method': deliveries_method
                })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                alert(data.resultMessage); // 메시지를 alert로 표시
                if (data.success) {
                    loadPage('${pageContext.request.contextPath}/riders/progress'); // 배차 완료 후 진행 상황 페이지로 이동
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('배차 요청 중 오류가 발생했습니다. 다시 시도해주세요.');
            });

        }


        function loadPage(url) {
            fetch(url)
                .then(response => response.text())
                .then(data => {
                    document.getElementById('content').innerHTML = data;
                });
        }
    </script>


    <!-- <div class="navbar">
       
        <div class="dropdown">
            <button class="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">
              마이페이지
            </button>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="mypage.do">회원수정</a>
              <a class="dropdown-item" href="#">배차완료</a>
            </div>
          </div>
        <p>${user.riders_name}입니다.</p>
        <div class="navbar-buttons">
            <button class="btn btn-custom" style="background-color: #F0A8D0; border-color: #F0A8D0; color: #fff;">배차 시작</button>
            <button class="btn btn-custom" style="background-color: #F0A8D0; border-color: #F0A8D0; color: #fff;">배차 종료</button>
            <a href="logout.do"><button class="btn btn-custom" style="background-color: #F0A8D0; border-color: #F0A8D0; color: #fff;">로그아웃</button></a>
        </div>
    </div>

    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" id="wait-tab" href="?tab=wait">대기 0</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="proceed-tab" href="?tab=proceed">진행 0</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="complete-tab" href="?tab=complete">완료 0</a>
        </li>
    </ul> 
   <div class="content">
        <%
            String tab = request.getParameter("tab");
            if (tab == null || tab.equals("wait")) {
        %>
            
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="color: black;">가맹점</h5>
                    <p class="card-text" style="color: black;">세부내용</p>
                    <p class="card-text" style="color: black;">세부내용</p>
                    <p class="card-text" style="color: black;">세부내용</p>
                    <p class="card-text" style="color: black;">세부내용</p>
                    <button class="btn btn-custom" style="background-color: #F0A8D0; border-color: #F0A8D0; color: #fff;">수락</button>
                </div>
            </div>
           
        <%
            } else if (tab.equals("proceed")) {
        %>
          
            <div class="empty-state">
                진행중인 배차요청이 없습니다
            </div>
           
        <%
            } else if (tab.equals("complete")) {
        %>
           
            <div class="empty-state">
                완료된 배차요청이 없습니다
            </div>
        <%
        }
        %>
    </div>  -->

   
   
</body>
</html>