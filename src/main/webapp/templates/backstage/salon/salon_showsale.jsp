<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.web.salonSale.model.*"%>
<%@ page import="com.web.salonSale.model.entities.*"%>
<%@ page import="com.web.salonSale.model.services.*"%>
<%@ page import="com.web.salonSale.model.dao.*"%>
<%@ page import="com.web.salonSale.model.dao.impl.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>IPET 寵物 | 美容專區 | 優惠總覽</title>
  	<!-- Google Font: Source Sans Pro -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
	<!-- Font Awesome Icons -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/backstage/plugins/fontawesome-free/css/all.css">
	<!-- IonIcons -->
	<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/backstage/css/adminlte.css">
	<!-- summernote -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/backstage/plugins/summernote/summernote-bs4.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
	<!-- addsevice and updateservice css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/backstage/css/alt/salon_addservice.css">
<style>
/* ================== 預約導覽列 ====================*/
    .card-header {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      padding: 0;

    }

    .card-change {
      text-align: center;
      padding-top: 12px;
      padding-bottom: 12px;
      border: 0;
      background-color: rgb(230, 230, 230, 0);
    }

    .card-change:first-child {
      border-radius: 0.25rem 0 0 0;
    }

    .card-change:last-child {
      border-radius: 0 0.25rem 0 0;
    }

    .card-change:hover {
      cursor: pointer;
      background-color: rgb(230, 230, 230);
    }

    .card-change.on {
      background-color: #007bff;
      color: aliceblue;
      /* border-bottom: 3px solid #007bff; */
    }

   /* ============ 彈出視窗-優惠選擇服務 =============*/
	#addSaleBox {
/*  		display: none;  */
		position: fixed;
		z-index: 9998;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		overflow: auto;
		background-color: rgba(0,0,0,0.4);
		box-sizing: border-box;
	}
	
	/* 	 彈出視窗本人 */
	.main-modal-content {
		background-color: #fafafa;
		margin: 3% auto;
		border: 1px solid #888;
		width: 1000px;
		height: 87%;
	}
	
	/* 	叉叉 */
	#modalClose {
		float: right;
	    font-size: 22px;
	    padding: 5px;
	    margin: 15px 25px;
	    color: #939393;
	}
	
	#modalClose:hover {
		cursor: pointer;
	}
</style>
	</head>
	<body class="hold-transition sidebar-mini">
	<div class="wrapper">
	
	  <!--  Navbar -->
	  <%@ include file="/templates/backstage/common/navbar.jsp" %>
	  <!-- /.navbar -->
	
	  <!-- 左邊選單區 Main Sidebar Container -->
	  <%@ include file="/templates/backstage/common/sidebar.jsp" %>
	  <!-- /.aside -->
	  
	  <!-- ====================== 彈出視窗 ========================= -->
	  	<div id="addSaleBox" style="overflow-y: hidden;">
			<div class="main-modal-content" style="overflow-y: scroll;">
				<i class="nav-icon fas fa-sharp fa-solid fa-times" id="modalClose"></i>
				
		<!-- 快速查詢 -->
				<div style="padding: 35px;">
				<div style="border-radius: 0.25rem; margin: 20px 0;">
						<!-- card-body -->
						<div class="card-body" style="display: none;">
						</div>
							<input type="text" id="searchSvc" placeholder="快速查詢..." style="border: 1px solid #d2d2d2; width: 100%; height: 40px; padding-left: 10px;">
				</div>
						<!-- /.card-body -->
				
			<!-- datatable -->	
					<table id="example" class="table table-bordered table-hover">
						<thead style="background-color: #6c757d; color: white;">
							<tr>
								<th></th>
								<th style="width: 90px;">服務編號</th>
								<th>服務名稱</th>
								<th>服務類別</th>
								<th>寵物種類</th>
								<th>服務單價</th>
								<th>狀態</th>
							</tr>
						</thead>
						<tfoot>
						</tfoot>
					</table>
					<input type="button" class="service-submit" value="新增服務" id="submitAll">
				</div>
			</div>
		</div>
	  <!-- ====================== /彈出視窗 ========================= -->
	  
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<!-- <h3 style="margin-top: .6rem;">新增美容服務</h3> -->
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/ipet-back/home">Home</a></li>
								<li class="breadcrumb-item active"><a href="${pageContext.request.contextPath}/ipet-back/service/allService">美容專區</a></li>
								<li class="breadcrumb-item active">新增美容服務</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

<c:if test="${not empty errorMsgs}">
	<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
	<c:forEach var="message" items="${errorMsgs}">
		<div style="color: red">${message.value}</div>
	</c:forEach>
