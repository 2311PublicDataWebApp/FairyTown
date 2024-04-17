<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 등록 | 페어리 타운</title>
		<!-- Favicon -->
   		<link href="../resources/dist/img/close.png" rel="shortcut icon" type="image/x-icon">
		<!-- CK Editor -->
		<script src="https://cdn.ckeditor.com/ckeditor5/41.2.1/classic/ckeditor.js"></script>
		<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
		<!-- jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		
		<style>
		  .ck-editor__editable { height: 400px; }
		  .ck-content { font-size: 12px; }
		   #notice-write {
		        text-align: center; /* 등록 버튼을 중앙 정렬 */
		    }
		    #notice-write .mb-3 {
		        width: 50%; /* 제목과 첨부파일 입력창의 너비를 설정 */
		        margin: 0 auto; /* 가운데 정렬 */
		        text-align: left; /* 제목과 첨부파일을 왼쪽 정렬 */
		    }
		</style>
	</head>
	<body>
	<!-- 공통 / 헤더 -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	
	
	<div id="notice-write">
    <h1><b>공지사항 등록</b></h1>
    <br><br><br>
	    <form action="/notice/insert.ft" method="post" enctype="multipart/form-data">
	        <div class="mb-3">
	            <div class="row g-2 align-items-center">
		            <div class="col-auto">
					    <select class="form-select" name="noticeType" id="noticeType">
					        <c:forEach items="${noticeTypes}" var="type">
					            <option value="${type}">${type}</option>
					        </c:forEach>
					    </select>
					</div>
	                <div class="col">
	                    <input type="text" class="form-control" name="noticeSubject" placeholder="제목을 입력하세요">
	                </div>
	            </div>
	        </div>
	        <div class="mb-3" style="margin-top: -20px;">
	            <label for="exampleFormControlTextarea1" class="form-label"></label>
	            <textarea class="form-control" name="noticeContent" id="noticeContent" rows="6"></textarea>
	        </div>
	        <div class="mb-3">
	            <label for="inputNumber">첨부파일</label>
	            <input type="file" name="uploadFile">
	        </div>
	        <div class="d-flex justify-content-center">
	            <button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">등록</button>
	        </div>
	    </form>
	</div>
	
	
	<script type="text/javascript">
	
	var myEditor;
	
	// ClassicEditor 생성 및 myEditor 설정
	ClassicEditor
	    .create( document.querySelector( '#noticeContent' ), {  
	    	
	        ckfinder: {
	            uploadUrl: '/ck/fileupload' // 업로드 URL 지정
	        },
	        alignment: {
	            options: [ 'left', 'center', 'right' ]
	        },
	        language: 'ko' // 번역 적용
	    } )
	    .then( editor => {
	        console.log( 'Editor was initialized', editor );
	    	var matches = [], queries = {};
	    	var id, list, start;
	    	var regExp = /^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$/;
	
	    	// Take One Second for the Content Loading
	    	setTimeout(function() {
	    		
	    		editor.on('paste', function(e) {
	    			matches = e.data.dataValue.match(regExp);
	    			if ( !matches || matches[5] === 'channel' || (matches[5] !== 'watch' && matches[5].length !== 11) ) {
	    				return;
	    			}
	
	    			id = matches[5];
	    			queries = window.XE.URI(matches[0].replace(/amp\;/g, '')).search(true);
	    			list = queries.list ? '?list=' + queries.list : '';
	    			start = queries.t ? '?start=' + queries.t : '';
	    			
	    			if ( matches[5] === 'watch' ) {
	    				id = queries.v;
	    			}
	
	    			e.data.dataValue = 
	    				'<div class="youtube_converted">' +
	    					'<img src="https://img.youtube.com/vi/'+ id +'/mqdefault.jpg" />' +
	    					'<iframe src="https://www.youtube.com/embed/'+ id + list + start +'" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>' +
	    				'</div>' +
	    				'<p>&nbsp;</p>';
	    		});
	    	}, 1200);
	    } )
	    .catch( error => {
	        console.error( error );
	    } );
	
	</script>
	
	<!-- 공통 / 풋터 -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	</body>
</html>