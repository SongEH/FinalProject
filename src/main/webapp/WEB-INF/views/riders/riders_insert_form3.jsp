<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Insert title here</title>
	<style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
        }
        .title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
        }
        .button-group button {
            width: 48%;
            padding: 15px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .button-group button:hover {
            background-color: #555;
        }
        .location-select, .method-select {
            margin-bottom: 20px;
        }
        .options {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .options button {
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            cursor: pointer;
        }
        .options button.selected {
            background-color: #ccc;
            border-color: #999;
        }
		
    </style>
   
  </head>
  <body>
	<div class="container">
        <div class="location-select">
            <div class="title">배달 희망 지역을 선택해 주세요</div>
            <div class="options">
                <button>서울</button>
                <button>경기</button>
				<button>인천</button>
            </div>
        </div>

        <div class="method-select">
            <div class="title">배달 수단을 선택해 주세요</div>
            <div class="options">
                <button>오토바이</button>
                <button>자전거</button>
				<button>자동차</button>
				<button>도보</button>
            </div>
        </div>

        <div class="button-group">
            <button>이전</button>
            <button  onclick="location.href='insert_form.do4'" >다음</button>
        </div>
    </div>
  </body>
</html>