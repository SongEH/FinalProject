      
        <!-- 결제정보 섹션 -->
        <%-- <div id="paymentsSection" class="section">
          <h2>결제 정보</h2>
          <table>
            <thead>
              <tr>
                <th>결제 ID</th>
                <th>주문 ID</th>
                <th>금액</th>
                <th>결제 방법</th>
                <th>결제 상태</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="payment" items="${payments}">
                <tr>
                  <td>${payment.id}</td>
                  <td>${payment.orderId}</td>
                  <td>${payment.amount}</td>
                  <td>${payment.paymentMethod}</td>
                  <td>${payment.paymentStatus}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div> -->
        
      
      <!-- 주소정보 섹션  -->
      <!-- <div id="addressesSection" class="section">
        <h2>주소 등록</h2>
        <form action="addAddress.do" method="post">
          <input type="hidden" name="memberId" value="" />
          <label for="addressLine1">주소 1:</label>
          <input
            type="text"
            id="addressLine1"
            name="addressLine1"
            required
          /><br />

          <label for="addressLine2">주소 2:</label>
          <input type="text" id="addressLine2" name="addressLine2" /><br />

          <label for="city">시/도:</label>
          <input type="text" id="city" name="city" required /><br />

          <label for="state">구/군:</label>
          <input type="text" id="state" name="state" required /><br />

          <label for="postalCode">우편번호:</label>
          <input type="text" id="postalCode" name="postalCode" required /><br />

          <label for="country">국가:</label>
          <input type="text" id="country" name="country" required /><br />

          <button type="submit">주소 등록</button>
        </form>

        <h3>등록된 주소 목록</h3>
        <table>
          <thead>
            <tr>
              <th>주소 1</th>
              <th>주소 2</th>
              <th>시/도</th>
              <th>구/군</th>
              <th>우편번호</th>
              <th>국가</th>
              <th>삭제</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="address" items="${addresses}">
              <tr>
                <td>${address.addressLine1}</td>
                <td>${address.addressLine2}</td>
                <td>${address.city}</td>
                <td>${address.state}</td>
                <td>${address.postalCode}</td>
                <td>${address.country}</td>
                <td><a href="deleteAddress.do?id=${address.id}">삭제</a></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div> -->

      <!-- 주문내역 섹션 -->
      <!-- <div id="ordersSection" class="section">
        <h2>주문 내역</h2>
        <table>
          <thead>
            <tr>
              <th>주문 ID</th>
              <th>주문 날짜</th>
              <th>상태</th>
              <th>총 금액</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="order" items="${orders}">
              <tr>
                <td>${order.id}</td>
                <td>${order.orderDate}</td>
                <td>${order.status}</td>
                <td>${order.totalAmount}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div> -->

      <!-- 장바구니 섹션 -->
      <!-- <div id="cartSection" class="section">
        <h2>장바구니</h2>
        <table>
          <thead>
            <tr>
              <th>상품 ID</th>
              <th>상품명</th>
              <th>수량</th>
              <th>가격</th>
              <th>총 금액</th>
              <th>삭제</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="item" items="${cartItems}">
              <tr>
                <td>${item.productId}</td>
                <td>${item.productName}</td>
                <td>${item.quantity}</td>
                <td>${item.price}</td>
                <td>${item.totalPrice}</td>
                <td>
                  <a href="removeFromCart.do?productId=${item.productId}"
                    >삭제</a
                  >
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table> 
      </div> 
    </div>