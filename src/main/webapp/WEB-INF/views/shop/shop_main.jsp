<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Cafe Menu</title>
    <!-- Bootstrap CSS -->
    <link
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background-color: #f8f9fa;
        /* font-family: "Arial", sans-serif; */
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
        background-color: steelblue;
      }

      @media (min-width: 768px) {
        body {
          background-color: burlywood;
        }
      }

      @media (min-width: 992px) {
        body {
          background-color: brown;
        }
      }

      @media (min-width: 1200px) {
        body {
          background-color: chartreuse;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <input
        type="button"
        value="가게등록"
        onclick="location.href='/shop/insert_form.do'"
      />

      <header class="text-center my-5">
        <h1>Cafe Delight</h1>
        <p class="lead">Your favorite place for coffee and snacks</p>
      </header>
      <nav></nav>

      <div class="menu-section">
        <h2>Hot Beverages</h2>
        <div class="row">
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Espresso <span class="price">$3.00</span></h5>
            <p>Rich and bold espresso shot.</p>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Cappuccino <span class="price">$4.50</span></h5>
            <p>Espresso, hot milk, and steamed milk foam.</p>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Latte <span class="price">$4.00</span></h5>
            <p>Espresso and steamed milk.</p>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Hot Chocolate <span class="price">$3.50</span></h5>
            <p>Hot cocoa topped with whipped cream.</p>
          </div>
        </div>
      </div>

      <div class="menu-section">
        <h2>Cold Beverages</h2>
        <div class="row">
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Iced Coffee <span class="price">$3.50</span></h5>
            <p>Chilled coffee served over ice.</p>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Iced Latte <span class="price">$4.50</span></h5>
            <p>Chilled espresso and milk over ice.</p>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Smoothie <span class="price">$5.00</span></h5>
            <p>Fresh fruit blended with yogurt.</p>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Iced Tea <span class="price">$2.50</span></h5>
            <p>Freshly brewed iced tea.</p>
          </div>
        </div>
      </div>

      <div class="menu-section">
        <h2>Snacks</h2>
        <div class="row">
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Croissant <span class="price">$2.50</span></h5>
            <p>Buttery, flaky croissant.</p>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Muffin <span class="price">$2.00</span></h5>
            <p>Freshly baked blueberry muffin.</p>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Scone <span class="price">$2.75</span></h5>
            <p>Classic scone with clotted cream.</p>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 menu-item">
            <h5>Bagel <span class="price">$2.00</span></h5>
            <p>Served with cream cheese.</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  </body>
</html>
