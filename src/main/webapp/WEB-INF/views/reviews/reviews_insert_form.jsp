<%@ page language='java' contentType='text/html; charset=UTF-8'
pageEncoding='UTF-8'%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN''http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>Insert title here</title>
  <link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
  rel="stylesheet"
  />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
fieldset {
  display: inline-block;
  direction: rtl;
  border: 0;
}
fieldset legend {
  text-align: right;
}
fieldset input[type="radio"] {
  display: none;
}
fieldset label {
  font-size: 3em;
  color: transparent;
  text-shadow: 0 0 0 #f0f0f0;
}
label:hover {
  text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
label:hover ~ label {
  text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
input[type="radio"]:checked ~ label {
  text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewContents {
  width: 100%;
  height: 150px;
  padding: 10px;
  box-sizing: border-box;
  border: solid 1.5px #d3d3d3;
  border-radius: 5px;
  font-size: 16px;
  resize: none;
}
</style>
<style>
  /* Style for the square container */
.camera-square {
  width: 150px;
  height: 150px;
  background-color: #f0f0f0;
  display: flex;
  justify-content: center;
  align-items: center;
  border: 2px solid #333;
  border-radius: 8px;
  cursor: pointer;
  position: relative;
  left:42.5%;
}

  /* Simple camera shape using CSS */
.camera-icon {
  width: 60px;
  height: 40px;
  background-color: #333;
  position: relative;
  border-radius: 5px;
}

.camera-icon::before {
  content: "";
  width: 20px;
  height: 10px;
  background-color: #333;
  position: absolute;
  top: -15px;
  left: 20px;
  border-radius: 3px;
}

.camera-icon::after {
  content: "";
  width: 20px;
  height: 20px;
  background-color: #fff;
  position: absolute;
  top: 10px;
  left: 20px;
  border-radius: 50%;
  border: 2px solid #333;
}

    /* Style for the hidden file input */
#file-input {
  display: none;
}


#reviews_info{
    align-items: center;
    text-align:center;
}
#reviews_info textarea {
    margin: 0 auto;
    display: block;
}
.reviews_feature{
    margin-top: 30px;
}
.shop_name{
    font-size: 20px;
    font-weight: bold;
}
.menu_name{
    font-size: 20px;
    color: #F0A8D0;
}
</style>

<script>
  function reviews_insert(f){
    // let shop_name = document.querySelector("div[name='shop_name']").textContent.trim();
    // let menu_name = document.querySelector("div[name='menu_name']").textContent.trim();
    let reviews_rating = f.reviews_rating.value;
    // alert(reviews_rating);
    let reviews_content = f.reviews_content.value.trim();
    // alert(reviews_content);
    let orders_id = f.orders_id.value;
    // alert(orders_id)

    if(reviews_rating==""){
      alert("별점은 선택은 필수입니다.");
      return;
    }

    if(reviews_content ==""){
      alert("리뷰는 필수 입력사항입니다.");
      f.reviews_content.value="";
      f.reviews_content.focus();
      return;
    }
    

    f.action="insert.do";
    f.submit();
  }
</script>
<script>
  function fileCount() {
    let fileInput = document.getElementById('file-input');
    let fileCountDisplay = document.getElementById('file-count');
    let imgsWrap = document.querySelector('.imgs_wrap'); // Define imgsWrap

    let fileCount = fileInput.files.length;

    // Clear previous images
    imgsWrap.innerHTML = "";

    if (fileCount > 2) {
        alert("최대 2개의 파일만 선택할 수 있습니다.");
        fileInput.value = ""; // Reset the file input
        fileCountDisplay.textContent = ''; // Reset the file count display
    } else if (fileCount > 0) {
        fileCountDisplay.textContent = "선택된 파일:" + fileCount + "개";
        
        // Loop through each file
        for (let i = 0; i < fileCount; i++) {
            let file = fileInput.files[i];
            let reader = new FileReader();

            // When the file is read, create the image element
            reader.onload = function (e) {
                let img = document.createElement("img");
                img.src = e.target.result;
                img.style.width = "200px";  // Set width for preview
                img.style.height = "200px"; // Set height for preview
                img.style.margin = "10px";  // Add some spacing between images
                imgsWrap.appendChild(img);  // Append the image to the container
            };

            reader.readAsDataURL(file); // Read the file as a data URL
        }
    } else {
        fileCountDisplay.textContent = ''; // No files selected
    }
}
</script>
</head>
<body>
    <div class="container" style="width: 1000px; margin-top: 100px">
        <form method="post" enctype="multipart/form-data">
            <input type="hidden" name="orders_id" value="${vo.orders_id}"/>
            <div id="reviews_info">
                <div name="shop_name" class="reviews_feature shop_name"><strong>${vo.shop_name}</strong></div>
                <hr />
                <div name="menu_name" class="reviews_feature menu_name">${vo.orders_name}</div>
                <hr />
                <div class="reviews_feature" >이 가게를 추천하시겠어요?</div>
                <fieldset class="reviews_feature"  >
                    <span class="text-bold">별점을 선택해주세요</span>
                    <input type="radio" name="reviews_rating" value="5" id="rate1" />
                    <label for="rate1">★</label>
                    <input type="radio" name="reviews_rating" value="4" id="rate2" />
                    <label for="rate2">★</label>
                    <input type="radio" name="reviews_rating" value="3" id="rate3" />
                    <label for="rate3">★</label>
                    <input type="radio" name="reviews_rating" value="2" id="rate4" />
                    <label for="rate4">★</label>
                    <input type="radio" name="reviews_rating" value="1" id="rate5" />
                    <label for="rate5">★</label>
                </fieldset>
                <div class="reviews_feature" >상세한 리뷰를 남겨주세요</div>
                <div class="reviews_feature">
                    <textarea name="reviews_content" class="col-auto form-control" type="text"
                    id="reviewContents" placeholder="리뷰를 남기면 다른 고객에게 큰 도움이 됩니다."></textarea>
                </div>
            </div>
            <!-- File Input Image -->
            <label for="file-input" class="camera-square reviews_feature">
                <div class="camera-icon reviews_feature"></div>
            </label>
            
            <!-- File Input -->
            <input class="reviews_feature" name="photo" type="file" id="file-input"  multiple onchange="fileCount()"/>
            <div style="text-align: center; margin-top: 10px;">이미지는 최대 2대까지만 등록 가능합니다.</div>
            <div id="file-list" class="file_list"></div>

            <div class="reviews_feature" style="text-align: center;">
                <span id="file-count"></span>
                <div class="imgs_wrap" style="align-items: center;">
                    <img id="img"/>
                </div>
                <input type="button" value="등록완료" onclick="reviews_insert(this.form);" />
            </div>
        </form>
    </div>
</body>
</html>
