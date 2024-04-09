<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<!-- CK Editor -->
<script src="https://cdn.ckeditor.com/ckeditor5/41.2.1/classic/ckeditor.js"></script>
<script src="${ctx}/vendor/ckeditor/ckfinder/ckfinder.js"></script>
<script type="text/javascript" src="../resources/ckeditor/ckeditor.js"></script>
<style>
  .ck-editor__editable { height: 400px; }
  .ck-content { font-size: 12px; }
  
</style>	
<!-- 부트스트랩 CSS CDN 링크 -->
<!--     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
</head>
<body>
<!-- 공통 / 헤더 -->
<jsp:include page="../inc/header.jsp"></jsp:include>

<div id="notice-write">
    <h1><b>공지사항 등록</b></h1>
    <br><br><br>

    <form action="/notice/insert" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="inputText">제목</label>
            <input type="text" class="form-control" name="noticeSubject">
        </div>
        <div class="mb-3" style="width: 50%; margin: 0 auto;">
            <label for="exampleFormControlTextarea1" class="form-label"></label>
            <textarea class="form-control " name="noticeContent" id="noticeContent" rows="6"></textarea>
       </div>
       <script>
       CKEDITOR.replace( 'noticeContent', {//해당 이름으로 된 textarea에 에디터를 적용
           width:'100%',
           height:'400px',
           filebrowserUploadUrl:  "fileupload.do"
       });
       </script>
       
		       <!-- CKEditor 이미지 저-->
		<script type="text/javascript">
		var myEditor;
		ClassicEditor
			.create( document.querySelector( '#review_editor' ), {
				ckfinder: {
			        uploadUrl: '/ck/fileupload' // 내가 지정한 업로드 url (post로 요청감)
				},
				alignment: {
		            options: [ 'left', 'center', 'right' ]
		        }
			} )
			.then( editor => {
		        console.log( 'Editor was initialized', editor );
		        myEditor = editor;
		    } )
			.catch( error => {
			    console.error( error );
			} );
		</script>
       
        <div class="mb-3">
            <label for="inputNumber">첨부파일</label>
            <input type="file" name="uploadFile">
        </div>
        <div class="d-flex justify-content-end">
            <button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">등록</button>
        </div>
    </form>
</div>


<!-- 부트스트랩 JavaScript CDN 링크 (jQuery 포함) -->
<!--     <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
	<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>     <script>
      ClassicEditor.create( document.querySelector( '#noticeContent' ) );
    </script>
<!-- 공통 / 풋터 -->
<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>