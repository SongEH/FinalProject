<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

	<style type="text/css">
		#box {
			width: 600px;
			margin: auto;
			margin-top: 50px;
		}

		textarea {
			width: 100%;
			resize: none;
		}

		input[type='button'] {
			width: 100px;
		}

		img {
			width: 200px;
		}
	</style>


	<script type="text/javascript">


	</script>



</head>

<body>

	<%@include file="../common.jsp" %>

	<!-- header import -->
	<%@include file="../header.jsp" %>

	<!-- side bar import -->
	<%@include file="../sidebar.jsp" %>



	<!--화일업로드용 폼  -->
	<form enctype="multipart/form-data" id="ajaxForm" method="post">
		<input id="ajaxFile" type="file" style="display:none;" onChange="ajaxFileChange();">
	</form>




	<main id="main" class="main">

		<div class="pagetitle">

			<h1>Form Layouts</h1>

			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item">Forms</li>
					<li class="breadcrumb-item active">Layouts</li>
				</ol>
			</nav>

		</div><!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-10">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">주문 상세보기</h5>
									${ vo.orders_id }
                  ${ vo.orders_name }
                  ${ vo.orders_price }
                  ${ vo.shop_name }
						</div>
					</div>
				</div>
			</div>
		</section>

	</main><!-- End #main -->
</body>

</html>