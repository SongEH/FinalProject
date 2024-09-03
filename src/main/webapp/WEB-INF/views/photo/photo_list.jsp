<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	body {
		font-family: Arial, sans-serif;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		margin: 0;
		background-color: #f9f9f9;
	}
	.login-container {
		width: 300px;
		padding: 20px;
		background-color: white;
		border-radius: 8px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		text-align: center;
	}
	.login-container h1 {
		color: #33C7CC;
		margin-bottom: 20px;
	}
	.login-container input[type="email"], .login-container input[type="password"] {
		width: 100%;
		padding: 10px;
		margin: 10px 0;
		border: 1px solid #ddd;
		border-radius: 4px;
	}
	.login-container button {
		width: 100%;
		padding: 10px;
		background-color: #33C7CC;
		border: none;
		border-radius: 4px;
		color: white;
		font-size: 16px;
		cursor: pointer;
	}
	.login-container button:hover {
		background-color: #33C7CC;
	}
	.login-container .link {
		margin-top: 20px;
		font-size: 14px;
	}
	.login-container .link a {
		color: #33C7CC;
		text-decoration: none;
	}
</style>

</head>
<body>
  

  
	<div class="login-container">
        <h1>RIDER LOGIN</h1>
        <form action="">
            <input type="email" name="email" placeholder="이메일" required>
            <input type="password" name="password" placeholder="비밀번호" required>
            <button type="submit">로그인</button>
        </form>
        <div class="link">
            <input  class="btn btn-info" type="button"  value="회원가입" 
            onclick="location.href='insert_form.do'">
        </div>
    </div>
</body>
  
</body>
</html>