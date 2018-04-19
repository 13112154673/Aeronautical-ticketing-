<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<!-- 日期插件 -->
<script src="layDate-v5.0.9/laydate/laydate.js"></script>

<title>航空票务管理系统</title>

<style>
/* 图片样式 */
.box {
	border: 1px solid gray;
	width: 500px;
	padding: 0px;
	margin: 0px;
}

body {
	padding-top: 30px;
}

/* 搜索框样式 */
.align-center {
	position: absolute;
	top: 60%;
	height: 240px;
	margin-top: -60px; /* negative half of the height */
	background-color: #EFEFEF
}
</style>
</head>

<body>
	<!-- 顶部导航栏 -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="text-right">
			<button class="btn btn-info"
				onclick="javascrtpt:window.location.href='index.jsp'">首页</button>
			<c:choose>
				<c:when test="${onlinePassenger==null}">
					<button class="btn btn-success"
						onclick="javascrtpt:window.location.href='Passenger/jumpLogin'">登陆</button>
					<button class="btn btn-default"
						onclick="javascrtpt:window.location.href='Passenger/jumpRegister'">注册</button>
				</c:when>
				<c:otherwise>
					<button class="btn btn-success"
						onclick="javascrtpt:window.location.href='Passenger/jumpInformation'">个人</button>
					<button class="btn btn-default"
						onclick="javascrtpt:window.location.href='Passenger/logout'">注销</button>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>

	<!-- 飞机图片 -->
	<div class="box">
		<img alt="" src="image/航空.jpg" height="264" width="1350" />
	</div>

	<div class="align-center">
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-4 column">
					<ul id="myTab" class="nav nav-tabs">
						<li class="active"><a href="#findflight" data-toggle="tab">
								预定航班 </a></li>
						<li><a href="#findticket" data-toggle="tab">查询机票</a></li>
					</ul>

					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade in active" id="findflight">
							<form action="CreatTicket/detailedSearch" method="post">
								<table class="table table-hover" id="table1">
									<tbody>
										<tr>
											<td>出发地点:<input type="text" class="form-control"
												name="departurePlace" id="departurePlace"></td>
											<td>到达地点:<input type="text" class="form-control"
												name="arrivalPlace" id="arrivalPlace"></td>
										</tr>
										<tr>
											<td>出发时间:<input type="text" class="form-control"
												id="departureTime" name="departureTime"></td>
											<td>&nbsp;<input type="submit" class="btn btn-block"
												style="background: white; border-color: #C0C0C0" value="确认"
												onclick="return notempty()" /></td>
										</tr>

									</tbody>
								</table>
							</form>
						</div>
						<div class="tab-pane fade" id="findticket">
							&nbsp;<br> 
							请输入机票编号：<br>
							&nbsp;<br> 
							<div class="input-group">
								<input type="text" class="form-control" id="findTicketByTId" name="findTicketByTId">
								<div class="input-group-btn">
									<button type="button" class="btn btn-default" data-toggle="modal"
								data-target="#myModal" onclick="return findDate(this)">查找</button>
								</div>
							</div>
						</div>


						<div style="height: 200px"></div>
					</div>
				</div>
				<!-- 通知说明栏 -->
				<div class="col-md-4 column">
					<div class="panel-group" id="panel-543132">
						<div class="panel panel-default">
							<div class="panel-heading">
								<a class="panel-title " href="#panel-element-653283"
									data-toggle="collapse" data-parent="#panel-543132">购票须知</a>
							</div>
							<div class="panel-collapse in" id="panel-element-653283">
								<div class="panel-body">
									退票：起飞前24小时以前收不超过10%的退票费起飞前22以内2小时以前收10%的退票费，起飞前2小时以内收20%的退票费<br />
									改签：同等舱位更改是指所更改的航班的航空公司和舱位都相同
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<a class="panel-title collapsed" href="#panel-element-58817"
									data-toggle="collapse" data-parent="#panel-543132">出行注意</a>
							</div>
							<div class="panel-collapse collapse" id="panel-element-58817">
								<div class="panel-body">注意安全</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 模态框，弹出根据机票编号查找到的机票页面 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">查询机票</h4>
				</div>
				<div class="modal-body">
					机票编号：<input type="text" class="form-control" id="tId">
					机票信息：
					<table id="tickettable">
						<tbody>
        
							<tr>
								<td>出发地点:<input type="text" class="form-control"
									id="finddeparturePlace" disabled="disabled"></td>
								<td>到达地点:<input type="text" class="form-control"
									id="findarrivalPlace" disabled="disabled"></td>
							</tr>
							<tr>
								<td>出发时间:<input type="text" class="form-control"
									id="finddepartureTime" disabled="disabled"></td>
								<td>到达时间:<input type="text" class="form-control"
									id="findarrivalTime" disabled="disabled"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>

				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
<script>
	//三个输入框都不能为空
	function notempty() {
		var departurePlace=document.getElementById("departurePlace").value;
		var	arrivalPlace=document.getElementById("arrivalPlace").value;
		var	departureTime=document.getElementById("departureTime").value;
		
		if ("" == departurePlace || "" == arrivalPlace || "" == departureTime) {
			alert("信息未填完整");
			return false;
		}
	}
	//查询机票
	function findDate(obj) {
		var tId = document.getElementById("findTicketByTId").value;
		$('#tId').val(tId);

		$.ajax({
			type : "post",
			dataType : "json",
			url : "CreatTicket/findTicketByTId",
			data : {
				tId : tId
			},
			success : function(data) {
				
				$('#finddeparturePlace').val(data["departurePlace"]);
				$('#findarrivalPlace').val(data["arrivalPlace"]);
				$('#finddepartureTime').val(data["departureTime"]);
				$('#findarrivalTime').val(data["arrivalTime"]);
				
			},
			error : function() {
				$('#myModal').modal('hide');
				alert("查询失败,未找到该机票");
				
			}
		});
	};
	//YY-MM-DD
	laydate.render({
		elem : '#departureTime' //指定元素
	});
</script>
</html>



