
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- cart_list.jsp -->
<!DOCTYPE html>
<html lang="ko">
<body>
    <c:forEach var="item" items="${list}">
        <p>${item.menu_name}</p>
        <button>-</button>
        ${item.carts_quantity}<button>+</button>
        ${item.menu_price}원
        <button>X</button>
    
    </c:forEach>
      
</body>
</html>