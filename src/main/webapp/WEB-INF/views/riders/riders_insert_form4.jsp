<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Final Project</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 400px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .header h5 {
            margin: 0;
            font-size: 18px;
            font-weight: bold;
        }
        .form-group label {
            font-size: 14px;
            font-weight: bold;
            color: #333;
        }
        .form-control {
            border-radius: 5px;
            height: 45px;
        }
        .btn-primary {
            background-color: #333;
            border-color: #333;
            width: 100%;
            height: 50px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 10px;
            position: relative;
        }
        .btn-primary:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            border: 2px solid #FF0066;
            border-radius: 10px;
            pointer-events: none;
        }
        .close-button {
            font-size: 20px;
            cursor: pointer;
        }
        @media (max-width: 576px) {
            .container {
                margin: 20px auto;
                padding: 15px;
            }
            .header h5 {
                font-size: 16px;
            }
            .form-control {
                height: 40px;
                font-size: 14px;
            }
            .btn-primary {
                height: 45px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Step 2: Bank Account Information -->
        <div class="header">
            <h5></h5>
            <span class="close-button" onclick="window.history.back();">&times;</span>
        </div>
        <form >
            <div class="form-group">
                <label for="bankOwner">수수료를 정상 받을 계좌 정보를 입력해 주세요</label>
                <input type="text" class="form-control" id="bankOwner" name="bankOwner"  readonly>
            </div>
            <div class="form-group">
                <label for="bankName">은행</label>
                <select class="form-control" id="bankName" name="bankName" required>
                  
                    <option value="국민은행">국민은행</option>
                    <option value="우리은행">우리은행</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <div class="form-group">
                <label for="accountNumber">계좌번호</label>
                <input type="text" class="form-control" id="accountNumber" name="accountNumber"  required>
            </div>
            <button type="submit" class="btn btn-primary mt-4" onclick="location.href='insert_form.do5'">다음</button>
        </form>
    </div>
</body>
</html>