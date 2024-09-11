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
							<h5 class="card-title">메뉴상세보기</h5>

							<!-- Floating Labels Form -->
							<form class="row g-3" method="POST" enctype="multipart/form-data">

								<input type="hidden" name="menu_id" value="${ vo.menu_id }">

								<div class="col-md-12">
									<div class="form-floating">
										<input type="text" class="form-control" placeholder="메뉴명" name="menu_name"
											value="${ vo.menu_name }" disabled>
										<label>메뉴명</label>
									</div>
								</div>

								<div class="col-md-12">
									<div class="form-floating">
										<textarea class="form-control" placeholder="메뉴설명" name="menu_content"
											tyle="height: 100px;" disabled>${ vo.menu_content }</textarea>
										<label>메뉴설명</label>
									</div>
								</div>

								<div class="col-md-12">
									<div class="form-floating">
										<input type="text" class="form-control" placeholder="가격" name="menu_price"
											value="${ vo.menu_price }" disabled>
										<label>가격</label>
									</div>
								</div>

								<div class="col-md-12">
									<div class="form-floating">
										<img src="../resources/images/${ vo.menu_img }" id="my_img">
										<br>

										<label>사진</label>
									</div>
								</div>


								<div class="col-md-4">
									<div class="form-floating mb-3">
										<select class="form-select" id="floatingSelect" aria-label="State"
											name="menu_category" disabled>
											<!-- 옵션 목록 -->
											<option value="" disabled selected>카테고리 선택</option>
											<option value="1" ${vo.menu_category=='1' ? 'selected' : '' }>임시카테고리1
											</option>
											<option value="2" ${vo.menu_category=='2' ? 'selected' : '' }>임시카테고리2
											</option>
											<!-- 추가 옵션은 여기에 추가 -->
										</select>
										<label for="floatingSelect">카테고리</label>
									</div>
								</div>
								<div class="col-12">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="menu_popularity_view"
											value="1" ${vo.menu_popularity==1 ? 'checked' : '' } disabled>
										<label class="form-check-label" for="menu_popularity_view">
											인기
										</label>
									</div>
								</div>

								<div class="col-12">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="menu_hidden_view" value="2"
											${vo.menu_hidden==1 ? 'checked' : '' } disabled>
										<label class="form-check-label" for="menu_hidden_view">
											숨김
										</label>
									</div>
								</div>

								<div class="col-12">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="menu_soldout_view" value="3"
											${vo.menu_soldout==1 ? 'checked' : '' } disabled>
										<label class="form-check-label" for="menu_soldout_view">
											품절
										</label>
									</div>
								</div>

								<div class="text-center">
									<!-- <button type="submit" class="btn btn-primary">Submit</button>
				<button type="reset" class="btn btn-secondary">Reset</button> -->
									<input class="btn btn-success" type="button" value="목록으로"
										onclick="location.href='list.do'">

									<input class="btn btn-primary" type="button" value="수정"
										onclick="location.href='modify_form.do?menu_id=${ vo.menu_id }'">
								</div>
							</form><!-- End floating Labels Form -->

						</div>
					</div>
				</div>
			</div>
		</section>

	</main><!-- End #main -->
</body>

</html>