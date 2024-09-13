
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

				function send(f) {

					//입력값 검증
					let menu_name = f.menu_name.value.trim();
					let menu_content = f.menu_content.value.trim();
					let menu_category = f.menu_category.value.trim();
					let menu_price = f.menu_price.value.trim();

					if (menu_name == '') {
						alert("메뉴명을 입력하세요!");
						f.menu_name.value = ""; //지우기
						f.menu_name.focus();
						return;
					}

					if (menu_content == '') {
						alert("내용을 입력하세요!");
						f.menu_content.value = ""; //지우기
						f.menu_content.focus();
						return;
					}

					if (menu_category == '') {
						alert("카테고리를 입력하세요!");
						f.menu_category.value = ""; //지우기
						f.menu_category.focus();
						return;
					}
					if (menu_price == '') {
						alert("가격을 입력하세요!");
						f.menu_price.value = ""; //지우기
						f.menu_price.focus();
						return;
					}


					f.action = "modify.do"; //PhotoModifyAction
					f.submit();

				}


				//------ Ajax이용한 이미지 수정----------------------------------------------   

				function ajaxFileUpload() {
					// 업로드 버튼이 클릭되면 파일 찾기 창을 띄운다.
					$("#ajaxFile").click();
				}

				function ajaxFileChange() {
					// 파일이 선택되면 업로드를 진행한다.
					photo_upload();
				}


				// 사진 수정
				function photo_upload() {

					//파일선택->취소시
					if ($("#ajaxFile")[0].files[0] == undefined) return;


					var form = $("#ajaxForm")[0];

					var formData = new FormData(form);
					formData.append("menu_id", '${ vo.menu_id }');            //p_idx=5
					formData.append("photo", $("#ajaxFile")[0].files[0]); //photo=bmi.png

					$.ajax({
						url: "photo_upload.do", //PhotoUploadAction
						type: "POST",
						data: formData,
						processData: false,
						contentType: false,

						dataType: 'json',
						success: function (res_data) {
							//res_data = {"p_filename":"aaa.jpb"}

							//location.href=''; //자신의 페이지를 리로드(refresh)

							$("#my_img").attr("src", "../resources/images/" + res_data.p_filename);
							//$("#my_img").prop("src","../images/" + res_data.p_filename);

						},
						error: function (err) {
							alert(err.responseText);
						}
					});

				}

				function handleCheckboxChange(clickedCheckbox) {
					// 모든 체크박스 가져오기
					const checkboxes = document.querySelectorAll('input[type="checkbox"]');

					// 클릭된 체크박스 외에 모든 체크박스의 체크를 해제
					checkboxes.forEach(checkbox => {
						if (checkbox !== clickedCheckbox) {
							checkbox.checked = false;
						}
					});

					// 폼의 hidden 필드 업데이트
					updateHiddenFields();
				}

				function updateHiddenFields() {
					// 체크된 상태를 히든 필드에 반영
					const popularityCheckbox = document.getElementById('menu_popularity_edit');
					const hiddenCheckbox = document.getElementById('menu_hidden_edit');
					const soldoutCheckbox = document.getElementById('menu_soldout_edit');

					// 기본값으로 설정
					document.querySelector('input[name="menu_popularity"]').value = popularityCheckbox.checked ? '1' : '0';
					document.querySelector('input[name="menu_hidden"]').value = hiddenCheckbox.checked ? '1' : '0';
					document.querySelector('input[name="menu_soldout"]').value = soldoutCheckbox.checked ? '1' : '0';
				}

				// 페이지 로드 시 초기화
				document.addEventListener('DOMContentLoaded', updateHiddenFields);
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
												<h5 class="card-title">메뉴수정</h5>

												<!-- Floating Labels Form -->
												<form class="row g-3" method="POST" enctype="multipart/form-data">

													<input type="hidden" name="menu_id" value="${ vo.menu_id }">

													<div class="col-md-12">
														<div class="form-floating">
															<input type="text" class="form-control" placeholder="메뉴명"
																name="menu_name" value="${ vo.menu_name }">
															<label>메뉴명</label>
														</div>
													</div>

													<div class="col-md-12">
														<div class="form-floating">
															<textarea class="form-control" placeholder="메뉴설명"
																name="menu_content"
																tyle="height: 100px;">${ vo.menu_content }</textarea>
															<label>메뉴설명</label>
														</div>
													</div>

													<div class="col-md-12">
														<div class="form-floating">
															<input type="text" class="form-control" placeholder="가격"
																name="menu_price" value="${ vo.menu_price }">
															<label>가격</label>
														</div>
													</div>

													<div class="col-md-12">
														<div class="form-floating">
															<img src="../resources/images/${ vo.menu_img }" id="my_img">
															<br>
															<input class="btn  btn-info" type="button" value="이미지편집"
																onclick="ajaxFileUpload();">
															<label>사진</label>
														</div>
													</div>


													<div class="col-md-4">
														<div class="form-floating mb-3">
															<select class="form-select" id="floatingSelect"
																aria-label="State" name="menu_category">
																<!-- 옵션 목록 -->
																<option value="" disabled selected>카테고리 선택</option>
																<option value="1" ${vo.menu_category=='1' ? 'selected'
																	: '' }>임시카테고리1</option>
																<option value="2" ${vo.menu_category=='2' ? 'selected'
																	: '' }>임시카테고리2</option>
																<!-- 추가 옵션은 여기에 추가 -->
															</select>
															<label for="floatingSelect">카테고리</label>
														</div>
													</div>


													<div class="col-12">
														<div class="form-check">
															<input class="form-check-input" type="checkbox"
																name="menu_popularity" id="menu_popularity_edit"
																value="1" ${vo.menu_popularity==1 ? 'checked' : '' }
																onclick="handleCheckboxChange(this)">
															<label class="form-check-label" for="menu_popularity_edit">
																인기
															</label>
														</div>
													</div>

													<div class="col-12">
														<div class="form-check">
															<input class="form-check-input" type="checkbox"
																name="menu_hidden" id="menu_hidden_edit" value="2"
																${vo.menu_hidden==1 ? 'checked' : '' }
																onclick="handleCheckboxChange(this)">
															<label class="form-check-label" for="menu_hidden_edit">
																숨김
															</label>
														</div>
													</div>

													<div class="col-12">
														<div class="form-check">
															<input class="form-check-input" type="checkbox"
																name="menu_soldout" id="menu_soldout_edit" value="3"
																${vo.menu_soldout==1 ? 'checked' : '' }
																onclick="handleCheckboxChange(this)">
															<label class="form-check-label" for="menu_soldout_edit">
																품절
															</label>
														</div>
													</div>

													<!-- 히든 입력 필드로 기본값 제공 -->
													<input type="hidden" name="menu_popularity" value="0">
													<input type="hidden" name="menu_hidden" value="0">
													<input type="hidden" name="menu_soldout" value="0">

													<div class="text-center">
														<!-- <button type="submit" class="btn btn-primary">Submit</button>
				<button type="reset" class="btn btn-secondary">Reset</button> -->
														<input class="btn btn-success" type="button" value="목록으로"
															onclick="location.href='list.do'">

														<input class="btn btn-primary" type="button" value="수정완료"
															onclick="send(this.form);">
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
