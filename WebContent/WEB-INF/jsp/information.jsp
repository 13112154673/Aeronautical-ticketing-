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
						姓名：<input type="text"name="pName" id="pName"
							value="${onlinePassenger.pName}"><br />
						性别：${onlinePassenger.sex} <input type="button" value="更改性别" onclick="showsex()"><br />
						<span id="updateSex" style="display:none">性别:男<input
							type="radio" name="sex" value="男"> 女<input
							type="radio" name="sex" value="女"></span>
						居住城市:<input type="text" name="city" value="${onlinePassenger.city}">
						<br />
						 生日:<input type="text" name="brithday"
							id="test1" value="<fmt:formatDate value="${onlinePassenger.brithday}" pattern="yyyy-MM-dd"/>"> <br />

						<legend class="text-center">安全信息</legend>
						身份证:<input type="text" name="pId" value="${onlinePassenger.pId}">
						<br /> 
						<input type="button" value="更改密码" onclick="showpassword()"><br />
						<div id="updatePassword" style="display:none">
							请输入原密码：<input type="password" id="oldpassword" value="">
							请输入新密码：<input type="password" id="newpassword" value="">
							<input type="button" value="确认修改" onclick="hidepassword()"><br />
						</div>
						<legend class="text-center">联系方式</legend>
						手机号码:<input name="phone" id="phone" type="text"
							value="${onlinePassenger.phone}" disabled="disabled"> <br />
						电子邮箱:<input type="text" name="email"
							value="${onlinePassenger.email}"> <br />

						 <input type="submit" value="修改">
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
									<td><button class="btn btn-success " data-toggle="modal" data-target="#myModal1" onclick="editDate(this)">改签</button>
										<button class="btn btn-primary " data-toggle="modal" data-target="#myModal2" onclick="returnTicket(this)">退票</button></td>
									</c:when>
									<c:when test="${d.state==1}">
										<td>改签处理<button class="btn btn-warning "onclick="revoke(${d.tId })">撤回</button></td>
									</c:when>
									<c:when test="${d.state==2}">
										<td>退票处理<button class="btn btn-warning "onclick="revoke(${d.tId })">撤回</button></td>
									</c:when>
									<c:otherwise>
										<td>改签失败<button class="btn btn-warning "onclick="revoke(${d.tId })">撤回</button></td>
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
						改签日期：<input type="text" id="test2" name="updatedepartureTime">
						<button onclick="findFlightBydate()">查询</button> <br />
						<div id="updateFlightresult">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" id="submit1" class="btn btn-primary" onclick="updateFlight()">提交更改</button>
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
							<c:forEach items="${oldticketlist}" var="d"
								varStatus="status">
								<tr>
									<td class="ticketsId">${d.tId }</td>
									<td class="passengerName">${d.passenger.pName }</td>
									<td class="passengerSex">${d.passenger.sex }</td>
									<td class="flightId">${d.flight.fId }</td>
									<td class="aircraftCompany">${d.aircraft.company }</td>
									<td class="aircraftId">${d.aircraft.aId }</td>
									<td class="flightDepartureTime"><fmt:formatDate value="${d.flight.departureTime }" pattern="MM-dd HH:mm"/></td>
									<td class="flightDeparturePlace">${d.flight.departurePlace }</td>
									<td class="flightArrivalTime"><fmt:formatDate value="${d.flight.arrivalTime }" pattern="MM-dd HH:mm"/></td>
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
	function showsex(){
	 var d = document.getElementById("updateSex");
	 d.style.display="block";
	}
	function showpassword(){
	 var d = document.getElementById("updatePassword");
	 d.style.display="block";
	}
	function hidepassword(){
		 var d = document.getElementById("updatePassword");
		 var oldpassword = document.getElementById("oldpassword").value;
		 var newpassword = document.getElementById("newpassword").value;
		 $.ajax({
				type : "post",
				url : "updatePassword",
				data : {
					oldpassword : oldpassword,
					newpassword : newpassword
				},
				success : function(data) {
					alert(data);
				},
				error : function() {
					alert("操作错误，请重试");
					
				}
			});
		 d.style.display="none";
	}
	//改签模态框
	function editDate(obj){  
		//console.log($(obj).parents("table")[0]);//获得tr当前行,输出在浏览器的控制台.直接找到父节点
		var line=$(obj).parents("tr")[0].id;//获得当前行的行号
		var table=$(obj).parents("table")[0];//获得当前表格
		
		$('#updateFlightDate').html("");//每次清除累积数据
		var tId=table.rows[line].cells[1].innerText;//获取机票编号
		var fId =table.rows[line].cells[4].innerText//获取航空公司
		var departurePlace=table.rows[line].cells[8].innerText;
		var arrivalPlace=table.rows[line].cells[10].innerText;
		
		var departureTime=table.rows[line].cells[7].innerText;
		var arrivalTime=table.rows[line].cells[9].innerText;
		var str="<div class='text-center'>"
		str+="机票编号:<span id='oldtId'>"+tId+"</span> 航班编号:<span id='oldFId'>"+fId+"</span><br/>";
		str+="<span id='departurePlace'>"+departurePlace+"</span> 到  <span id='arrivalPlace'>"+arrivalPlace+"</span><br/>";
		str+=departureTime+" 到  "+arrivalTime+"<br/></div>";
		$('#updateFlightDate').append(str);
		
		
	}
	//改签窗口中的查询日期
	function findFlightBydate(){
		var date=document.getElementById("test2").value;
		var oldFId=$("#oldFId").text();
		console.log(oldFId);
		var departurePlace=$("#departurePlace").text();
		var arrivalPlace=$("#arrivalPlace").text();
		$('#updateFlightresult').html("");
		$.ajax({
			type : "post",
			dataType : "json",
			url : "findFlightByDate",
			data : {
				oldFId : oldFId,
				date : date,
				departurePlace : departurePlace,
				arrivalPlace : arrivalPlace
			},
			success : function(date) {
				
				var str="";
				if(0!=date.length){
					//表格头
					str+="<div class='container1'><div class='row'><div class='col-xs-4 '>航班信息</div><div class='col-xs-3 '>出发时间</div><div class='col-xs-2 '>到达时间</div><div class='col-xs-2 '>选择</div></div></div>";
					for(var i=0;i<date.length;i++){
						
						//表格体
						str+="<div class='container2'>";
						str+="<div class='row'>";
						str+="<div class='col-xs-4 '>飞机编号："+date[i]['aId']+"<br>";
						str+=date[i]['departurePlace']+" -  "+date[i]['arrivalPlace']+"</div>"
						str+="<div class='col-xs-3 '>"+date[i]['departureTime']+"</div>";
						str+="<div class='col-xs-3 '>"+date[i]['arrivalTime']+"</div>";
						str+="<div class='col-xs-2 '>&nbsp;<br><input type='radio' id='newflight' name='newflight' value="+date[i]['fId']+" ><br>&nbsp;</div>";
						str+="</div></div>";
					}
				}else{
					str+="<div class='text-center'>未查询到其他航班</div>";
				}
				$('#updateFlightresult').append(str);
			},
			error : function() {	
				alert("操作错误，请重试");
			}
			
		});
	}
	//改签窗口提交
	function updateFlight(){
		var tId=$("#oldtId").text();
		//为了区分不同的单选项，采用航班ID做name
		var choose=$("#newflight").val();
		if(null==choose){
			alert("未选择改签航班");
		}else{
			$.ajax({
				type : "post",
				url : "updateNewFlight",
				data : {
					tId : tId,
					choose : choose
				},
				success : function(date) {
					$('#myModal1').modal('hide');
					alert(date);
					location.reload();
				},
				error : function() {
					alert("请重试");
				}
			});
		}
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
              location.reload();
            }
        });
		
	}
	//撤回操作
	function revoke(tId){
		var url="resetTicket";
		$.ajax({
	        url: url,
	        data:{"tId":tId},
	        success: function(result){
	          alert(result);
	          location.reload();
	        }
	    });
	}
	
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


