<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<!-- CK Editor -->
<script src="https://cdn.ckeditor.com/ckeditor5/41.2.1/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- <script src="https://cdn.ckeditor.com/ckeditor5/12.4.0/classic/ckeditor.js"></script>
 --><%-- <script src="${ctx}/vendor/ckeditor/ckfinder/ckfinder.js"></script>
 --%><!-- <script type="text/javascript" src="../resources/ckeditor/ckeditor.js"></script> -->
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

    <form action="/notice/insert" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="inputText">제목</label>
            <input type="text" class="form-control" name="noticeSubject">
        </div>
        <div class="mb-3" style="width: 50%; margin: 0 auto;">
            <label for="exampleFormControlTextarea1" class="form-label"></label>
            <textarea class="form-control " name="noticeContent" id="noticeContent" rows="6"></textarea>
        </div>
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

<!-- CKEditor -->

<!-- <script type="text/javascript">
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
        myEditor = editor; // myEditor를 ClassicEditor에서 반환된 editor로 설정
        
        // 아래 코드에서 'youtube_converted' 클래스를 추가합니다.
        editor.editing.view.change(writer => {
            const conversion = editor.conversion;
            conversion.for('editingDowncast').add(dispatcher => {
                dispatcher.on('insert', (evt, data, conversionApi) => {
                    if (data.item.name === 'iframe') {
                        writer.addClass('youtube_converted').on(data.item);
                    }
                });
            });
        });
    } )
    .catch( error => {
        console.error( error );
    } );

jQuery(document).ready(function($) {
    var matches = [], queries = {};
    var id, list, start;
    var regExp = /^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$/;

    // Take One Second for the Content Loading
    setTimeout(function() {
        if(myEditor) { // myEditor가 정의되었는지 확인
            myEditor.on('paste', function(e) {
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
        }
    }, 1200);
});
</script> -->

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
        // 아래 코드에서 'youtube_converted' 클래스를 추가합니다.
//         editor.editing.view.change(writer => {
//             const conversion = editor.conversion;
//             conversion.for('editingDowncast').add(dispatcher => {
//                 dispatcher.on('insert', (evt, data, conversionApi) => {
//                     if (data.item.name === 'iframe') {
//                         writer.addClass('youtube_converted').on(data.item);
//                     }
//                 });
//             });
//         });
    } )
    .catch( error => {
        console.error( error );
    } );

</script>


<!-- <script type="text/javascript">
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
        myEditor = editor; // myEditor를 ClassicEditor에서 반환된 editor로 설정
    } )
    .catch( error => {
        console.error( error );
    } );

jQuery(document).ready(function($) {
    var matches = [], queries = {};
    var id, list, start;
    var regExp = /^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$/;

    // Take One Second for the Content Loading
    setTimeout(function() {
        if(myEditor) { // myEditor가 정의되었는지 확인
            myEditor.on('paste', function(e) {
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
        }
    }, 1200);
});
</script> -->

<!-- <script type="text/javascript">
var myEditor;
ClassicEditor
    .create( document.querySelector( '#noticeContent' ), {
    	
    /* 	cloudServices: {
            tokenUrl: 'https://example.com/cs-token-endpoint',
            uploadUrl: 'https://your-organization-id.cke-cs.com/easyimage/upload/'
        } */
        /* plugins: [ 'MediaEmbed' ], */
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
    } )
    .catch( error => {
        console.error( error );
    } );
    
jQuery(document).ready(function($) {
    var matches = [], queries = {};
    var id, list, start;
    var regExp = /^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$/;

    // Take One Second for the Content Loading
    setTimeout(function() {
        myEditor.on('paste', function(e) {
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
}); -->
</script>

<!-- 공통 / 풋터 -->
<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
</html>