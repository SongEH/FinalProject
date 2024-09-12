<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>게시글 조회</title>
</head>
<body>
    <!-- <input type="hidden" name="board_id" value="${vo.board_id}">

    <h1>공지사항&문의 내역</h1>

    <h3>공지사항</h3>
    <table border="1"></table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일자</th>
                <th>작성자</th>
                <th>타입</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="board" items="${list}">
                <c:if test="${board.board_type == 'notice'}">
                    <tr>
                        <td><c:out value="${board.board_id}"/></td>
                        <td>
                            <a href="<c:url value='/board/detail.do?board_id=${board.board_id}'/>">
                                <c:out value="${board.board_title}"/>
                            </a>
                        </td>
                        <td><c:out value="${board.board_rdate}"/></td>
                        <td>관리자</td>
                        <td><c:out value="${board.board_type}"/></td>
                    </tr>
                </c:if>
            </c:forEach>
        </tbody>
    </table>

    <h2>일반 게시글</h2>
    <table border="1">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일자</th>
                <th>작성자</th>
                <th>타입</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="board" items="${list}">
                <c:if test="${board.boardType != 'notice'}">
                    <tr>
                        <td><c:out value="${board.boardId}"/></td>
                        <td>
                            <a href="<c:url value='/board/detail.do?board_id=${board.boardId}'/>">
                                <c:out value="${board.boardTitle}"/>
                            </a>
                        </td>
                        <td><c:out value="${board.boardRdate}"/></td>
                        <td>사용자</td>
                        <td><c:out value="${board.boardType}"/></td>
                    </tr>
                </c:if>
            </c:forEach>
        </tbody>
    </table>

    <br/>
    <a href="<c:url value='/boards/new'/>">새 게시글 작성</a>
    <a href="<c:url value='/home'/>">홈으로 돌아가기</a> -->

</body>
</html>