<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 결과</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom CSS for additional styling */
        body {
            padding: 20px;
        }
        .result-container {
            max-width: 500px;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            background-color: #f9f9f9;
        }
        #close{
        	text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="result-container">
            <h2>아이디 찾기 결과</h2>
            <p class="lead">
            	찾은 아이디 : ${user.userId}
            </p>
        </div>
        <br>
        <div class="text-center"> <!-- 버튼을 가운데 정렬 -->
            <button id="close" class="btn btn-outline-danger" onclick="window.close();">닫기</button>
        </div>
    </div>
</body>
</html>