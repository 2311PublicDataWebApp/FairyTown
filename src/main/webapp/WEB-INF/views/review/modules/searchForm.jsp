<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 검색</title>
    <!-- 여기에 필요한 CSS 파일들을 링크하세요 -->
</head>
<body>
    <div class="d-flex col-md-6 justify-content-start">
        <form class="row g-1" action="/review/search.ft" method="get">
            <div class="col-auto">
                <select class="form-select" name="searchCondition">
                    <option value="all" selected>전체</option>
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="tickettype">티켓 유형</option>
                </select>
            </div>
            <div class="col-auto">
                <div class="input-group">
                    <input class="form-control" type="search" name="searchKeyword">
                    <button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">검색</button>
                </div>
            </div>
        </form>
    </div>
    <!-- 여기에 필요한 JavaScript 파일들을 링크하세요 -->
</body>
</html>