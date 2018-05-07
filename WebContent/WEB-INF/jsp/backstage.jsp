<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap需要JQuery才能正常工作，所以需要导入jquery.min.js
	接着是 Bootstrap的css，里面定义了各种样式
	最后是 Bootstrap的js，用于产生交互效果，比如关闭警告框 -->
<link href="../css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="../js/jquery/2.0.0/jquery.min.js"></script>
<script src="../js/bootstrap/3.3.6/bootstrap.min.js"></script>
<!-- 日期插件 -->
<script src="../layDate-v5.0.9/laydate/laydate.js"></script>

<!-- 贴在顶部(不会消失） -->
<style>
body {
	padding-top: 70px;
}
</style>

<style>
div.well {
	margin: 10px;
}
</style>
<title>后台操作</title>
</head>

<body>
	<!-- 贴在顶部(不会消失） -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="text-light">
			<button class="btn btn-info" role="button" data-toggle="collapse"
				data-target="#select" aria-expanded="false"
				aria-controls="collapseExample" id="show">查询航班</button>
			<button class="btn btn-info" type="button" data-toggle="collapse"
				data-target="#add" aria-expanded="false"
				aria-controls="collapseExample">增加航班</button>
			<button class="btn btn-info" type="button" data-toggle="collapse"
				data-target="#update" aria-expanded="false"
				aria-controls="collapseExample">改签申请</button>
			<button class="btn btn-info" type="button" data-toggle="collapse"
				data-target="#return" aria-expanded="false"
				aria-controls="collapseExample">退票申请</button>
		</div>
	</nav>

	<div class="collapse" id="select">
		<div class="well">
			<!-- 这里先显示目前所有航班（最好按照时间排列）然后还要有精确搜索项 -->
			<div class="panel-body">
				<table class="table table-hover" id="table1">
					<thead>
						<th>序号</th>
						<th>航班编号</th>
						<th>航空公司</th>
						<th>飞机编号</th>
						<th>出发时间</th>
						<th>出发地点</th>
						<th>到达时间</th>
						<th>到达地点</th>
						<th>头等舱价格</th>
						<th>剩余座位</th>
						<th>经济舱价格</th>
						<th>剩余座位</th>
					</thead>
					<tbody id="tbody-result">

					</tbody>
				</table>
			</div>
			<div style="text-align: center">
			
				
				<button id="showlast" start="0" class="btn btn-link">上一页</button>
				<button id="shownext" start="0" class="btn btn-link">下一页</button>
				
			</div>
		</div>
	</div>

	<div class="collapse" id="add">
		<div class="well">
			<table class="table table-hover" id="table1">

				<tbody>
					<form action="addFlight" method="post">
						<tr>
							<td>航班编号:<input type="text" name="fId"></td>
							<td>选择飞机:<select id="company" name="company"
								onChange="changeAId(this)">
									<option value="0">----</option>
									<c:forEach items="${allAircraft}" var="d" varStatus="ds">
										<option>${d.key}</option>
									</c:forEach>
							</select> <select id="airName" name="airName">
									<option value="0">----</option>
							</select>
						</tr>
						<tr>
							<td>出发时间:<input type="text" name="departureTime"
								id="departureTime"></td>
							<td>出发地点:<input type="text" name="departurePlace"></td>
						</tr>
						<tr>
							<td>到达时间:<input type="text" name="arrivalTime"
								id="arrivalTime"></td>
							<td>到达地点:<input type="text" name="arrivalPlace"></td>
						</tr>
						<tr>
							<td>头等舱价格:<input type="text" name="fristclassPrice"></td>
							<td>剩余座位:<input type="text" name="fristclassCount"></td>
						</tr>
						<tr>
							<td>经济舱价格:<input type="text" name="economyPrice"></td>
							<td>剩余座位:<input type="text" name="economyCount"></td>
						<tr>
							<td><input type="submit" value="确认" /> <input type="reset"
								value="取消" /></td>
						</tr>
					</form>
				</tbody>
			</table>
		</div>
	</div>

	<div class="collapse" id="update">
		<div class="well">
			<table class="table table-hover" id="table1">
				<thead>
					<th>序号</th>
					<th>机票编号</th>
					<th>乘客手机</th>
					<th>原航班号</th>
					<th>出发地点</th>
					<th>到达地点</th>
					<th>原出发时间</th>
					<th>原到达时间</th>
					<th>改签航班编号</th>
					<th>改签出发时间</th>
					<th>改签到达时间</th>
					<th>操作</th>
				</thead>
				<tbody>
					<c:forEach items="${ticketListWithState1}" var="d"
						varStatus="status">
						<tr id="${status.index+1}">
							<td>${status.index+1}</td>
							<td>${d.tId }</td>
							<td>${d.passenger.phone }</td>
							<td>${d.flight.fId }</td>
							<td>${d.flight.departurePlace }</td>
							<td>${d.flight.arrivalPlace }</td>
							<td><fmt:formatDate value="${d.flight.departureTime }"
									pattern="yyyy-MM-dd hh:mm" /></td>
							<td><fmt:formatDate value="${d.flight.arrivalTime }"
									pattern="yyyy-MM-dd hh:mm" /></td>
							<td>${d.newflight.fId }</td>
							<td><fmt:formatDate value="${d.newflight.departureTime }"
									pattern="yyyy-MM-dd hh:mm" /></td>
							<td><fmt:formatDate value="${d.newflight.arrivalTime }"
									pattern="yyyy-MM-dd hh:mm" /></td>
							<td><button class="btn btn-success "
									onclick="AgreeUpdate(${d.tId})">同意</button>
								<button class="btn btn-warning " onclick="OpposeUpdate(${d.tId})">反对</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<div class="collapse" id="return">
		<div class="well">

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
						<th>退票理由</th>
						<th>操作</th>
					</thead>
					<tbody>
						<c:forEach items="${ticketListWithState2}" var="d"
							varStatus="status">
							<tr id="${status.index+1}">
								<td>${status.index+1}</td>
								<td>${d.tId }</td>
								<td>${d.passenger.pName }</td>
								<td>${d.passenger.sex }</td>
								<td>${d.flight.fId }</td>
								<td>${d.aircraft.company }</td>
								<td>${d.aircraft.aId }</td>
								<td><fmt:formatDate value="${d.flight.departureTime }"
										pattern="yyyy-MM-dd hh:mm" /></td>
								<td>${d.flight.departurePlace }</td>
								<td><fmt:formatDate value="${d.flight.arrivalTime }"
										pattern="yyyy-MM-dd hh:mm" /></td>
								<td>${d.flight.arrivalPlace }</td>
								<td>${d.reason }</td>
								<td><button class="btn btn-success "
										onclick="Agree(${d.tId})">同意退票</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

		</div>
	</div>
	<div style="height: 100px"></div>
</body>
<script>
//时间选择器
laydate.render({
	  elem: '#departureTime'
	  ,type: 'datetime'
	});
laydate.render({
	  elem: '#arrivalTime'
	  ,type: 'datetime'
	});
//同意改签，刷新页面
function AgreeUpdate(tId){  
	var url="updateTicket";
	$.ajax({
        url: url,
        data:{"tId":tId},
        success: function(result){
          if("true" == result){
        	  alert("成功");
          }else{
        	  alert("失败");
          }
          location.reload();
        }
    });
}
//反对改签，位置不足
function OpposeUpdate(tId){  
	var url="opposeUpdate";
	$.ajax({
        url: url,
        data:{"tId":tId},
        success: function(result){
          alert(result);
          location.reload();
        }
    });
}

//同意退票，刷新页面
function Agree(tId){  
	var url="returnTicketAgree";
	$.ajax({
        url: url,
        data:{"tId":tId},
        success: function(result){
          alert(result);
          location.reload();
        }
    });
}
//根据下拉框中的航空公司名查找该航空公司下的飞机编号
function changeAId(selectAir){
	var map =${allAircraftJson};
	var key=selectAir.value;
	if(key !=0){//值=0代表选择了默认的----
	var list = map[key];
	var option;
	airName.options.remove(airName.selectedIndex);
	for(var i=0;i<list.length;i++){
		option = new Option(list[i],list[i]);
		
	    airName.options.add(option);
	}
	//airName.disabled = false;
	}
}
//查找航班的ajax异步刷新
$("#show,#showlast,#shownext").click(function() {
	var tbody=window.document.getElementById("tbody-result");
	var start=0;
	if($(this).text()=="查询航班"){
		start=0;
	}else{
		start=$(this).attr("start");
	}
	$.ajax({
		type : "post",
		dataType : "json",
		url : "showFlight",
		data : {
			start : start
		},
		success : function(data) {
			//alert(data[0].last);
			//var json = eval("("+data+")");
			//alert(data.length)
			
			var str="";
			
			for(var i = 1; i <= data.length-1; i++){
				d=data[i];
			 var tr = "<tr>";
		       tr += "<td>" + i + "</td>";
		       tr += "<td>" + d.flight["fId"] + "</td>";
		       tr += "<td>" + d.aircraft["company"] + "</td>";
		       tr += "<td>" + d.aircraft["aId"] + "</td>";
		       tr += "<td>" + d.flight["departureTime"]+"</td>";
		       tr += "<td>" + d.flight["departurePlace"] + "</td>";
		       tr += "<td>" + d.flight["arrivalTime"] + "</td>";
		       tr += "<td>" + d.flight["arrivalPlace"] + "</td>";
		       tr += "<td>" + d.flight["fristclassPrice"] + "</td>";
		       tr += "<td>" + d.flight["fristclassCount"] + "</td>";
		       tr += "<td>" + d.flight["economyPrice"] + "</td>";
		       tr += "<td>" + d.flight["economyCount"] + "</td>";
		       tr += "</tr>";
		       str += tr; 
			}
		       tbody.innerHTML = str; 
		      $('#shownext').attr("start",data[0].start+data[0].count>data[0].last?data[0].last:data[0].start+data[0].count);
		      $('#showlast').attr("start",data[0].start-data[0].count<0?0:data[0].start-data[0].count);
			
		},
		error : function() {
			alert("查询失败")
		}
	});
});

</script>
</html>