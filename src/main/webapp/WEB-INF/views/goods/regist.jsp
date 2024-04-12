<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>굿즈 등록</title>
		<script src="../resources/ckeditor/ckeditor.js"></script>
<!-- 		<script src="https://cdn.ckeditor.com/ckeditor5/41.2.1/classic/ckeditor.js"></script> -->
		<style type="text/css">
	        .ck-editor__editable[role="textbox"] {
				/* Editing area */
				min-height: 200px;
			}
			            
			.ck-content .image {
				/* Block images */
			    max-width: 80%;
				margin: 20px auto;
			}
        </style>
	</head>
	<body>
		<!-- 공통 / 헤더 -->
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="goods-write">
			<h1><b>굿즈 등록</b></h1>
			<br><br><br>				
			<form action="/goods/insert.ft" method="post" enctype="multipart/form-data">
				<div class="row mb-3">
					<label for="inputText" class="col-sm-2 col-form-label">상품명</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="goodsName">
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputText" class="col-sm-2 col-form-label">상품가격</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="goodsPrice">
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputText" class="col-sm-2 col-form-label">상품재고</label>
					<div class="col-sm-10">
						<input type="number" class="form-control" name="goodsStock">
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputNumber" class="col-sm-2 col-form-label">첨부파일</label>
					<div class="col-sm-10">
						<input type="file" name="uploadFile">
					</div>
				</div>        
				<div class="row mb-3">
					<label for="inputPassword" class="col-sm-2 col-form-label">굿즈 상세 설명</label>
					<div class="col-sm-10">
<!-- 						<textarea class="form-control" rows="10" cols="51" name="goodsContent"></textarea> -->
						<textarea class="form-control" id="editor" name="goodsContent"></textarea>
					</div>
				</div>
				<br><br>
				<div class="d-flex col-md-12 justify-content-end">
					<button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">등록</button>
				</div>
			</form>
		</div>
		<!-- 공통 / 풋터 -->
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script>
			 var ckeditor_config = {
			   resize_enaleb : false,
			   enterMode : CKEDITOR.ENTER_BR,
			   shiftEnterMode : CKEDITOR.ENTER_P,
			   filebrowserUploadUrl : "/goods/ckUpload"
			 };
			 
			 CKEDITOR.replace("editor", ckeditor_config);
		</script>
		
	</body>
</html>