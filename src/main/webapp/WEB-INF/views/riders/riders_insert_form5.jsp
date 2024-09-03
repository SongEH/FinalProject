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
    <style>
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
    </style>
</head>
<body>

    <div class="navbar">
        <!-- <a href="#">배달현황 <span class="dropdown-toggle"></span></a> -->
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
            <!-- Wait Tab Content -->
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
            <!-- Proceed Tab Content -->
            <div class="empty-state">
                진행중인 배차요청이 없습니다
            </div>
           
        <%
            } else if (tab.equals("complete")) {
        %>
            <!-- Complete Tab Content -->
            <div class="empty-state">
                완료된 배차요청이 없습니다
            </div>
        <%
            }
        %>
    </div>

    <!-- Bootstrap JS and dependencies -->
   
</body>
</html>