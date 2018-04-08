<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- Bootstrap需要JQuery才能正常工作，所以需要导入jquery.min.js
	接着是 Bootstrap的css，里面定义了各种样式
	最后是 Bootstrap的js，用于产生交互效果，比如关闭警告框 -->
<link href="../css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="../js/jquery/2.0.0/jquery.min.js"></script>
<script src="../js/bootstrap/3.3.6/bootstrap.min.js"></script>
<!-- 日期插件 -->
<script src="../layDate-v5.0.9/laydate/laydate.js"></script>

<title>个人信息</title>
</head>
<!-- 贴在顶部(不会消失） -->
<style>
body {
	padding-top: 70px;
}
</style>
<body>
	<!-- 贴在顶部(不会消失） -->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="text-right">
		<button class="btn btn-info"
			onclick="javascrtpt:window.location.href='../index.jsp'">首页</button>

	</div>
	</nav>
	<div class="panel-group" id="accordion" role="tablist"
		aria-multiselectable="true">
		<div class="panel panel-info">
			<div class="panel-heading" role="tab" id="headingOne">
				<h4 class="panel-title">
					<a role="button" data-toggle="collapse" data-parent="#accordion"
						href="#collapseOne" aria-expanded="true"
						aria-controls="collapseOne"> 个人信息 </a>
				</h4>
			</div>
			<div id="collapseOne" class="panel-collapse collapse in"
				role="tabpanel" aria-labelledby="headingOne">
				<div class="panel-body">
					<form action="updateInformation?phone=${onlinePassenger.phone}"
						method="post">
						<legend class="text-center">基本信息</legend>
						名字：<input type="text" name="pName" id="pName"
							value="${onlinePassenger.pName}"><br /> 性别:男<input
							type="radio" checked="checked" name="sex" value="man"> 女<input
							type="radio" name="sex" value="woman"> <br /> 居住城市:<input
							type="text" name="city" value="${onlinePassenger.city}">
						<br /> 生日:<input type="text" name="brithday"
							id="test1" value="<fmt:formatDate value="${onlinePassenger.brithday}" pattern="yyyy-MM-dd"/>"> <br />

						<legend class="text-center">安全信息</legend>
						身份证:<input type="text" name="pId" value="${onlinePassenger.pId}">
						<br /> 密码:<input type="text" name="password"
							value="${onlinePassenger.password}"><br />

						<legend class="text-center">联系方式</legend>
						手机号码:<input name="phone" id="phone" type="text"
							value="${onlinePassenger.phone}" disabled="true"> <br />
						电子邮箱:<input type="text" name="email"
							value="${onlinePassenger.email}"> <br />

						性别：${onlinePassenger.sex}<br /> <input type="submit" value="修改">
						<input type="reset" value="重置">
					</form>
				</div>
			</div>
		</div>
		<div class="panel panel-info">
			<div class="panel-heading" role="tab" id="headingTwo">
				<h4 class="panel-title">
					<a class="collapsed" role="button" data-toggle="collapse"
						data-parent="#accordion" href="#collapseTwo" aria-expanded="false"
						aria-controls="collapseTwo"> 查看当前机票 </a>
				</h4>
			</div>
			<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel"
				aria-labelledby="headingTwo">
				<div class="panel-body">
					<table class="table table-hover" id="table1">
						<thead>
							<th>序号</th>
							<th>机票编号</th>
							<th>乘客</th>
							<th>性别</th>
							<th>航班号</th>
							<th>航空公司</th>
							<th>飞机编号</th>
							<th>出发时间</th>
							<th>出发地点</th>
							<th>到达时间</th>
							<th>到达地点</th>
							<th>操作</th>
						</thead>
						<tbody>
							<c:forEach items="${ticketCompleteslist}" var="d" 
								varStatus="status">
								<tr id="${status.index+1}">
									<td>${status.index+1}</td>
									<td>${d.tId }</td>
									<td>${d.passenger.pName }</td>
									<td>${d.passenger.sex }</td>
									<td>${d.flight.fId }</td>
									<td>${d.aircraft.company }</td>
									<td>${d.aircraft.aId }</td>
									<td><fmt:formatDate value="${d.flight.departureTime }" pattern="MM-dd HH:mm"/></td>
									<td>${d.flight.departurePlace }</td>
									<td><fmt:formatDate value="${d.flight.arrivalTime }" pattern="MM-dd HH:mm"/></td>
									<td>${d.flight.arrivalPlace }</td>
									<c:choose>
									<c:when test="${d.state==0}">
									<td><button class="btn btn-primary " data-toggle="modal" data-target="#myModal1" onclick="editDate(this)">改签</button>
										<button class="btn btn-primary " data-toggle="modal" data-target="#myModal2" onclick="returnTicket(this)">退票</button></td>
									</c:when>
									<c:otherwise>
										<td>服务处理中</td>
									</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 模态框1，改签页面 -->
		<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">改签</h4>
					</div>
					<div class="modal-body">
						<div id="updateFlightDate"></div>
						<div id="updateFlightresult">
							<input type="text" id="test2" name="updatedepartureTime">
							<button onclick="findFlightBydate()">查询</button> <br />
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" id="submit1" class="btn btn-primary">提交更改</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<!-- 模态框2，退票页面 -->
		<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">退票</h4>
					</div>
					<div class="modal-body" >
						退订机票编号：<input type="text" class="form-control" id="tId2" disabled="true">
						退票理由：<textarea  class="form-control" ></textarea>
					</div>
					<div class="modal-footer" >
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary"  data-dismiss="modal" onclick=returnTicketRequest(this)>提交</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>


		<div class="panel panel-info">
			<div class="panel-heading" role="tab" id="headingThree">
				<h4 class="panel-title">
					<a class="collapsed" role="button" data-toggle="collapse"
						data-parent="#accordion" href="#collapseThree"
						aria-expanded="false" aria-controls="collapseThree"> 历史航班 </a>
				</h4>
			</div>
			<div id="collapseThree" class="panel-collapse collapse"
				role="tabpanel" aria-labelledby="headingThree">
				<div class="panel-body">
					<table class="table table-hover">
						<thead>
							<th>机票编号</th>
							<th>乘客</th>
							<th>性别</th>
							<th>航班号</th>
							<th>航空公司</th>
							<th>飞机编号</th>
							<th>出发时间</th>
							<th>出发地点</th>
							<th>到达时间</th>
							<th>到达地点</th>
						</thead>
						<tbody>
							<c:forEach items="${ticketCompleteslist}" var="d"
								varStatus="status">
								<tr>
									<td class="ticketsId">${d.tId }</td>
									<td class="passengerName">${d.passenger.pName }</td>
									<%-- <td>${d.cargoCount }</td> --%>
									<td class="passengerSex">${d.passenger.sex }</td>
									<td class="flightId">${d.flight.fId }</td>
									<td class="aircraftCompany">${d.aircraft.company }</td>
									<td class="aircraftId">${d.aircraft.aId }</td>
									<td class="flightDepartureTime">${d.flight.departureTime }</td>
									<td class="flightDeparturePlace">${d.flight.departurePlace }</td>
									<td class="flightArrivalTime">${d.flight.arrivalTime }</td>
									<td class="flightArrivalPlace">${d.flight.arrivalPlace }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	//改签模态框
	function editDate(obj){  
		//console.log($(obj).parents("table")[0]);//获得tr当前行,输出在浏览器的控制台.直接找到父节点
		var line=$(obj).parents("tr")[0].id;//获得当前行的行号
		var table=$(obj).parents("table")[0];//获得当前表格
		
		$('#updateFlightDate').html("");//每次清除累积数据
		var tId=table.rows[line].cells[1].innerText;//获取机票编号
		var company =table.rows[line].cells[5].innerText//获取航空公司
		var departurePlace=table.rows[line].cells[8].innerText;
		var arrivalPlace=table.rows[line].cells[10].innerText;
		
		//日期格式化处理
		var departureTime=table.rows[line].cells[7].innerText;
		var arrivalTime=table.rows[line].cells[9].innerText;
		var str="机票编号:"+tId+" 航空公司:"+company+"<br/>";
		str+=departurePlace+" 到  "+arrivalPlace+"<br/>";
		str+=departureTime+" 到  "+arrivalTime+"<br/>";
		$('#updateFlightDate').append(str);
		
		
	}  
	function findFlightBydate(){
		var date=document.getElementById("test2").value;
		$.ajax({
			type : "post",
			url : "findFlightByDate",
			data : {
				date : date
			},
			success : function(data) {
				
			},
			error : function() {
				alert("查询失败");
			}
		});
	}
	//退票模态框
	function returnTicket(obj){  
		var line=$(obj).parents("tr")[0].id;//获得当前行的行号
		var table=$(obj).parents("table")[0];//获得当前表格
		var tId=table.rows[line].cells[1].innerText;//退票的机票编号
		
		$('#tId2').val(tId);
	}
	//退票模态框提交请求
	function returnTicketRequest(obj){ 
		//终于获得该节点了，较繁琐，待更优方案！！！
		//console.log($(obj).parent().siblings().children("textarea")[0].value);
		var tId =$(obj).parent().siblings().children("input")[0].value;
		var reason =$(obj).parent().siblings().children("textarea")[0].value;
		var url ="returnTicket";
		$.ajax({
            url: url,
            data:{"tId":tId,"reason":reason},
            success: function(result){
              alert(result);
            }
        });
		
	}
	/* //日期转换函数
	$(Date.prototype.format = function(format){ 
    var o = { 
        "M+" : this.getMonth()+1,                   //month 
        "d+" : this.getDate(),                      //day 
        "h+" : this.getHours(),                     //hour 
        "m+" : this.getMinutes(),                   //minute 
        "s+" : this.getSeconds(),                   //second 
        "q+" : Math.floor((this.getMonth()+3)/3),  //quarter 
        "S" : this.getMilliseconds()               //millisecond 
    }

    if(/(y+)/i.test(format)) { 
        format = format.replace(RegExp.$1, 
        (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    }

    for(var k in o) { 
        if(new RegExp("("+ k +")").test(format)) { 
            format = format.replace(RegExp.$1, 
            RegExp.$1.length==1 ? o[k] : ("00"+ 
            o[k]).substr((""+ o[k]).length));
        } 
    } 
    return format; 
});
 */
	//时间选择器
	laydate.render({
		  elem: '#test5'
		  ,type: 'datetime'
		});
	laydate.render({
		elem : '#test1' //指定元素
	});
	laydate.render({
		elem : '#test2' //指定元素
	});
</script>

</html>


