<!-- <%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>경로 확인</title>
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_KAKAO_MAP_API_KEY"
    ></script>
    <style>
      #map {
        width: 100%;
        height: 400px;
      }
    </style>
  </head>
  <body>
    <h2>배달 경로</h2>
    <div id="map"></div>

    <script type="text/javascript">
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div
          mapOption = {
              center: new kakao.maps.LatLng(${shopLat}, ${shopLng}), // 지도의 중심좌표
              level: 5 // 지도의 확대 레벨
          };

      var map = new kakao.maps.Map(mapContainer, mapOption);

      // 마커가 표시될 위치
      var shopPosition = new kakao.maps.LatLng(${shopLat}, ${shopLng});
      var customerPosition = new kakao.maps.LatLng(${customerLat}, ${customerLng});

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
    </script>
  </body>
</html> -->
