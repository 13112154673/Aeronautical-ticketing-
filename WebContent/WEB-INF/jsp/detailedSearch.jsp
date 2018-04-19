<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" />
<script src="../js/jquery/2.0.0/jquery.min.js"></script>
<script src="../js/bootstrap/3.3.6/bootstrap.min.js"></script>
<!-- 日期插件 -->
<script src="../layDate-v5.0.9/laydate/laydate.js"></script>

<title>航班预定详细页面</title>
<style>
body {
	padding-top: 70px;
}

div.container1 div.row div {
	margin: 5px 0px;
	background-color: #EFEFEF;
	border: 1px solid gray;
	text-align: center;
}

div.container2 div.row div {
	margin: 5px 0px;
	background-color: #0000;
	border: 1px solid gray;
	text-align: center;
}
</style>
</head>

<body>
	<!-- 顶部导航栏 -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="text-right">
			<button class="btn btn-info" onclick="window.location='../index.jsp'">首页</button>
			<c:choose>
				<c:when test="${onlinePassenger==null}">
					<button class="btn btn-success"
						onclick="javascrtpt:window.location.href='../Passenger/jumpLogin'">登陆</button>
					<button class="btn btn-default"
						onclick="javascrtpt:window.location.href='../Passenger/jumpRegister'">注册</button>
				</c:when>
				<c:otherwise>
					<button class="btn btn-success"
						onclick="javascrtpt:window.location.href='../Passenger/jumpInformation'">个人</button>
					<button class="btn btn-default"
						onclick="javascrtpt:window.location.href='../Passenger/logout'">注销</button>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>

	<div class="container1">
		<div class="row">
			<div class="col-xs-12 ">
				<table class="table table-hover" id="table1">
					<tbody>
						<tr>
							<td><div class="form-group">
									<label for="lastname">出发地点</label> <input type="text"
										class="form-control" id="departurePlace"
										value="${departurePlace}">
								</div>
							<td><div class="form-group">
									<label for="lastname">到达地点</label> <input type="text"
										class="form-control" id="arrivalPlace" value="${arrivalPlace}">
								</div>
							<td>
								<div class="form-group">
									<label for="lastname">出发时间</label> <input type="text"
										class="form-control" id="departureTime"
										value="${departureTime}">
								</div>
							<td>
							<td>&nbsp;
								<button class="btn btn-block"
									style="background: white; border-color: #C0C0C0"
									onclick="return research()">重新搜索</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<!-- 显示结果 -->
	<div id="result"></div>
	
</body>
<script>
//进页面之前先请求一次航班数据
$(document).ready(function(){
	var departurePlace="${departurePlace}";
	var	arrivalPlace="${arrivalPlace}";
	var	departureTime="${departureTime}";
	//调用查询航班的方法
	search(departurePlace,arrivalPlace,departureTime);

})
//重新搜索，用ajax请求数据
function research(){
	
	var departurePlace=document.getElementById("departurePlace").value;
	var	arrivalPlace=document.getElementById("arrivalPlace").value;
	var	departureTime=document.getElementById("departureTime").value;
	//判断不为空
	if ("" == departurePlace || "" == arrivalPlace || "" == Time) {
		alert("信息未填完整");
		return false;
	}
	//清空原信息
	$('#result').html("");
	
	//调用
	search(departurePlace,arrivalPlace,departureTime);
}
//查询航班的方法体
function search(departurePlace,arrivalPlace,departureTime){
		$.ajax({
			type : "post",
			dataType : "json",
			url : "redetailedSearch",
			data : {
				departurePlace : departurePlace,
				arrivalPlace : arrivalPlace,
				departureTime : departureTime
			},
			success : function(date) {
				var str="";
				if(0!=date.length){
					//表格头
					str+="<div class='container1'><div class='row'><div class='col-xs-6 '>航班信息</div><div class='col-xs-2 '>头等舱</div><div class='col-xs-2 '>经济舱</div><div class='col-xs-2 '>选择</div></div></div>";
					for(var i=0;i<date.length;i++){
						
						//表格体
						str+="<div class='container2'>";
						str+="<div class='row'>";
						str+="<div class='col-xs-6 '>飞机编号："+date[i]['aId']+"<br>";
						str+=date[i]['departureTime']+" 至 "+date[i]['arrivalTime']+"<br>"
						str+=date[i]['departurePlace']+" -  "+date[i]['arrivalPlace']+"</div>"
						str+="<div class='col-xs-2 '>"+date[i]['fristclassPrice']+"<input type='radio' name="+date[i]['fId']+" value=0 ><br><br>剩余座位"+date[i]['fristclassCount']+"</div>";
						str+="<div class='col-xs-2 '>"+date[i]['economyPrice']+"<input type='radio' name="+date[i]['fId']+" value=1 ><br><br>剩余座位"+date[i]['economyCount']+"</div>";
						str+="<div class='col-xs-2 ' onclick='choose(this)' data-fId ="+date[i]['fId']+">&nbsp;<br>确认<br>&nbsp;</div>";
						str+="</div></div>";
					}
				}else{
					str+="<div class='container2'>";
					str+="<div class='row'>";
					str+="<div class='col-xs-16 '>未查询到航班</div>";
					str+="</div></div>";
				}
				$('#result').append(str);
			},
			error : function() {
				alert("查询失败");
			}
	});
}
function choose(obj){
	var fId=obj.getAttribute('data-fId');
	//为了区分不同的单选项，采用航班ID做name
	var choose=$("input[name="+fId+"]:checked").val();

	if(choose==null){
		alert("未选择舱位");
	}else{
		if(${onlinePassenger!=null}){
			$.ajax({
				type : "post",
				url : "creatTicket",
				data : {
					fId : fId,
					choose : choose
				},
				success : function(date) {
					alert("购票成功，点击后跳往个人主页");
					javascrtpt:window.location.href="../Passenger/jumpInformation";
				},
				error : function() {
					alert("请重试");
				}
			});
		}else{
			alert("请先登录");
		}
	}
};
//YY-MM-DD
laydate.render({
	elem : '#departureTime' //指定元素
});
</script>
</html>