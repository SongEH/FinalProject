<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
    <!-- iamport  -->
    <script
      type="text/javascript"
      src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"
    ></script>

<script>
       function order(form) {
            // 아이템 정보를 가져옵니다.
            alert("도착");
            let itemCards = document.querySelectorAll('.itemCard');
            orderSummary = "주문한 상품:\n";
            total = 0;
            // 주문 목록 불러오기 
            for (var i = 0; i < itemCards.length; i++) {
                itemCard = itemCards[i];
                
                let productName = itemCard.querySelector('.itemTitle h1').innerText;
                
                let productPrice = parseInt(itemCard.querySelector('.itemPrice p').getAttribute('data-price'), 10);
                
                orderSummary += "Product: " + productName + "\nPrice: $" + productPrice + "\n\n";

                alert("Product: " + productName + "\nPrice: $" + productPrice);
                
                total +=  productPrice;
            }
            alert(orderSummary);
            alert(total)
        }
</script>
</head>
<body>
    <form method="post">
        <h1>상품 목록</h1>
        <div class="itemSection">
            <div class="itemCard">
                <div class="itemTitle">
                    <h1>블루투스 노이즈캔슬링 헤드폰</h1>
                </div>
                <div class="itemContent">
                    <h2>스튜디오 원음에 가까운 고품질 사운드</h2>
                </div>
                <div class="itemPrice">
                    <!-- 금액은 dataset에 작성 -->
                    <p data-price="100">$100</p>
                </div>
            </div>
            <div class="itemCard">
                <div class="itemTitle">
                <h1>저소음 적축 키보드</h1>
                </div>
                <div class="itemContent">
                <h2>키보드 내부 흡음패드를 장착</h2>
                </div>
                <div class="itemPrice">
                <p data-price="200">$200</p>
                </div>
            </div>
            <div class="itemCard">
                <div class="itemTitle">
                <h1>49인치 게이밍 모니터</h1>
                </div>
                <div class="itemContent">
                <h2>퀀텀 매트릭스 기술로 완성한 궁극의 화질</h2>
                </div>
                <div class="itemPrice">
                <p data-price="300">$300</p>
                </div>
            </div>
            <div class="itemButton">
                <input type="button" value="주문" onclick="order(this.form)">
        </div>
    </form>
</body>
</html>
