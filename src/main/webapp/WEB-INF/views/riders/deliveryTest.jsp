<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>delivery copy</title>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
      body {
        font-family: "Helvetica Neue", Arial, sans-serif;
        background-color: #f7f7f7;
        color: #333;
        margin: 0;
        padding: 0;
      }

      .container {
        max-width: 900px;
        margin: 0 auto;
        padding: 20px;
      }

      .content-wrapper {
        background-color: white;
        border: 1px solid #e0e0e0;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      .header {
        background-color: #f0a8d0;
        color: white;
        padding: 20px;
        text-align: center;
        border-bottom: 2px solid #e0e0e0;
        font-size: 24px;
        font-weight: bold;
        border-radius: 10px 10px 0 0;
      }

      /* Dropdown menu styling */
      .dropdown {
        position: relative;
        display: inline-block;
        margin: 10px;
      }

      .dropdown .btn-secondary {
        background-color: #f0a8d0;
        border: none;
        color: white;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
      }

      .dropdown .btn-secondary:hover {
        background-color: #e090b5;
      }

      .dropdown-content {
        display: none;
        position: absolute;
        background-color: white;
        min-width: 160px;
        box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
        z-index: 1;
        right: 0;
      }

      .dropdown-content a {
        color: #333;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
      }

      .dropdown-content a:hover {
        background-color: #f0f0f0;
      }

      .dropdown:hover .dropdown-content {
        display: block;
      }

      .greeting {
        padding: 15px;
        font-size: 18px;
        display: flex;
        justify-content: space-between; /* 양 끝에 배치 */
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
      }

      .greeting p {
        margin: 0;
        flex-grow: 1; /* 왼쪽 끝으로 이동 */
      }

      .greeting button {
        margin: 0;
      }
      .navigation {
        display: flex;
        border-top: 1px solid #e0e0e0;
        border-bottom: 1px solid #e0e0e0;
        justify-content: space-around; /* Add space between buttons */
      }

      .navigation button {
        flex-grow: 1;
        padding: 20px;
        font-size: 16px;
        background-color: #fff;
        border: none;
        border-right: 1px solid #e0e0e0;
        cursor: pointer;
        transition: background-color 0.3s;
      }

      .navigation button:hover {
        background-color: #f0a8d0;
        color: white;
      }

      .navigation button:last-child {
        border-right: none;
      }

      #content {
        padding: 20px;
      }

      .order-box {
        padding: 15px;
        margin: 10px 0;
        background-color: #ffebd4;
        border: 1px solid #ddd;
        border-radius: 5px;
      }

      .order-info div {
        margin-bottom: 5px;
      }

      .assign-button {
        padding: 10px 15px;
        background-color: #f0a8d0;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
      }

      .assign-button:hover {
        background-color: #e090b5;
      }

      .alert {
        margin-bottom: 20px;
        padding: 15px;
        background-color: #ffebd4;
        border-radius: 5px;
      }

      .order-progress-box,
      .completed-order-box {
        padding: 20px;
        background-color: #ffebd4;
        border-radius: 5px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
      }

      /* Responsive styles */
      @media (max-width: 768px) {
        .container {
          padding: 15px;
        }

        .header {
          font-size: 20px;
          padding: 15px;
        }

        .greeting {
          flex-direction: column;
          align-items: center;
        }

        .navigation button {
          padding: 15px;
          font-size: 14px;
        }

        .assign-button {
          padding: 8px 12px;
        }

        #content {
          padding: 15px;
        }
      }

      @media (max-width: 480px) {
        .container {
          padding: 10px;
        }

        .header {
          font-size: 18px;
          padding: 10px;
        }

        .greeting {
          flex-direction: column; /* 스마트폰에서 세로 정렬 */
          justify-content: center;
          align-items: center; /* 중앙 정렬 */
        }

        .navigation {
          flex-direction: column;
        }

        .navigation button {
          padding: 10px;
          font-size: 12px;
          border-right: none;
          border-bottom: 1px solid #e0e0e0;
        }

        .navigation button:last-child {
          border-bottom: none;
        }

        .assign-button {
          padding: 6px 10px;
        }

        #content {
          padding: 10px;
        }
      }
    </style>
  </head>

  <body>
    <div class="container">
      <div class="content-wrapper">
        <div class="header">배달 현황</div>

        <div class="greeting">
          <p>${user.rider_name}입니다.</p>
          <button onclick="location.href ='main.do'" class="btn btn-secondary">
            로그아웃
          </button>
          <button
            onclick="location.href ='mypage.do'"
            class="btn btn-secondary"
          >
            마이페이지
          </button>
        </div>

        <div class="navigation">
          <button
            onclick="loadPage('${pageContext.request.contextPath}/riders/waiting-orders')"
          >
            주문 대기
          </button>
          <button
            onclick="loadPage('${pageContext.request.contextPath}/riders/progress')"
          >
            진행 상황
          </button>
          <button
            onclick="loadPage('${pageContext.request.contextPath}/riders/completed')"
          >
            배달 완료
          </button>
        </div>

        <div id="content">
          <!-- Content will be loaded here -->
        </div>
      </div>
    </div>

    <script>
      function loadPage(url) {
        fetch(url)
          .then((response) => response.text())
          .then((data) => {
            document.getElementById("content").innerHTML = data;
          });
      }
    </script>
  </body>
</html>
