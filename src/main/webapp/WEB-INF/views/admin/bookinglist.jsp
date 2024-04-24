<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 놀이기구 예약관리</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- DataTables -->
	<link rel="stylesheet" href="../../resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" href="../../resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
	<link rel="stylesheet" href="../../resources/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
	<style>
	.modal {
	  display: none; /* 초기에는 모달 숨김 */
	  position: fixed;
	  z-index: 1;
	  left: 0;
	  top: 0;
	  width: 100%;
	  height: 100%;
	  overflow: auto;
	  background-color: rgb(0,0,0);
	  background-color: rgba(0,0,0,0.4); /* 투명도 조절 */
	}
	
	.modal-content {
	  background-color: #fefefe;
	  margin: 10% auto; /* 모달이 화면 중앙에 위치하도록 */
	  padding: 20px;
	  border: 1px solid #888;
	  width: 40% !important;
	}
	
	.close {
	  color: #aaa;
	  float: right;
	  font-size: 28px;
	  font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	  color: black;
	  text-decoration: none;
	  cursor: pointer;
	}
</style>
</head>
<body>
	<jsp:include page="../inc/adminheader.jsp"></jsp:include>
	<!-- Content Header -->
	<div class="content-wrapper">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>놀이기구 예약관리</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="../../admin.ft">Home</a></li>
              <li class="breadcrumb-item active">DataTables</li>
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
                <table id="dataTable" class="table table-bordered table-hover">
                  <thead>
                  <tr>
                    <th>예약번호</th>
                    <th>회원아이디</th>
                    <th>예약 놀이기구</th>
                    <th>예약날짜</th>
                    <th>예약한 날짜</th>
                    <th>예약인원</th>
                  </tr>
                  </thead>
                  <tbody>
				  <c:forEach items="${bList }" var="bList">
                  
                  <tr>
                    <td>${bList.bookingNumber }</td>
                    <td>${bList.userId }</td>
                    <td>${bList.rideId }</td>
                    <td>${bList.bookingDate }</td>
					<td>${bList.bookingTime }</td>
					<td>${bList.bookingPeople }</td>
                  </tr>
                  
                  </c:forEach>
                  </tbody>
                  <tfoot>
                  <tr>
                    <th>예약번호</th>
                    <th>회원아이디</th>
                    <th>예약 놀이기구</th>
                    <th>예약날짜</th>
                    <th>예약한 날짜</th>
                    <th>예약인원</th>
                  </tr>
                  </tfoot>
                  </table>
              </div>
			</div>	
		</div>
	</div>
</div>
</section>
</div>
<div id="myModal" class="modal">
  <div class="modal-content">
    
  </div>
</div>
<jsp:include page="../inc/adminfooter.jsp"></jsp:include>
<!-- DataTables  & Plugins -->
<script src="../../resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../../resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="../../resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="../../resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="../../resources/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="../../resources/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="../../resources/plugins/jszip/jszip.min.js"></script>
<script src="../../resources/plugins/pdfmake/pdfmake.min.js"></script>
<script src="../../resources/plugins/pdfmake/vfs_fonts.js"></script>
<script src="../../resources/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="../../resources/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="../../resources/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>

<!-- <script src="../../resources/plugins/datatables-select/js/dataTables.select.js"></script> -->
<!-- <script src="../../resources/plugins/datatables-select/js/dataTables.select.min.js"></script> -->
<!-- <script src="../../resources/plugins/datatables-select/js/select.bootstrap4.js"></script> -->
<!-- <script src="../../resources/plugins/datatables-select/js/select.bootstrap4.min.js"></script> -->

<script>
  $(function () {
    $('#dataTable').DataTable({
    	
		"paging": true,
		"lengthChange": false,
		"searching": true,
		"ordering": true,
		"info": true,
		"autoWidth": true,
		"responsive": true,
// 		"select": true,
		
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
$('tbody tr').on('click', function() {
    var bookingNumber = $(this).find('td:first').text();
    $.ajax({
        url: '../../admin/booking/detail.ft',
        type: 'GET',
        data: { bookingNumber: bookingNumber },
        success: function(data) {
            var modalContent = $('.modal-content');
            modalContent.empty(); // 기존 내용 지우기
            
            // VO 데이터를 HTML로 생성하여 모달에 추가
            var str = "";
            str += "<div class='ticket-info'>";
            str += '<span class="close">&times;</span>';
            str += '<p>예약번호: ' + data.bookingNumber + '</p>';
            str += '<p>회원아이디: ' + data.userId + '</p>';
            str += '<p>예약한 티켓코드: ' + data.ticketCode + '</p>';
            str += '<p>예약한 놀이기구: ' + data.rideId + '</p>';
            str += '<p>예약날짜: ' + data.bookingDate + '</p>';
            str += '<p>예약한 날짜: ' + data.bookingTime + '</p>';
            str += '<p>예약인원: <input type="number" value="'+ data.bookingPeople +'">명</p>';
            str += '<button type="button" id="deleteButton">삭제하기</button>';
            str += '<button type="button" id="updateButton">수정하기</button>';
            str += "</div>";

            modalContent.append(str);
            
            // 닫기 버튼에 이벤트 리스너 추가
            $('.close').on('click', function() {
                $('#myModal').css('display', 'none');
            });

            // 모달 표시
            $('#myModal').css('display', 'block');
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });
});

// 모달 외부 클릭시 닫기
window.addEventListener('click', function(event) {
  var modal = document.getElementById('myModal');
  if (event.target == modal) {
    modal.style.display = 'none';
  }
});
//수정하기 버튼 클릭 이벤트 처리
$(document).on('click', '#updateButton', function() {
    // 모달 창에서 가져옴
    var bookingPeople = $('.modal-content').find('input[type="number"]').val();
	var bookingNumber = $('.modal-content').find('p:contains("예약번호")').text().split(': ')[1];

    $.ajax({
        url: '/admin/booking/update.ft?bookingNumber=' + bookingNumber + '&bookingPeople=' + bookingPeople,
        type: 'POST',
        success: function(response) {
            $('.modal-content').find('p:eq(6) input').val(bookingPeople);
            window.location.reload();
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });
});

$(document).on('click', '#deleteButton', function() {
    var bookingNumber = $('.modal-content').find('p:contains("예약번호")').text().split(': ')[1];
    
    if (confirm('정말로 삭제하시겠습니까?')) {
        $.ajax({
            url: '/admin/booking/delete.ft?bookingNumber=' + bookingNumber,
            type: 'POST',
            success: function() {
                window.location.reload();
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
    } else {}
});

</script>
</body>
</html>