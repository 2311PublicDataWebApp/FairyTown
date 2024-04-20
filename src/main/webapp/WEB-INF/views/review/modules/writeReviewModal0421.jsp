<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div id="writeReviewModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <!-- 좌측 영역: Swiper 영역 -->
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">
                                <!-- 슬라이드 추가 -->
                                <div class="swiper-slide">Slide 1</div>
                                <div class="swiper-slide">Slide 2</div>
                                <div class="swiper-slide">Slide 3</div>
                            </div>
                            <!-- 추가적인 Swiper 컨트롤러 등을 넣을 수 있음 -->
                            <div class="swiper-pagination"></div>
                            <div class="swiper-button-prev"></div>
                            <div class="swiper-button-next"></div>
                        </div>
                    </div>
                    <!-- 우측 영역: 본문 입력 영역 -->
                    <div class="col-md-6">
                        <div class="modal-header">
                            <h5 class="modal-title">리뷰 작성하기</h5>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <!-- 본문 입력 영역 -->
                            <form action="/review/insert.ft" method="post" enctype="multipart/form-data">
                                <div class="mb-3">
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
                                    <label for="exampleFormControlTextarea1" class="form-label"></label>
                                    <textarea class="form-control" name="reviewContent" id="reviewContent" rows="6"></textarea>
                                </div>
                                <div>
                                	<input type="file" name="uploadFile">
                                </div>
                                <div class="d-flex justify-content-center">
                                    <button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">등록</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>