<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>굿즈 수정</title>
		<script src="../resources/ckeditor/ckeditor.js"></script>
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
		<jsp:include page="../inc/header.jsp"></jsp:include>
		<div id="goods-modify">
			<h1><b>굿즈 수정</b></h1>
			<br><br><br>
			<form action="/goods/modify.ft" method="post" enctype="multipart/form-data">
				<input type="hidden" name="goodsCode" 		 value="${goods.goodsCode }">
				<input type="hidden" name="goodsFilename" 	 value="${goods.goodsFilename }">
				<input type="hidden" name="goodsFileRename" value="${goods.goodsFileRename }">
				<input type="hidden" name="goodsFilePath" 	 value="${goods.goodsFilePath }">
				<input type="hidden" name="goodsFileLength" value="${goods.goodsFileLength }">
				<div class="row mb-3">
					<label for="inputText" class="col-sm-2 col-form-label">상품명</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="goodsName" value="${goods.goodsName }">
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputNumber" class="col-sm-2 col-form-label">첨부파일</label>
					<div class="col-sm-10">
						<div class="box" style="padding: 4px 0 0 6px; height: 35px; border: 1px solid #DCE2E3; border-radius: 5px;">
							<span><a style="color:black;" href='../resources/guploadFiles/${goods.goodsFileRename }' download>${goods.goodsFilename }</a></span>
						</div>
							<input type="file" name="reloadFile">
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputText" class="col-sm-2 col-form-label">내용</label>
					<div class="col-sm-10">
<%-- 						<textarea class="form-control" rows="10" cols="51" name="goodsContent">${goods.goodsContent }</textarea> --%>
						<textarea class="form-control" id="editor" name="goodsContent">${goods.goodsContent }</textarea>
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputText" class="col-sm-2 col-form-label">가격</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="goodsPrice" value="${goods.goodsPrice }">
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputNumber" class="col-sm-2 col-form-label">재고</label>
					<div class="col-sm-10">
						<input type="number" class="form-control" name="goodsStock" value="${goods.goodsStock }">
					</div>
				</div>
				<br><br>
				<div class="d-flex col-md-12 justify-content-end">
					<button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">수정</button>
					<button type="button" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;" onclick="showGoodsList();">목록</button>
				</div>
			</form>
		</div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
		<script type="text/javascript">
			function showGoodsList() {
				location.href = "/goods/list.ft";
			}
		</script>
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