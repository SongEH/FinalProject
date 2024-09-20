<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- cart_list.jsp -->
<!DOCTYPE html>
<html lang="ko">
<script>
    function deleteItem(cartsId) {
        // AJAX 요청으로 carts_id를 컨트롤러로 전송
        $.ajax({
            url: '/carts/delete2.do', // URL을 적절히 설정
            type: 'POST',
            data: {
                carts_id: cartsId
            },
            success: function (response) {
                // 성공적으로 삭제되었을 경우 처리
                alert("삭제되었습니다.");
                location.reload(); // 페이지 새로고침
            },
            error: function (xhr, status, error) {
                alert("삭제에 실패했습니다: " + xhr.responseText);
            }
        });
    }
</script>

<body>
    <c:forEach var="item" items="${list}">
        <p>${item.menu_name}</p>
        <button>-</button>
        ${item.carts_quantity}<button>+</button>
        ${item.menu_price}원
        <button onclick="deleteItem('${item.carts_id}')">X</button>

    </c:forEach>

</body>

</html>