<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>

		<!--  Bootstrap  3.x  -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

		<style type="text/css">
			#box {
				width: 600px;
				margin: auto;
				margin-top: 100px;
			}

			textarea {
				resize: none;
			}

			th {
				width: 15%;
				vertical-align: middle !important;
			}
		</style>

		<script type="text/javascript">
			function send(f) {

				//입력값 검증
				let menu_name = f.menu_name.value.trim();
				let menu_content = f.menu_content.value.trim();
				let menu_category = f.menu_category.value.trim();
				let menu_price = f.menu_price.value.trim();
				let photo = f.photo.value;

				if (menu_name == '') {
					alert("메뉴명을 입력하세요!");
					f.menu_name.value = ""; //지우기
					f.menu_name.focus();
					return;
				}

				if (menu_content == '') {
					alert("메뉴설명을 입력하세요!");
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

				if (photo == '') {
					alert("사진을 선택하세요!");
					return;
				}


				//f.method = "POST";
				f.action = "insert.do";//전송대상(PhotoInsertAction)
				f.submit(); //전송
			}
		</script>


	</head>

	<body>

		<form method="POST" enctype="multipart/form-data">
			<div id="box">

				<div class="panel panel-primary">
					<div class="panel-heading">
						<h4>메뉴 등록</h4>
					</div>
					<div class="panel-body">

						<table class="table">
							<tr>
								<th>메뉴명</th>
								<td><input class="form-control" name="menu_name"></td>
							</tr>

							<tr>
								<th>메뉴설명</th>
								<td>
									<textarea class="form-control" rows="6" name="menu_content"></textarea>
								</td>
							</tr>

							<tr>
								<th>카테고리</th>
								<td><input class="form-control" name="menu_category"></td>
							</tr>

							<tr>
								<th>가격</th>
								<td><input class="form-control" name="menu_price"></td>
							</tr>

							<tr>
								<th>사진</th>
								<td><input class="form-control" type="file" name="photo"></td>
							</tr>

							<!-- 인기여부 -->
							<tr>
								<th>인기여부</th>
								<td>
									<input type="checkbox" id="menu_popularity" name="menu_popularity" value="1">
									<label for="menu_popularity">인기</label>
									<input type="hidden" name="menu_popularity" value="0">
								</td>
							</tr>

							<!-- 숨김여부 -->
							<tr>
								<th>숨김여부</th>
								<td>
									<input type="checkbox" id="menu_hidden" name="menu_hidden" value="1">
									<label for="menu_hidden">숨김</label>
									<input type="hidden" name="menu_hidden" value="0">
								</td>
							</tr>

							<!-- 품절여부 -->
							<tr>
								<th>품절여부</th>
								<td>
									<input type="checkbox" id="menu_soldout" name="menu_soldout" value="1">
									<label for="menu_soldout">품절</label>
									<input type="hidden" name="menu_soldout" value="0">
								</td>
							</tr>

							<tr>
								<td colspan="2" align="center">

									<input class="btn btn-success" type="button" value="메인화면"
										onclick="location.href='list.do'">

									<input class="btn btn-primary" type="button" value="메뉴등록"
										onclick="send(this.form);">

								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</form>
	</body>

	</html>