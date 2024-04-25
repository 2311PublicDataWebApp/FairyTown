<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 수정</title>
	<script src="https://cdn.ckeditor.com/ckeditor5/41.2.1/classic/ckeditor.js"></script>
		<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
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
	<!-- DataTables -->
	<link rel="stylesheet" href="../resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" href="../resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
	<link rel="stylesheet" href="../resources/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
</head>
<body>
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>
	<!-- Content Header -->
	<div class="content-wrapper">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>굿즈 수정</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">굿즈샵 상품 관리</a></li>
              <li class="breadcrumb-item active">굿즈 수정</li>
            </ol>
          </div>
        </div>
      </div>
    </section>
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
			<div class="card-body">
                <div id="goods-modify">
			<br><br><br>
			<form action="/admin/goodsModify.ft" method="post" enctype="multipart/form-data">
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
						<textarea class="form-control" id="goodsContent" name="goodsContent">${goods.goodsContent }</textarea>
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
					<button type="button" class="btn" style="background-color: #FAFAFA; margin-right:10px; border-color: #e9ecef;" onclick="GoodsList();">목록</button>
					<button type="submit" class="btn" style="background-color: #FAFAFA; border-color: #e9ecef;">수정</button>
				</div>
			</form>
		</div>
              </div>
			</div>	
		</div>
	</div>
</div>
</section>
</div>
<jsp:include page="../inc/adminfooter.jsp"></jsp:include>
<!-- DataTables  & Plugins -->
<script src="../resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="../resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="../resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="../resources/plugins/jszip/jszip.min.js"></script>
<script src="../resources/plugins/pdfmake/pdfmake.min.js"></script>
<script src="../resources/plugins/pdfmake/vfs_fonts.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="../resources/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
<script>
	function GoodsList() {
		location.href = "/admin/goodsList.ft";
	}
</script>
<script>
  $(function () {
    $('#example2').DataTable({
		"paging": true,
		"lengthChange": false,
		"searching": true,
		"ordering": true,
		"info": true,
		"autoWidth": true,
		"responsive": true,
		
		language: {
		    "decimal": "",
		    "emptyTable": "테이블에 데이터가 없습니다",
		    "info": "_TOTAL_개 항목 중 _START_부터 _END_까지 표시중",
		    "infoEmpty": "0개 항목 중 0부터 0까지 표시중",
		    "infoFiltered": "(_MAX_개 항목 중 필터링됨)",
		    "infoPostFix": "",
		    "thousands": ",",
		    "lengthMenu": "_MENU_개 항목 표시",
		    "loadingRecords": "로딩 중...",
		    "processing": "처리 중...",
		    "search": "검색:",
		    "zeroRecords": "일치하는 레코드를 찾을 수 없습니다",
		    "paginate": {
		        "first": "처음",
		        "last": "마지막",
		        "next": "다음",
		        "previous": "이전"
		    },
		    "aria": {
		        "orderable": "이 열을 정렬하려면 클릭",
		        "orderableReverse": "이 열을 역순으로 정렬하려면 클릭"
		    }
	    }
    });
  });
</script>
<script>
		var myEditor;
		
		ClassicEditor
		    .create( document.querySelector( '#goodsContent' ), {  
		    	
		        ckfinder: {
		            uploadUrl: '/goods/ckUpload'
		        },
		        alignment: {
		            options: [ 'left', 'center', 'right' ]
		        },
		        language: 'ko'
		    } )
		    .then( editor => {
		        console.log( 'Editor was initialized', editor );
		    	var matches = [], queries = {};
		    	var id, list, start;
		    	var regExp = /^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$/;
		
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
</body>
</html>