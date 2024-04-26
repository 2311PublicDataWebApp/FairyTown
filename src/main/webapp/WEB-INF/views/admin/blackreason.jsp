<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 등록</title>
<!-- 최신 버전의 부트스트랩 CDN 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>블랙리스트 등록</h2>
    <form action="/admin/blackRegister.ft" method="post">
    <input type="hidden" id="blackUserInput" name="blackUser" value="">
        <div class="form-group">
            <label>정지 처리</label>
            <select name="stopDate" class="form-control">
                <option value="1">1개월</option>
                <option value="3">3개월</option>
                <option value="6">6개월</option>
                <option value="0">영구정지</option>
            </select>
        </div>
        <div class="form-group">
            <label>정지 사유</label>
            <textarea rows="5" class="form-control" name="reason"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">등록</button>
        <a href="javascript:void(0);" class="btn btn-secondary" onclick="window.close();">취소</a>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    // 기존 JavaScript 코드는 변경 없음
    var urlParams = new URLSearchParams(window.location.search);
    var blackUserValue = urlParams.get('blackUser');
    if (blackUserValue !== null) {
        document.getElementById("blackUserInput").value = blackUserValue;
    } else {
        console.log("blackUser 매개변수가 없습니다.");
    }
    
    var closeWindow = "<c:out value='${closeWindow}'/>";
    if(closeWindow === 'null' || closeWindow === ''){
        closeWindow = 'false';
    }
    if (closeWindow === 'true') {
        window.close();
    }
</script>
</body>
</html>
