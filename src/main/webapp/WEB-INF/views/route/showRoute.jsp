<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<<<<<<< HEAD
<head>
    <meta charset="UTF-8">
    <title>경로 확인</title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e45d2ae43d58ec086189b83a1f462c21"></script>
    <style>
        body {
            background-color: #ffebd4;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h2{
            text-align: center;
        }

        #map {
            width: 100%;
            height: 400px;
        }

        .kakao-button {
            width: 200px;
            height: 50px;
            padding: 10px 15px;
            background-color: #f0a8d0;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 15px;
            justify-content: center;
            display: flex;
            align-items: center;
            margin: 0 auto;
            margin-top: 30px;
        }

        /* 모바일 환경 대응을 위한 미디어 쿼리 */
        @media only screen and (max-width: 600px) {
            #map {
                height: 300px; /* 작은 화면에서 지도의 높이 감소 */
            }

            .kakao-button {
                width: 100%; /* 버튼이 화면 전체 폭에 맞게 설정 */
                height: 45px; /* 높이 약간 감소 */
                font-size: 14px; /* 글자 크기 조정 */
                padding: 8px 10px; /* 패딩 감소 */
            }

            h2 {
                text-align: center;
                font-size: 1.5em; /* 작은 화면에서 제목 크기 조정 */
            }
        }        
    </style>
</head>
<body>
<h2>배달 거리</h2>
<div id="map"></div>
<button id="kakaoMapButton" class="kakao-button">카카오맵에서 경로 찾기</button>

<script type="text/javascript">
    // JSP에서 넘겨받은 값들을 자바스크립트 변수로 안전하게 할당
    var shopLat = parseFloat("${shopLat}");
    var shopLng = parseFloat("${shopLng}");
    var customerLat = parseFloat("${customerLat}");
    var customerLng = parseFloat("${customerLng}");

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(shopLat, shopLng), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 마커가 표시될 위치
    var shopPosition = new kakao.maps.LatLng(shopLat, shopLng);
    var customerPosition = new kakao.maps.LatLng(customerLat, customerLng);

    // 마커 생성
    var shopMarker = new kakao.maps.Marker({
        position: shopPosition
    });

    var customerMarker = new kakao.maps.Marker({
        position: customerPosition
    });

    // 마커가 지도 위에 표시되도록 설정
    shopMarker.setMap(map);
    customerMarker.setMap(map);

    // 경로 표시 (직선으로 연결)
    var linePath = [shopPosition, customerPosition];
    var polyline = new kakao.maps.Polyline({
        path: linePath,
        strokeWeight: 5,
        strokeColor: '#FF0000',
        strokeOpacity: 0.7,
        strokeStyle: 'solid'
    });

    polyline.setMap(map);

    // JSP에서 넘겨받은 값들을 자바스크립트 변수로 할당
    var shopAddress = "${shopAddress}";
    var customerAddress = "${customerAddress}";

    // 콘솔 출력
    console.log("Shop Address: ", shopAddress);
    console.log("Customer Address: ", customerAddress);

    // Kakao 맵 길찾기 URL 생성
    var kakaoMapUrl = `https://map.kakao.com/?sName=${shopAddress}&eName=${customerAddress}`;
    
    // 버튼 클릭 시 Kakao 맵으로 이동
    document.getElementById('kakaoMapButton').addEventListener('click', function() {
        window.open(kakaoMapUrl, '_blank');
    });
</script>
</body>
=======
  <head>
    <meta charset="UTF-8" />
    <title>경로 확인</title>
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e45d2ae43d58ec086189b83a1f462c21"
    ></script>
    <style>
      #map {
        width: 100%;
        height: 400px;
      }
    </style>
  </head>
  <body>
    <h2>배달 거리</h2>
    <div id="map"></div>
    <button id="kakaoMapButton">카카오맵에서 경로 찾기</button>

    <script type="text/javascript">
      // JSP에서 넘겨받은 값들을 자바스크립트 변수로 안전하게 할당
      var shopLat = parseFloat("${shopLat}");
      var shopLng = parseFloat("${shopLng}");
      var customerLat = parseFloat("${customerLat}");
      var customerLng = parseFloat("${customerLng}");

      var mapContainer = document.getElementById("map"), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(shopLat, shopLng), // 지도의 중심좌표
          level: 5, // 지도의 확대 레벨
        };

      var map = new kakao.maps.Map(mapContainer, mapOption);

      // 마커가 표시될 위치
      var shopPosition = new kakao.maps.LatLng(shopLat, shopLng);
      var customerPosition = new kakao.maps.LatLng(customerLat, customerLng);

      // 마커 생성
      var shopMarker = new kakao.maps.Marker({
        position: shopPosition,
      });

      var customerMarker = new kakao.maps.Marker({
        position: customerPosition,
      });

      // 마커가 지도 위에 표시되도록 설정
      shopMarker.setMap(map);
      customerMarker.setMap(map);

      // 경로 표시 (직선으로 연결)
      var linePath = [shopPosition, customerPosition];
      var polyline = new kakao.maps.Polyline({
        path: linePath,
        strokeWeight: 5,
        strokeColor: "#FF0000",
        strokeOpacity: 0.7,
        strokeStyle: "solid",
      });

      polyline.setMap(map);

      // JSP에서 넘겨받은 값들을 자바스크립트 변수로 할당
      var shopAddress = "${shopAddress}";
      var customerAddress = "${customerAddress}";

      // 콘솔 출력
      console.log("Shop Address: ", shopAddress);
      console.log("Customer Address: ", customerAddress);

      // Kakao 맵 길찾기 URL 생성
      var kakaoMapUrl = `https://map.kakao.com/?sName=${shopAddress}&eName=${customerAddress}`;

      // 버튼 클릭 시 Kakao 맵으로 이동
      document
        .getElementById("kakaoMapButton")
        .addEventListener("click", function () {
          window.open(kakaoMapUrl, "_blank");
        });
    </script>
  </body>
>>>>>>> main
</html>
