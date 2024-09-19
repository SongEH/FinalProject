<%@ page language="java" contentType="text/html; charset=UTF-8"
<<<<<<< HEAD
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
      /* *{
        border: 1px solid grey
      } */
      .container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: auto;
        margin-top: 5%;
      }

      body {
        background-color: #f8f9fa;
        font-family: "Arial", sans-serif;
      }

      .menu-section {
        margin-bottom: 40px;
      }

      .menu-item {
        margin-bottom: 20px;
      }

      .menu-item h5 {
        font-weight: bold;
      }

      .menu-item p {
        margin-bottom: 0;
      }

      .price {
        float: right;
        font-weight: bold;
      }
    </style>

    <style>
      body {
        background-color: rgb(92, 161, 218);
      }

      @media (min-width: 768px) {
        body {
          background-color: rgb(235, 221, 203);
        }
      }

      @media (min-width: 992px) {
        body {
          background-color: rgb(221, 162, 162);
        }
      }

      @media (min-width: 1200px) {
        body {
          background-color: rgb(195, 228, 163);
        }
      }

      .menu-item:hover {
        cursor: pointer;
      }
    </style>
  </head>

  <body>
    <%@include file="common.jsp" %>

    <!-- header import -->
    <%@include file="header.jsp" %>

    <!-- side bar import -->
    <%@include file="sidebar.jsp" %>

    <h1>메인 페이지</h1>
    카테고리를 선택하는 화면이 있어야됨
  </body>
</html>
=======
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <style>
    /* *{
        border: 1px solid grey
      } */
    .container {
      display: flex;
      justify-content: center;
      align-items: center;
      margin: auto;
      margin-top: 5%;
    }

    body {
      background-color: #f8f9fa;
      font-family: "Arial", sans-serif;
    }

    .menu-section {
      margin-bottom: 40px;
    }

    .menu-item {
      margin-bottom: 20px;
    }

    .menu-item h5 {
      font-weight: bold;
    }

    .menu-item p {
      margin-bottom: 0;
    }

    .price {
      float: right;
      font-weight: bold;
    }
  </style>

  <style>
    body {
      background-color: rgb(92, 161, 218);
    }

    @media (min-width: 768px) {
      body {
        background-color: rgb(235, 221, 203);
      }
    }

    @media (min-width: 992px) {
      body {
        background-color: rgb(221, 162, 162);
      }
    }

    @media (min-width: 1200px) {
      body {
        background-color: rgb(195, 228, 163);
      }
    }

    .menu-item:hover {
      cursor: pointer;
    }
  </style>
  
</head>

<body>
  <%@include file="common.jsp" %>

  <!-- header import -->
  <%@include file="header.jsp" %>

  <!-- side bar import -->
  <%@include file="sidebar.jsp" %>

  <h1>메인 페이지</h1>
  카테고리를 선택하는 화면이 있어야됨



</body>

</html>
>>>>>>> main
