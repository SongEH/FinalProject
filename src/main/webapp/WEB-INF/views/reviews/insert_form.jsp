<%@ page language='java' contentType='text/html; charset=UTF-8'
pageEncoding='UTF-8'%>
<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN''http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
    fieldset{
        display: inline-block;
        direction:rtl;
        border: 0;
    }
    fieldset legend{
        text-align: right;
    }
    fieldset input[type=radio]{
        display: none;
    }
    fieldset label{
        font-size: 3em;
        color: transparent;
        text-shadow: 0 0 0 #f0f0f0;
    }
    label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
    }
    label:hover ~ label{
        text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
    }
    input[type=radio]:checked ~ label{
        text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
    }
    #reviewContents {
        width: 100%;
        height: 150px;
        padding: 10px;
        box-sizing: border-box;
        border: solid 1.5px #D3D3D3;
        border-radius: 5px;
        font-size: 16px;
        resize: none;
    }
</style>
</head>
<body>
    <div class="container">
        <form method="post" enctype="multipart/form-data">
        <div>가게 이름</div>
        <hr>
        <div>주문 메뉴 이름</div>
        <hr>
        <div>이 가게를 추천하시겠어요?</div>
        <fieldset>
            <span class="text-bold">별점을 선택해주세요</span>
            <input type="radio" name="reviewStar" value="5" id="rate1"><label
                for="rate1">★</label>
            <input type="radio" name="reviewStar" value="4" id="rate2"><label
                for="rate2">★</label>
            <input type="radio" name="reviewStar" value="3" id="rate3"><label
                for="rate3">★</label>
            <input type="radio" name="reviewStar" value="2" id="rate4"><label
                for="rate4">★</label>
            <input type="radio" name="reviewStar" value="1" id="rate5"><label
                for="rate5">★</label>
        </fieldset>
        <div>상세한 리뷰를 남겨주세요</div>
        <div>
            <textarea class="col-auto form-control" type="text" id="reviewContents"
                      placeholder="리뷰를 남기면 적립금을 드립니다."></textarea>
        </div>
        <div>
            <input type="file" name="review_img">
        </div>
        <div>
            <input type="button" value="등록완료" onclick="">
        </div>
    </form>
    </div>
</body>
</html>