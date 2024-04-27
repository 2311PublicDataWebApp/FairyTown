<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>블랙리스트 상세 조회</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header bg-dark text-white">
                <h2>블랙리스트 회원 정보</h2>
            </div>
            <div class="card-body">
                <ul class="list-group">
                    <li class="list-group-item">
                        <strong>아이디</strong>
                        <span class="float-right">${blackList.userId}</span>
                    </li>
                    <li class="list-group-item">
                        <strong>정지일</strong>
                        <span class="float-right">${blackList.regiDate}</span>
                    </li>
                    <li class="list-group-item">
                        <strong>정지 종료일</strong>
                        <span class="float-right">${blackList.stopDate}</span>
                    </li>
                    <li class="list-group-item">
                        <strong>정지 사유</strong>
                        <span class="float-right">${blackList.reason}</span>
                    </li>
                </ul>
            </div>
            <div class="card-footer text-right">
                <button class="btn btn-secondary" onclick="window.close();">닫기</button>
            </div>
        </div>
    </div>
</body>
</html>