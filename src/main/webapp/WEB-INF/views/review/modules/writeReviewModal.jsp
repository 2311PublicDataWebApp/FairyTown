<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="writeReviewModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <!-- 본문 입력 영역 -->
            <div class="modal-header">
                <h5 class="modal-title">리뷰 작성하기</h5>
<!--                 <button type="button" class="close" data-dismiss="modal">&times;</button> -->
            </div>
            <div class="modal-body">
                <!-- 본문 입력 영역 -->
                <form action="/review/insert.ft" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                    
             <input type="hidden" name="realName" value="${user.realName }">
             <input type="hidden" name="userId" value="${user.userId }">
                    
                    
                        <div class="row g-2 align-items-center">
                            <div class="col-auto">
                                <select class="form-select" name="ticketType" id="ticketType">
                                    <c:forEach items="${ticketTypes}" var="type">
                                        <option value="${type}">${type}</option>
                                    </c:forEach> 
                                </select>
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" name="reviewTitle" placeholder="제목을 입력하세요">
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="reviewContent" class="form-label"></label>
                        <textarea class="form-control" name="reviewContent" id="reviewContent" rows="6" style="resize: none;"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="uploadFiles" class="form-label">파일 첨부 (최대 3개까지 선택)</label>
                        <input type="file" name="uploadFiles" id="uploadFiles" multiple>
                    </div>
                    <div class="d-flex justify-content-center">
                        <button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">등록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>