</c:if>

	<a href="${pageContext.request.contextPath}/ipet-back/salonSale/addSale">新增優惠</a>
	  <!-- Main content -->
      <section class="content">
        <div class="container-fluid">
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-header">
                  <button class="card-change on" value="優惠總覽" id="apm">優惠總覽</button>
                  <button class="card-change" value="優惠中" id="apm0">優惠中</button>
                  <button class="card-change" value="未開始" id="apm1">未開始</button>
                  <button class="card-change" value="已結束" id="apm2">已結束</button>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                  <table id="example2" class="table table-bordered table-hover">
                    <thead>
                      <tr>
                        <th>編號</th>
                        <th>優惠名稱</th>
                        <th>優惠開始時間</th>
                        <th>優惠結束時間</th>
                        <th>狀態</th>
                      </tr>
                    </thead>
                    <tfoot>
                    </tfoot>
                  </table>
                </div>
                <!-- /.card-body -->
              </div>
              <!-- /.card -->
            </div>
            <!-- /.col -->
          </div>
          <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
      </section>
      <!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<!-- Main Footer -->
		<%@ include file="/templates/backstage/common/footer.jsp" %>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->

	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE -->
	<script src="${pageContext.request.contextPath}/static/backstage/js/adminlte.js"></script>

	<!-- DataTables  & Plugins -->
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/jszip/jszip.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/pdfmake/pdfmake.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/pdfmake/vfs_fonts.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/buttons.print.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
	<!-- Summernote -->
	<script src="${pageContext.request.contextPath}/static/backstage/plugins/summernote/summernote-bs4.min.js"></script>
	<!-- Navbar script-->
	<script>
    $(function () {
      $("#Mynavbar").load("../../navbar_pages.html");
      
		console.log(${sales});
    })
  </script>

	<!-- Footer script-->
	<script>
    $(function () {
      $("#Myfooter").load("../../footer.html");
    })
  </script>
	<!-- Page specific script -->
	<script>
    $(function () {
    	
    	const datatable = $('#example2').DataTable({
    		"dom": "tp",
            "paging": true,
            "lengthChange": false,
            "ordering": true,
            "autoWidth": false,
            "responsive": true,
            "data": ${sales},
            "columns" : [
	            { data: "saleId", responsivePriority: 1 },
	            { data: null,
	            	render: function(data, type){
	            		return data.saleName + `<div style="font-size: 10px; margin-top: 10px;">` + data.salContent + `</div>`;
	            	},
	            	responsivePriority: 2
	            },
	            { data: "startTime", 
	            	render: function(data, type){
	            		const string = data.toString();
	            		const startSpaceStr = string.indexOf("-");
	            		const startDate = string.substring(0, startSpaceStr);
	            		const startTime = string.substring(startSpaceStr + 1);
	            		return startDate + `<br>` + startTime;
	            	},
	            	responsivePriority: 5
	            },
	            { data: "endTime", 
	            	render: function(data, type){
	            		const string = data.toString();
	            		const startSpaceStr = string.indexOf("-");
	            		const startDate = string.substring(0, startSpaceStr);
	            		const startTime = string.substring(startSpaceStr + 1);
	            		return startDate + `<br>` + startTime;
	            	},
	            	responsivePriority: 4
	            },
	            { data: "saleStatus", 
	            	responsivePriority: 3,
	            	className: "saleStatus"
	            },
	            { data: null,
	            	render: function(data, type){
	            		if(data.saleStatus === "未開始" || data.saleStatus === "優惠中"){
		            		return `
			            		<form METHOD="post" ACTION="${pageContext.request.contextPath}/ipet-back/salonSale/editSale">
									<input type="hidden" name="saleId" value=` + data.saleId + `>
									<label><i class="nav-icon fas fa-solid fa-pen"></i>
										<input type="submit" style="display: none;">
									</label>
								</form>
		            		`;
	            		}else if(data.saleStatus === "已結束"){
	            			return null;
	            		}
	            	},
	            	responsivePriority: 6
	            },
	            { data: null,
	            	render: function(data, type){
	            		if(data.saleStatus === "未開始"){
	            			return `
			            		<form METHOD="post" ACTION="${pageContext.request.contextPath}/ipet-back/salonSale/deleteSale">
									<input type="hidden" name="saleId" value=` + data.saleId + `>
									<label><i class="nav-icon fas fa-solid fa-trash"></i>
										<input type="submit" style="display: none;">
									</label>
								</form>
	            			`;
	            		}else if(data.saleStatus === "已結束" || data.saleStatus === "優惠中"){
	            			return null;
	            		}
	            	},
	            	responsivePriority: 7
	            }
	        ],
			language: {
		           "sProcessing": "查詢中...",
		           "sLengthMenu": "顯示 _MENU_ 項服務",
		           "sZeroRecords": "查無資料",
		           "sInfoPostFix": "",
		           "sUrl": "",
		           "sEmptyTable": "尚未新增服務",
		           "sLoadingRecords": "載入中...",
		           "sInfoThousands": ",",
		           "oPaginate": {
		               "sFirst": "第一頁",
		               "sPrevious": "上一頁",
		               "sNext": "下一頁",
		               "sLast": "最後一頁"
		           },
		     }
          });
    	
    	/*===================== 切換狀態 ==========================*/
    	
    	$(document).on("click", "#apm", function(){
    		datatable.columns(".saleStatus").search("").draw();
    	});
    	
    	$(document).on("click", "#apm0", function(){
    		datatable.columns(".saleStatus").search("優惠中").draw();
    	});
    	
    	$(document).on("click", "#apm1", function(){
    		datatable.columns(".saleStatus").search("未開始").draw();
    	});
    	
    	$(document).on("click", "#apm2", function(){
    		datatable.columns(".saleStatus").search("已結束").draw();
    	});
    	
    	/*===================== 預約導覽列變色 ==========================*/
    	$(".card-change").on("click", function () {
            $(".card-header").children("*").removeClass("on");
            $(this).addClass("on");
        });
    	
    	/*===================== 彈出視窗 ==========================*/
		const mainModal = document.getElementById("mainModal");

		//點擊按鈕時打開彈出視窗
// 		$("#mainBtn").click(function() {
// 			mainModal.style.display = "block";
// 			document.body.style.overflow = "hidden";
// 		});
    	
		$("tbody tr").click(function() {
    			/*========== 顯示預約詳細 =============*/
				const OneApm = datatable.row(this).data();
    			console.log(OneApm);
    	});
	
    })
		
  </script>
</body>
</html>