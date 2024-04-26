<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 티켓 결제관리</title>
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
            <h1>티켓 결제관리</h1>
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
                    <th>티켓코드</th>
                    <th>회원아이디</th>
                    <th>예약일</th>
                    <th>구입일</th>
                    <th>결제금액</th>
                    <th>결재상태</th>
                  </tr>
                  </thead>
                  <tbody>
				  <c:forEach items="${tingList}" var="ting">
                  
                  <tr>
                    <td>${ting.ticketingCode }</td>
                    <td>${ting.userId }</td>
                    <td>${ting.reservationDate }</td>
                    <td>${ting.purchaseDate }</td>
					<td><fmt:formatNumber value="${ting.purchasePrice}" pattern="###,### 원"/></td>
					<td>${ting.purchaseSuccess == 'C' ? '취소됨' : '결제됨'}</td>
                  </tr>

                  </c:forEach>
                  </tbody>
                  <tfoot>
                  <tr>
                    <th>티켓코드</th>
                    <th>회원아이디</th>
                    <th>예약일</th>
                    <th>구입일</th>
                    <th>결제금액</th>
                    <th>결재상태</th>
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
<!-- 모달 내용 -->
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
    var ticketingCode = $(this).find('td:first').text();
    $.ajax({
        url: '../../admin/ticketing/detail.ft',
        type: 'GET',
        data: { ticketingCode: ticketingCode },
        success: function(data) {
            var modalContent = $('.modal-content');
            modalContent.empty(); // 기존 내용 지우기
            
            // VO 데이터를 HTML로 생성하여 모달에 추가
            var str = "";
            str += "<div class='ticket-info-left'>";
            str += '<span class="close">&times;</span>';
            str += '<p>구입 티켓 코드: ' + data.ticketingCode + '</p>';
            str += '<p>티켓 이름: ' + data.ticket.ticketName + '</p>';
            str += '<p>구매자 아이디: ' + data.userId + '</p>';
            str += '<p>예약 날짜: ' + data.reservationDate + '</p>';
            str += '<p>구매 날짜: ' + data.purchaseDate + '</p>';
            str += "</div>";
            str += "<div class='ticket-info-right'>";
            str += '<p>성인 인원: ' + data.adult + '</p>';
            str += '<p>청소년 인원: ' + data.teenager + '</p>';
            str += '<p>어린이 인원: ' + data.child + '</p>';
            str += '<p>구매 가격: ' + data.purchasePrice.toLocaleString() + '원</p>';
            str += '<p>구매 성공 여부: ' + data.purchaseSuccess + '</p>';
            str += '<p>아임포트 UID: ' + data.impUid + '</p>';
            str += '<p>상인 UID: ' + data.merchantUid + '</p>';
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

</script>
</body>
</html>